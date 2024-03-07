# 01 Overview

Welcome to the documentation for the Fourier Transformation Simulation program. This documentation provides an in-depth understanding of the program's functionality, architecture, and implementation details.

## Program Description

The Fourier Transformation Simulation program is an interactive visualization tool that allows users to explore the concept of Fourier transformation through the manipulation of sum waves. By adjusting the frequency using a slider, users can observe how different frequencies contribute to the overall waveform. When the frequency matches that of one of the individual waves, a match occurs, triggering visual and auditory feedback.

## Documentation Structure

This documentation is divided into four main sections:

1. **Fourier Transformation**: Provides a detailed explanation of Fourier transformation, including the mathematical principles behind it and its relevance to signal processing and waveform analysis.

2. **Code**: Offers insights into the architecture and implementation of the Processing code, detailing how the program simulates Fourier transformation and visualizes sum waves.

3. **Arduino**: Explains the Arduino code responsible for displaying frequency data on a 4-digit 7-segment display and its connection to the Processing sketch.

4. **Learnings**: Reflects on the learning experience gained from working on this project, discussing insights into programming, design, and practical applications of Fourier transformation.

# 02 Fourier Transformation

Fourier transformation is a mathematical technique used in signal processing and waveform analysis to decompose a complex waveform into its constituent frequencies. It is based on the concept that any periodic function can be represented as a sum of sinusoidal functions of different frequencies. Mathematically, given a function f(t) representing a waveform over time, Fourier transformation converts it into a function F(ω) representing the same waveform in the frequency domain. 

The Fourier transform F(ω) of a function f(t) is defined as:

F(ω) = ∫[−∞,+∞] f(t) * e^(-iωt) dt

where ω represents the angular frequency, e is the base of the natural logarithm, i is the imaginary unit. This integral transforms the function from the time domain to the frequency domain, providing information about the amplitude and phase of each frequency component present in the waveform.

In the context of this program, Fourier transformation is simplified for visualization purposes. The program generates a sum wave by combining multiple sinusoidal waves of varying frequencies and amplitudes. By adjusting the frequency using a slider, users can explore how different frequencies contribute to the overall waveform. When the frequency matches that of one of the individual waves, a match occurs, triggering visual and auditory feedback.

To learn more, I recommend this 3Blude1Brown video that I also used as a reference: https://www.youtube.com/watch?v=spUNpyF58BY

# 03 Code

The Processing code architecture consists of several components:

1. **Setup**: This section initializes the program, including setting up communication with Arduino, initializing fonts, waves, sliders, and audio.

2. **Draw**: The `draw()` function is called continuously by Processing to update the display. It handles drawing the background color, incrementing the phase, updating and rendering the waves, performing Fourier transformation, and checking for matches.

3. **Initialization**: Various functions are used to initialize different components of the program, such as Arduino communication, fonts, waves, sliders, and audio.

4. **Update and Rendering**: Functions like `update_waves()` and `update_sum_wave()` are responsible for updating the state of waves and the sum wave, while `render()` functions handle their visual representation on the screen.

5. **Fourier Transformation**: The `fourrier_transform()` function calculates the Fourier transform of the sum wave, approximating the integral by averaging all points on the graph. This simplified approach allows for real-time visualization of waveform decomposition.

6. **Match Handling**: The `check_match()` function checks if the current frequency matches that of any individual wave and triggers appropriate actions if a match occurs, such as changing the background color and playing sound.

# 04 Arduino

The Arduino code receives frequency data from the Processing sketch via a serial connection and displays it on a 4-digit 7-segment display. It utilizes the SevSeg library to interface with the display and `Serial` communication functions for communication with the Processing sketch. The Arduino converts the received frequency data to the appropriate format for display on the 7-segment display and updates the display accordingly.

My implementation is very similar to this tutorial I watched: https://www.youtube.com/watch?v=cMRmAgdCs3w

# 05 Learnings

Working on this project provided valuable insights into both programming and design. Through implementing Fourier transformation in an interactive visualization, I gained a deeper understanding of signal processing techniques and their practical applications. Additionally, integrating Arduino functionality into the project enhanced my skills in hardware-software interfacing and real-time communication protocols. This experience has broadened my knowledge and proficiency as both a programmer and a designer, equipping me with new tools and techniques for future projects.

