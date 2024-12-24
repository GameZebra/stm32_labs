When it comes to the ADC it is important to first know the electronic side so that the setting that need configuring make sence to you.


We can seperate the ADC in a couple of things, Analog signals are rearly stable in time and ADC needs time to get the value. So we will need a way to discretesize the signal. And to make it stable we're using the so called Zero Order Hold. It captures the input signal and stabilazes it for the entire duration of the mesurment. The physical implementation uses a Capacitor to hold the charge. And this capacitor needs time to charge up. So depending on the impedance of the input you may need more time to fill up the capacitor. This is done in the setting **Sampling Time**. An easy example will be that if you're neasuring the voltage of 100k ohm resisor you'll need more clock cycles than when measuring 330 ohm resistor.









