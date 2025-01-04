This program is using the idea from the previous example but on diferent target (the Nucleo board) because the DiSC 1 doesn't have serial connection trough the usb port (trhough the ST-Link).

The program consists of potentiometer that changes the duty cycle of PWM of a built-in LED.
And we will add camunication with the PC on that serial channel that will show the value of the ADC and the calculated duty cycle. I recommend to use PuTTY as the serail PC client.




