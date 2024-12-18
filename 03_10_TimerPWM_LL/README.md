Cyclic LEDs where the "timing" is done using the PWM functionality wich holds the signal ON till the comparator hits and OFF afterwards untill the auto reload value.

The clocks are set up so that 10 000 ticks of the clock are 1 sec, so the resolution is finer than the HAL solution above.

The user button switches between 2 different frequencies, the second one has 2 diods that don't shut off tho be easier to debug.



