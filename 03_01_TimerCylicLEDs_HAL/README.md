In order the timer to time correct time you have to first set the frequency on the local bus. This way is very easy to calculate the time for one timer tick.

It seams that even though there are a lot of functions including the timers there aren't any functions that set the comparator value. And it has to be done with the TIM10->CCR1 register.



