When it comes to the ADC it is important to first know the electronic side so that the setting that need configuring make sence to you.


We can seperate the ADC in a couple of things, Analog signals are rearly stable in time and ADC needs time to get the value. So we will need a way to discretesize the signal. And to make it stable we're using the so called Zero Order Hold. It captures the input signal and stabilazes it for the entire duration of the mesurment. The physical implementation uses a Capacitor to hold the charge. And this capacitor needs time to charge up. So depending on the impedance of the input you may need more time to fill up the capacitor. This is done in the setting **Sampling Time**. An easy example will be that if you're neasuring the voltage of 100k ohm resisor you'll need more clock cycles than when measuring 330 ohm resistor.

The core funciono of an ADC:
The ADC has some pre-determined descrete levels which represent the physical voltage. This is represented by the bits of the ADC the more bits the ADC has it becomes more precise but it gets slower. 

When ADC captures values
The ADC can be setted up to capture as fast as if can, or it can be software triggerd, or triggered by Timer or external interupt. Prefferably Timer Triggered

Multiplex vs standalone
the only reason to use multiplexed chaels when you have enough ADCs is energy efficiency. Appart from that the most common use of multiplexed channels is that we don't have enough stand alone ADCs.

Tips for multiplex chanels 
We should make sure we have enough time for all the channels before we initiate the next measurment. The most important measurments should be set with the highes priority (the rank with the lowest number)



