// DS1722.h
// TODO: <YOUR NAME>
// TODO: <YOUR EMAIL>
// TODO: <DATE>
// TODO: <SHORT DESCRIPTION OF WHAT THIS FILE DOES>

#ifndef DS1722_H
#define DS1722_H

#include <stdint.h>

void initSensor(int res);
char readSensor(void);
void writeSensor(char writeVal);

#endif