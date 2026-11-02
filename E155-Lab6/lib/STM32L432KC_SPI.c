// STM32L432KC_SPI.c
// Natalie Ko
// nko@g.hmc.edu
// 10 Oct 2026
// Source code for SPI functions

#include "STM32L432KC_SPI.h"
#include "STM32L432KC_GPIO.h"
#include "stm32l432xx.h"
#include "main.h"

void initSPI(int br, int cpol, int cpha) {
    // Configure GPIO pins
    pinMode(MOSI_PIN, GPIO_ALT);
    pinMode(MISO_PIN, GPIO_ALT);
    pinMode(SCK_PIN, GPIO_ALT);
    pinMode(CE_PIN, GPIO_OUTPUT);

    GPIOB->AFR[0] |=_VAL2FLD(GPIO_AFRL_AFSEL3, 0b101);
    GPIOB->AFR[0] |=_VAL2FLD(GPIO_AFRL_AFSEL4, 0b101);
    GPIOB->AFR[0] |=_VAL2FLD(GPIO_AFRL_AFSEL5, 0b101);

    // instructions in reference manual
    SPI1->CR1 = 0;

    SPI1->CR1 |= _VAL2FLD(SPI_CR1_BR, br);
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_CPOL, cpol);
    SPI1->CR1 |= _VAL2FLD(SPI_CR1_CPHA, cpha);

    SPI1->CR1 |= _VAL2FLD(SPI_CR1_MSTR, 1);

    SPI1->CR2 |= _VAL2FLD(SPI_CR2_DS, 0b0111);
    SPI1->CR2 |= _VAL2FLD(SPI_CR2_SSOE, 1);
    SPI1->CR2 |= _VAL2FLD(SPI_CR2_FRXTH, 1);

    SPI1->CR1 |= _VAL2FLD(SPI_CR1_SPE, 1);
}

char spiSendReceive(char send) {
    // only write when TXE is 1 (bc this means TXFIFO is empty)
    while (!(SPI1->SR & SPI_SR_TXE));
    *((volatile char *) (&SPI1->DR)) = send; // Write: 8-bit access, one frame
    
    //only read when RXNE is 1 (bc this means RXFIFO has stuff)
    while (!(SPI1->SR & SPI_SR_RXNE));
    char rec = *((volatile char *) (&SPI1->DR)); // Read: 8-bit access, one frame (FRXTH = 1)
    return rec;
}