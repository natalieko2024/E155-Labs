/*
File: Lab_6_JHB.c
Author: Josh Brake
Email: jbrake@hmc.edu
Date: 9/14/19
*/


#include "STM32L432KC.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "main.h"
#include "DS1722.h"

/////////////////////////////////////////////////////////////////
// Provided Constants and Functions
/////////////////////////////////////////////////////////////////

//Defining the web page in two chunks: everything before the current time, and everything after the current time
char* webpageStart = "<!DOCTYPE html><html><head><title>Temperature Sensor Over UART and SPI</title>\
	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
	</head>\
	<body><h1>Temperature Sensor Over UART and SPI</h1>";
char* ledStr = "<p>LED Control:</p><form action=\"ledon\"><input type=\"submit\" value=\"Turn the LED on!\"></form>\
	<form action=\"ledoff\"><input type=\"submit\" value=\"Turn the LED off!\"></form>";
char* tempRes = "<p>Temp resolution:</p><form action=\"res8bit\"><input type=\"submit\" value=\"Make resolution 8 bit\"></form>\
  <form action=\"res9bit\"><input type=\"submit\" value=\"Make resolution 9 bit\"></form>\
  <form action=\"res10bit\"><input type=\"submit\" value=\"Make resolution 10 bit\"></form>\
  <form action=\"res11bit\"><input type=\"submit\" value=\"Make resolution 11 bit\"></form>\
  <form action=\"res12bit\"><input type=\"submit\" value=\"Make resolution 12 bit\"></form>";
char* webpageEnd   = "</body></html>";

//determines whether a given character sequence is in a char array request, returning 1 if present, -1 if not present
int inString(char request[], char des[]) {
	if (strstr(request, des) != NULL) {return 1;}
	return -1;
}

int updateLEDStatus(char request[])
{
	int led_status = 0;
	// The request has been received. now process to determine whether to turn the LED on or off
	if (inString(request, "ledoff")==1) {
		digitalWrite(LED_PIN, PIO_LOW);
		led_status = 0;
	}
	else if (inString(request, "ledon")==1) {
		digitalWrite(LED_PIN, PIO_HIGH);
		led_status = 1;
	}

	return led_status;
}

int updateRes(char request[])
{
	int res = 0;
	// The request has been received. now process to determine whether to turn the LED on or off
	if (inString(request, "res8bit")==1) {
		res = 8;
	}
	else if (inString(request, "res9bit")==1) {
		res = 9;
	}
        else if (inString(request, "res10bit")==1) {
                res = 10;
        }
        else if (inString(request, "res11bit")==1) {
                res = 11;
        }
        else if (inString(request, "res12bit")==1) {
                res = 12;
        }

	return res;
}


/////////////////////////////////////////////////////////////////
// Solution Functions
/////////////////////////////////////////////////////////////////

int main(void) {
  configureFlash();
  configureClock();

  gpioEnable(GPIO_PORT_A);
  gpioEnable(GPIO_PORT_B);
  gpioEnable(GPIO_PORT_C);

  pinMode(LED_PIN, GPIO_OUTPUT);

  RCC->APB2ENR |= (RCC_APB2ENR_TIM15EN);
  initTIM(TIM15);

  USART_TypeDef * USART = initUSART(USART1_ID, 125000);

  RCC->APB2ENR |= (RCC_APB2ENR_SPI1EN);
  // we have 80MHz clock. br set by f_clk/value
  initSPI(0b101, 1, 1);

  initSensor();

  char addr = 0xE2;
  int res = 9;
  char tempStr[20];

  while(1) {
    /* Wait for ESP8266 to send a request.
    Requests take the form of '/REQ:<tag>\n', with TAG begin <= 10 characters.
    Therefore the request[] array must be able to contain 18 characters.
    */

    // Receive web request from the ESP
    char request[BUFF_LEN] = "                  "; // initialize to known value
    int charIndex = 0;
  
    // Keep going until you get end of line character
    while(inString(request, "\n") == -1) {
      // Wait for a complete request to be transmitted before processing
      while(!(USART->ISR & USART_ISR_RXNE));
      request[charIndex++] = readChar(USART);
    }

    res = updateRes(request);

    if (res == 8) {
        addr = 0xE0;
    }
    else if (res == 9) {
        addr = 0xE2;
    }
    else if (res == 10) {
        addr = 0xE4;
    }
    else if (res == 11) {
        addr = 0xE6;
    }
    else if (res == 12){
        addr = 0xE8;
    }

    writeSensor(addr);

    float temp = readSensor();
    
    // Update string with current LED state
  
    int led_status = updateLEDStatus(request);

    char ledStatusStr[20];
    if (led_status == 1)
      sprintf(ledStatusStr,"LED is on!");
    else if (led_status == 0)
      sprintf(ledStatusStr,"LED is off!");

    sprintf(tempStr, "%f C", temp);

    // finally, transmit the webpage over UART
    sendString(USART, webpageStart); // webpage header code
    sendString(USART, ledStr); // button for controlling LED
    sendString(USART, tempRes); // button for controlling resolution

    sendString(USART, "<h2>LED Status</h2>");

    sendString(USART, "<p>");
    sendString(USART, ledStatusStr);
    sendString(USART, "</p>");

    sendString(USART, "<h2>Temp Status</h2>");

    sendString(USART, "<p>");
    sendString(USART, tempStr);
    sendString(USART, "</p>");
  
    sendString(USART, webpageEnd);
  }
}