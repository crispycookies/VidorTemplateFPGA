

#include "Blaster.h"

static bool activityLed = true;

extern void enableFpgaClock();

void setup() {
  USBBlaster.setOutEpSize(60);
  USBBlaster.begin(activityLed);
  enableFpgaClock();
}

void loop() {

  USBBlaster.loop();
}
