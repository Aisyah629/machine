#include "nesC.h"

module NesCSensor {
  uses {
    interface Leds;
    interface Timer<TMilli> as PollTimer;
    interface AmbientLight;
  }
}

implementation {
  task void processSensorData();
  
  async void Boot.booted() {
    call Leds.init();
    call PollTimer.startPeriodic(1000);
  }

  async event void PollTimer.fired() {
    post processSensorData();
  }

  task void processSensorData() {
    uint16_t lightLevel;
    call AmbientLight.get() -> val;
    lightLevel = val;
    if (lightLevel > 512) {
      call Leds.set(0xFF);
    } else {
      call Leds.set(0x00);
    }
  }

  async event void AmbientLight.getDone(error_t result, uint16_t value) {
    if (result == SUCCESS) {
      // Light level captured successfully
    }
  }
}
