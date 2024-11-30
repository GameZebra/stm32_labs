Low Level programed
flashing red light and level activated green light using the user button


the most important thing is that the GPIO register ODR (output data register) is 2 bytes and we should use uint16_t when working with them

the bitwise operations don't have carry and there is no need to worry when doing bitwise or | that the result will affect the next bit

when deactivateing a pin we cann: get the current state and bitwise and with the inverse of the mask, thisway we do not lose any information currently held in the register

we can implement toggle function by using bitwise XOR (test ^= GPIO_Mask)


