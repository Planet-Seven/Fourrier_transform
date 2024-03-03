/**********************************************************************************
 * (C) 2024 Vojtech Svoboda @ TU/e and CTU, as part of Creative Programming DBB100
 * 
 * This program simulates the Fourier transformation through an interactive 
 * visualization of sum waves. Users can explore the constituent wavelengths 
 * of a sum wave by adjusting the frequency using a slider. When the frequency 
 * matches that of one of the individual waves, a match occurs, triggering a change 
 * in the background color and playing the matching frequency as sound.
 * 
 * Fourier transformation is a mathematical technique used to decompose a complex 
 * waveform into its constituent frequencies. It is commonly employed in signal 
 * processing and waveform analysis. In essence, Fourier transformation involves 
 * multiplying a complex wave by e^if, effectively rotating it around the center 
 * of origin, followed by taking an integral of this function. This transforms 
 * a function of time into a function of frequency.
 * In this simulation, Fourier transformation is simplified by approximating 
 * the integral through the calculation of the average of all points on the graph. 
 * When random frequencies are selected, the points tend to average out, resulting 
 * in the center of mass staying close to the central point. However, when one of 
 * the constituent frequencies is matched, all peaks of the wave align on one side 
 * of the graph, noticeably shifting the center of mass.
 *
 * Arduino is connected to this program, displaying the matching frequency on a
 * seven segment display. 
 *
 * Try to observe the shift in the center of mass yourself.
 *
 * Generative AI was used to draft some parts of the documentation, but NOT the code.
 *
 * Works with Processing 4.3
 *********************************************************************************/
 
//communication with arduino
import processing.serial.*;
Serial myPort;

//audio
import processing.sound.*;
Pulse pulse;

//slider
import controlP5.*;
ControlP5 cp5;

/**********************************************************************************/

final color primary = #040910;
final color secondary = #DE16D4;

final float upper = 1;
final float lower = 0.1;

//used to map the frequency to an audible sound wave. 
final int multiplier = 4400;

final float phase_increment = 0.02;
final int amplitude = 15;
final int wave_count = 5;
final int circle_radius = 4;
final int circle_count = 300;

final int top_offset = 300;
final int wave_offset = 150;
final int left_offset = 50;
final int fourrier_pos_x = 1600;
final int fourrier_pos_y = 300;

/**********************************************************************************/

color bgColor = primary;
color circleColor = secondary;
color outlineColor = primary;

float phase = 0;

float slider_frequency = upper;

boolean toggle = false;
int match = 0;

//initialization of wave array and the sum wave object
ArrayList<Wave> waves = new ArrayList<Wave>();
Sum_wave sum_wave = new Sum_wave(100);

void setup()
{  
  fullScreen();
  initialize_ard();
  initialize_font();
  initialize_waves();
  initialize_slider();
  initialize_audio();
}

void draw()
{
  draw_color();
  increment_phase();
  update_waves();
  update_sum_wave();
  fourrier_transform();
  check_match();
}

/**********************************INITIALIZATION***********************************/

void initialize_ard()
{
  //arduino communcation
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
}

void initialize_font()
{
  //font of the frequency string
  PFont font;
  font = createFont("OCR A Extended", 100);
  textFont(font);
}

void initialize_waves()
{
  //wave initialization
  for ( int i = 0; i < wave_count; i++)
    waves.add(new Wave(i)); 
}

void initialize_slider()
{
  //slider
  cp5 = new ControlP5(this);
  cp5.addSlider("frequency").setValue(slider_frequency).setRange(lower * multiplier , upper * multiplier ).setPosition(fourrier_pos_x - 200, fourrier_pos_y + 200).setSize(400, 30); 
}

void initialize_audio()
{
  //audio initialization
  pulse = new Pulse(this);  
}

/***************************************DRAW****************************************/

void draw_color()
{
  background(bgColor);
  fill(circleColor);
  stroke(outlineColor);  
}

void increment_phase()
{
  phase += phase_increment; 
}

void update_waves()
{
  for ( int i = 0; i < waves.size(); i++ )
  {
    Wave wave = waves.get(i);
    wave.update();
    wave.render();
  } 
}

void update_sum_wave()
{ 
  sum_wave.update();
  sum_wave.render();  
}

//draw the fourrier transfrom segment
void fourrier_transform()
{
  float sum_xy [] = draw_fourr_sum_wave();
  draw_fourrier_center(sum_xy[0], sum_xy[1]);
  draw_frequency();
}

/*****************************FOURRIER TRANSFORM*********************************/

//draw the sum wave around a circular graph using a simplified fourrier transform formula
float[] draw_fourr_sum_wave()
{
  float sum_xy [] = new float [2];
  sum_xy[0] = 0; 
  sum_xy[1] = 0;
  
  for ( int i = 0; i < circle_count; i++ )
  {
    //basic trigonometry
    float angle = i*slider_frequency;
    float pos_x = sin(angle) * sum_wave.y_positions[i];
    float pos_y = cos(angle) * sum_wave.y_positions[i];
    sum_xy[0] += pos_x;
    sum_xy[1] += pos_y;
    circle(pos_x + fourrier_pos_x, pos_y + fourrier_pos_y, circle_radius);
  } 
  return sum_xy;
}

//essentialy replaces the integral in the fourrier equation
void draw_fourrier_center( float sum_x, float sum_y)
{
  float avg_x = sum_x / circle_count;
  float avg_y = sum_y / circle_count;  
  circle(avg_x + fourrier_pos_x, avg_y + fourrier_pos_y, 15);
}

//draw the text displaying frequency
void draw_frequency()
{
  textAlign(CENTER);
  text(floor(slider_frequency * multiplier) + " Hz", fourrier_pos_x, fourrier_pos_y + 500);
}

/********************************MATCH HANDLING***********************************/

void check_match()
{
  toggle = false;

  for ( Wave wave: waves)
    if (abs(slider_frequency - wave.frequency) <= 0.005 )
      handle_match(wave.number, wave.frequency);

  toggle_match();
}

//sends around information about the match
void handle_match( int wave_number, float wave_frequency )
{
  toggle = true;
  match = wave_number;
  pulse.freq(wave_frequency * multiplier);
  myPort.write(floor(wave_frequency * 255)); 
}

//slider event handler
void frequency(float value)
{
  slider_frequency = value/multiplier;
}

//toggles background and audio on match
void toggle_match()
{
  if (toggle == true)
  {
     bgColor = secondary;
     pulse.play();
  }
  else
  {
    bgColor = primary;
    pulse.stop();
  }
}
