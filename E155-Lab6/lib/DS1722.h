// DS1722.h
// Natalie Ko
// nko@g.hmc.edu
// 16 Oct 2026
// Header for temperature sensor functions

#ifndef DS1722_H
#define DS1722_H

#include <stdint.h>

void initSensor(void);
float readSensor(void);
void writeSensor(char writeVal);

#endif