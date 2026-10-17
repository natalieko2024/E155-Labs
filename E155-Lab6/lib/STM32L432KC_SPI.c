// STM32L432KC_SPI.c
// Natalie Ko
// nko@g.hmc.edu
// 10 Oct 2026
// Source code for SPI functions

#include "STM32L432KC_SPI.h"
#include "STM32L432KC_GPIO.h"
#include "STM32L432KC_RCC.h"

void initSPI(int br, int cpol, int cpha) {
    // Configure GPIO pins
    gpioEnable(GPIO_PORT_A);
    pinMode(MOSI_PIN, GPIO_OUTPUT);
    pinMode(MISO_PIN, GPIO_INPUT);
    pinMode(SCK_PIN, GPIO_OUTPUT);

    // Write to SPI_CR1 register
    // Configure serial clock baud rate
    SPI1->CR1 &= ~(0b111 << 3);
    SPI1->CR1 |= (br << 3);
    // Configure CPOL and CPHA
    SPI1->CR1 &= ~(0b1 << 1);
    SPI1->CR1 |= (cpol << 1);
    SPI1->CR1 &= ~(0b1 << 0);
    SPI1->CR1 |= (cpha << 0);
    // Full duplex single master single slave
    SPI1->CR1 &= ~(0b1 << 10);
    SPI1->CR1 |= (0b1 << 10);
    // LSBFIRST bit defines the frame format - data transmitted MSB first
    SPI1->CR1 &= ~(0b1 << 7);
    // Hardware NSS management (since MCU is master)
    SPI1->CR1 &= ~(0b1 << 9);
    SPI1->CR1 &= ~(0b1 << 8);   //SSI should be 1 because we are master and 0 triggers interrupt
    SPI1->CR1 |= (0b1 << 8);
    SPI1->CR2 &= ~(0b1 << 2);
    SPI1->CR2 |= (0b1 << 2);
    // MSTR bit
    SPI1->CR1 &= ~(0b1 << 2);
    SPI1->CR1 |= (0b1 << 2);

    // Write to SPI_CR2 register
    // Set DS, higher data length = more accurate
    SPI1->CR2 &= ~(0b1111 << 8);
    SPI1->CR2 |= (0b1011 << 8);
    // Set FRXTH to 1
    SPI1->CR2 &= ~(0b1 << 12);
    SPI1->CR2 |= (0b1 << 12);
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