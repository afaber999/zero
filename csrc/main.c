#include <mdk.h>

static int led_pin = LED1;  // To override: make EXTRA_CFLAGS=-DLED1=5
static int led_state = 0;
static int led_pin1 = 9;  // To override: make EXTRA_CFLAGS=-DLED1=5

int main(void) {
  wdt_disable();
  
  gpio_output(led_pin);
  gpio_output(led_pin1);

  for (;;) {
    printf("LED v000: %d\n", led_state);  // Print current state to console
    gpio_write(led_pin, led_state);  // Blink an LED
    led_state = !led_state;          // Toggle state
    delay_ms(500);                   // Delay a bit
    gpio_write(led_pin1, led_state);  // Blink an LED
    delay_ms(500);                   // Delay a bit

  }

  return 0;
}
