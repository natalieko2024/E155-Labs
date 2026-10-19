// DS1722.c
// Natalie Ko
// nko@g.hmc.edu
// 16 Oct 2026
// Source code for temperature sensor functions

#include "DS1722.h"
#include "STM32L432KC_SPI.h"
#include "STM32L432KC_GPIO.h"
#include "main.h"

void initSensor(void) {
    // it only starts reading when CE is high
    digitalWrite(CE_PIN, PIO_HIGH);
    // write configuration register address
    spiSendReceive(0x80);
    // write configuration value 111 oneshot=0 defaultres=001 sd=0
    spiSendReceive(0b11100010);
    digitalWrite(CE_PIN, PIO_LOW);
}

float readSensor(void) {
    // it only starts reading when CE is high
    digitalWrite(CE_PIN, PIO_HIGH);
    // write temp lsb address
    spiSendReceive(0x01);
    // send in junk to get temp out
    int lsbTemp = spiSendReceive(0x00);
    digitalWrite(CE_PIN, PIO_LOW);

    float decimalTemp = (float) ((float) lsbTemp / 256.0);

    // it only starts reading when CE is high
    digitalWrite(CE_PIN, PIO_HIGH);
    // write temp msb address
    spiSendReceive(0x02);
    // send in junk to get temp out
    int msbTemp = spiSendReceive(0x00);
    digitalWrite(CE_PIN, PIO_LOW);

    float totalTemp = (float) msbTemp + decimalTemp;

    if (totalTemp >= 128.0) {
        totalTemp = totalTemp - 128.0;
        totalTemp = -totalTemp;
    }

    return totalTemp;
}

// func to change resolution of sensor
void writeSensor(char res) {
    // it only starts reading when CE is high
    digitalWrite(CE_PIN, PIO_HIGH);
    // config register address
    spiSendReceive(0x80);
    // values in address
    spiSendReceive(res);
    digitalWrite(CE_PIN, PIO_LOW);
}
