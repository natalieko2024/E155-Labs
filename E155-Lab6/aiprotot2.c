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