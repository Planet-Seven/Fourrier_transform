//credit: https://www.youtube.com/watch?v=cMRmAgdCs3w

#include "SevSeg.h"
SevSeg sevseg;

float frequency = 0; 

void setup() {
  byte numDigits = 4;
  byte digitPins[] = {10, 11, 12, 13};
  byte segmentPins[] = {9, 2, 3, 5, 6, 8, 7, 4};
  bool resistorsOnSegments = true;
  byte hardwareConfig = COMMON_CATHODE;

  Serial.begin(9600);

  sevseg.begin(hardwareConfig, numDigits, digitPins, segmentPins, resistorsOnSegments);
}
void loop() {
  if(Serial.available())
  {
    frequency = Serial.read();
    frequency = (frequency / 255 )* 4400;
  }

  sevseg.setNumber( floor(frequency) );
  sevseg.refreshDisplay();
}
