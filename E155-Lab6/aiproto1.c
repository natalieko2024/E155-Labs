#include "stm32l432xx.h"
#include <stdint.h>

/* Register Map Definitions */
#define DS1722_READ_LSB_ADDR    0x01
#define DS1722_READ_MSB_ADDR    0x02

/**
 * @brief  Blocking SPI transmit/receive of a single byte over STM32 SPI peripheral using CMSIS.
 * @param  SPIx Pointer to SPI peripheral (e.g., SPI1)
 * @param  tx_byte Byte to send over SPI
 * @return Byte received over SPI
 */
static uint8_t SPI_TransferByte(SPI_TypeDef *SPIx, uint8_t tx_byte) {
    /* Wait until TX register is empty (TXE flag) */
    while (!(SPIx->SR & SPI_SR_TXE));

    /* Send byte via 8-bit access to DR register */
    *(__IO uint8_t *)&SPIx->DR = tx_byte;

    /* Wait until RX FIFO has received data (RXNE flag) */
    while (!(SPIx->SR & SPI_SR_RXNE));

    /* Read and return byte from RX FIFO */
    return *(__IO uint8_t *)&SPIx->DR;
}

/**
 * @brief  Reads temperature from DS1722 sensor and returns value in degrees Celsius.
 * 
 * @param  SPIx      Pointer to initialized SPI peripheral (e.g., SPI1)
 * @param  GPIOx_CS  GPIO Port for Chip Enable / Active High Select (e.g., GPIOA)
 * @param  CS_Pin_Mask GPIO Pin Mask for Chip Enable (e.g., GPIO_ODR_OD5 or (1 << 5))
 * @return float Temperature reading in degrees Celsius
 */
float DS1722_ReadTemperature(SPI_TypeDef *SPIx, GPIO_TypeDef *GPIOx_CS, uint32_t CS_Pin_Mask) {
    uint8_t lsb = 0;
    uint8_t msb = 0;

    /* Enable SPI peripheral if disabled */
    if (!(SPIx->CR1 & SPI_CR1_SPE)) {
        SPIx->CR1 |= SPI_CR1_SPE;
    }

    /* 1. Assert CS HIGH (DS1722 uses Active-HIGH Chip Enable) */
    GPIOx_CS->BSRR = CS_Pin_Mask;

    /* 2. Send Read Address for LSB Register */
    SPI_TransferByte(SPIx, DS1722_READ_LSB_ADDR);

    /* 3. Read LSB byte (send dummy byte 0x00 to generate clock) */
    lsb = SPI_TransferByte(SPIx, 0x00);

    /* 4. Read MSB byte (address automatically increments or send dummy) */
    msb = SPI_TransferByte(SPIx, 0x00);

    /* 5. De-assert CS LOW */
    GPIOx_CS->BRR = CS_Pin_Mask;

    /* 6. Combine MSB and LSB into a 16-bit signed raw value */
    int16_t raw_temp = (int16_t)((msb << 8) | lsb);

    /* 7. Convert two's complement raw value to degrees Celsius (1 LSB = 1/256 deg C = 0.00390625) */
    return (float)raw_temp / 256.0f;
}

void SPI1_DS1722_Init(void) {
    /* 1. Enable clocks for GPIOA and SPI1 */
    RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN;
    RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;

    /* 2. Configure PA5 (SCK), PA6 (MISO), PA7 (MOSI) as Alternate Function (AF5) */
    GPIOA->MODER &= ~(GPIO_MODER_MODE5_Msk | GPIO_MODER_MODE6_Msk | GPIO_MODER_MODE7_Msk);
    GPIOA->MODER |=  (GPIO_MODER_MODE5_1 | GPIO_MODER_MODE6_1 | GPIO_MODER_MODE7_1);
    
    GPIOA->AFR[0] &= ~((0xF << GPIO_AFRL_AFSEL5_Pos) | (0xF << GPIO_AFRL_AFSEL6_Pos) | (0xF << GPIO_AFRL_AFSEL7_Pos));
    GPIOA->AFR[0] |=  ((5 << GPIO_AFRL_AFSEL5_Pos) | (5 << GPIO_AFRL_AFSEL6_Pos) | (5 << GPIO_AFRL_AFSEL7_Pos));

    /* 3. Configure PA4 as Software CS/CE (Output Mode, Active HIGH) */
    GPIOA->MODER &= ~GPIO_MODER_MODE4_Msk;
    GPIOA->MODER |=  GPIO_MODER_MODE4_0;
    GPIOA->BRR    =  GPIO_BRR_BR4; /* Default LOW */

    /* 4. Configure SPI1 */
    SPI1->CR1 = 0;
    SPI1->CR1 |= SPI_CR1_MSTR;              /* Master Mode */
    SPI1->CR1 |= SPI_CR1_CPHA;              /* CPHA = 1 (Data captured on 2nd edge) */
    SPI1->CR1 |= (0x3 << SPI_CR1_BR_Pos);   /* Baud Rate Prescaler = /16 */
    SPI1->CR1 |= SPI_CR1_SSI | SPI_CR1_SSM; /* Software Slave Management */

    /* 5. STM32L4 FIFO / Data size configuration (CR2) */
    SPI1->CR2 = 0;
    SPI1->CR2 |= (0x7 << SPI_CR2_DS_Pos);   /* 8-bit Data Size */
    SPI1->CR2 |= SPI_CR2_FRXTH;             /* FIFO threshold set to 8-bit (RXNE set when 8-bit rx) */

    /* 6. Enable SPI */
    SPI1->CR1 |= SPI_CR1_SPE;
}