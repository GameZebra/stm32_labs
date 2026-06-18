# ADC with DMA 

A high-performance STM32F407VGT6 project designed to demonstrate precise hardware-triggered Analog-to-Digital Conversion (ADC) with minimal CPU intervention, using Direct Memory Access (DMA).

---

## 🚀 Project Overview

This project configures **Timer 8 (TIM8)** to generate periodic update events that act as the hardware trigger for **ADC1**. The ADC samples an analog voltage from a potentiometer on **PA5** completely autonomously. 

Additionally, **Timer 1 (TIM1) Channel 4** is configured as an output on pin **PE14** to provide a visual PWM signal that can be easily monitored and verified on an oscilloscope. By utilizing a specific DMA routing technique, the ADC conversion result automatically updates the PWM duty cycle, bypassing the CPU entirely and leaving the `while(1)` loop completely empty (0% CPU utilization).

## 🛠️ Hardware Configurations

| Peripheral | Pin | Function / Connection |
| :--- | :--- | :--- |
| **ADC1** | `PA5` | Analog Input (Connected to Potentiometer) |
| **TIM8** | N/A | Internal Update Event (TRGO) used as ADC trigger |
| **TIM1_CH4** | `PE14` | Timer Output (Connected to Oscilloscope/LED) |

### Clock Configuration
* **System Clock (SYSCLK):** 96 MHz
* **Timer Clocks (APB1/APB2):** 48 MHz
* **Clock Source:** Configured using the Phase-Locked Loop (**PLL**) driven by the High-Speed Internal (**HSI**) 16 MHz oscillator.

---

## ⚙️ STM32CubeMX Setup Guide

To recreate or modify this hardware pipeline, configure the peripherals in STM32CubeMX exactly as follows:

### 1. Timer 8 (The Trigger Master)
* **Clock Source:** Internal Clock
* **Prescaler (PSC):** `48` (Brings 48 MHz down to 1 MHz clock)
* **Counter Period (ARR):** `1000` (Triggers every 1 ms / 1 kHz sampling rate)
* **Trigger Output (TRGO) Parameters:** * Master/Slave Mode: **Disable**
  * Master Output Trigger (TRGO): **Update Event** *(Crucial: This maps the timer overflow to the external trigger line)*

### 2. ADC1 (The Sampler)
* **IN5:** Check **IN5 Single-ended** (Maps to PA5)
* **ADC Settings:**
  * Resolution: **8-bit (256 levels)** *(Matches a standard PWM range)*
  * Scan Conversion Mode: **Disable**
  * Continuous Conversion Mode: **Disable** *(We want it to trigger ONLY on Timer events)*
  * DMA Continuous Requests: **ENABLE** *(Mandatory: Without this, DMA runs only once and halts)*
  * External Trigger Conversion Source: **Timer 8 Trigger Out event**
  * External Trigger Conversion Edge: **Trigger detection on the rising edge**

### 3. Timer 1 (The PWM Generator)
* **Channel 4:** **PWM Generation CH4** (Maps to PE14)
* **Counter Settings:**
  * Prescaler (PSC): `0` (Maximum speed)
  * Counter Mode: **Up**
  * Period (ARR): `255` (Gives 0-255 steps matching our 8-bit ADC resolution)

### 4. DMA Configuration (The Highway)
Navigate to the **ADC1** tab $\rightarrow$ **DMA Settings** and add a stream:
* **DMA Stream:** DMA2 Stream 0
* **Direction:** Peripheral-to-Memory
* **Priority:** High
* **Mode:** **Circular** *(Keeps the pipeline looping infinitely)*
* **Data Width (Crucial Alignment):**
  * **Peripheral:** **Byte** *(Our ADC is 8-bit, so it generates 1 byte of data)*
  * **Memory:** **Word (32-bit)** *(The destination Timer CCR4 register is a 32-bit hardware slot)*

---

## 💻 Code Integration (`main.c`)

To activate this fully hardware-automated loop, add the following initialization code to your `main.c` file inside **USER CODE BEGIN 2**:

```c
/* USER CODE BEGIN 2 */

// 1. Start TIM8 to begin generating periodic TRGO trigger signals
HAL_TIM_Base_Start(&htim8);

// 2. Start TIM1 Channel 4 in standard PWM mode
HAL_TIM_PWM_Start(&htim1, TIM_CHANNEL_4);

// 3. Start the ADC DMA stream, pointing the destination directly to the Timer's CCR4 register address
HAL_ADC_Start_DMA(&hadc1, (uint32_t*)&(htim1.Instance->CCR4), 1);

/* USER CODE END 2 */


## Architectural Concerns & Risks
While a 0% CPU pipeline is incredibly elegant, executing direct peripheral-to-peripheral transfers comes with distinct trade-offs that make it dangerous in production systems:

* Zero Data Validation / Filtering:
Because data flows directly from the silicon of the ADC to the silicon of the Timer, the CPU never reads it. You cannot apply digital filtering (like moving averages), bounds checking, or safety limits. If the analog pin reads a noise spike or an invalid voltage, that garbage data is jammed straight into your PWM output instantly.

* Asynchronous Bus Saturation:
The ADC DMA runs completely independent of the Timer's clock cycle. If the ADC updates the CCR4 register at the exact fractional nanosecond that Timer 1 is reading it to update its PWM output, it can cause glitching or unexpected pulse widths (known as register tearing), unless the register is properly shadowed/preloaded.

* Hard System Coupling:
This technique closely ties your hardware resolution together. If you decide to change your ADC resolution to 12-bit later, the values will immediately exceed the 8-bit (255) Period of your Timer, blowing past your PWM threshold and breaking your control loop entirely unless the software logic is completely rewritten.
