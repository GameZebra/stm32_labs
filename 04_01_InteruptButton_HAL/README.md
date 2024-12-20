It is wierd how the while(1) loop is empty and still the program functions properly.

In the MX cube when doing the setup for the gpio insted of GPIO input it should be set to GPIO_EXTIx which stands for external interupt and you set up if it would be at rising or falling edge. Now that I'm looking at the oppitons in the mx_cube the x in GPIO_EXTIx stands for the pin number, but it is the same for all lanes. 
How would we differentiate between PA2 and PD2?
That calls for future experimentation.

The clock and timer pwm wre set up as in the previous examples.

When using the HAL library we redifene __weak void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin). The word __weak means that it can be freely redefined.
This function is called whenever the interupt flag is turend on and saves us the thinking of the interupt flags and their clearing.

	inside we have the code that changes the value of the timer comparator.



