It is wierd how the while(1) loop is empty and still the program functions properly.

In the MX cube when doing the setup for the gpio insted of GPIO input it should be set to GPIO_EXTIx which stands for external interupt and you set up if it would be at rising or falling edge. Now that I'm looking at the oppitons in the mx_cube the x in GPIO_EXTIx stands for the pin number, but it is the same for all lanes. 
How would we differentiate between PA2 and PD2?
That calls for future experimentation.

The clock and timer pwm wre set up as in the previous examples.


In the example we're using the LL libraries






