/**
    Main Header: Contains general defines and selected portions of CMSIS files
    @file main.h
    @author Josh Brake
    @version 1.0 10/7/2020
*/

#ifndef MAIN_H
#define MAIN_H

#include "STM32L432KC.h"

#define LED_PIN PB3 // LED pin for blinking on Port B pin 3
#define MOSI_PIN PA6
#define MISO_PIN PA7
#define SCK_PIN PA8
#define CE_PIN PA9
#define BUFF_LEN 32

#endif // MAIN_H