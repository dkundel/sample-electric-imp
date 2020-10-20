// Import Electric Imp’s WS2812 library
#require "WS2812.class.nut:3.0.0"
#require "Button.class.nut:1.2.0"

// Set up global variables
spi <- null;
leds <- null;

// Define the loop flash function
function setLedState(state) {
    local color = state ? [255,0,0] : [0,0,0];
    leds.fill(color, 0, 5).draw();
}

// Set up the SPI bus the RGB LED connects to
spi = hardware.spi257;
spi.configure(MSB_FIRST, 7500);
hardware.pin1.configure(DIGITAL_OUT, 1);

// Set up the RGB LED
leds = WS2812(spi, 30);

// Register a handler function for incoming "set.led" messages from the agent
agent.on("set.led", setLedState);

button <- Button(hardware.pin5, DIGITAL_IN_PULLDOWN);

function buttonPress() {
  server.log("Button pressed");
}

function buttonRelease() {
  server.log("Button released");
  agent.send("triggerFlow", null);
  setLedState(false);
}

button.onPress(buttonPress).onRelease(buttonRelease);