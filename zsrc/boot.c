// Copyright (c) 2021 Cesanta
// All rights reserved

#include "mdk.h"

extern char _sbss, _ebss, _end, _eram;

static char *s_heap_start, *s_heap_end, *s_brk;

static int led_pin = LED1;  // To override: make EXTRA_CFLAGS=-DLED1=5
static int led_state = 0;
static int led_pin1 = 9;  // To override: make EXTRA_CFLAGS=-DLED1=5

static int counts = 0;

void *sbrk(int diff) {
  char *old = s_brk;
  if (&s_brk[diff] > s_heap_end) return NULL;
  s_brk += diff;
  return old;
}

void _reset(void) {
  s_heap_start = s_brk = &_end, s_heap_end = &_eram;
  for (char *p = &_sbss; p < &_ebss;) *p++ = '\0';
  soc_init();


  wdt_disable();
  
  gpio_output(led_pin);
  gpio_output(led_pin1);

  for (;;) {
    counts +=1;
    printf("LED ZIG: %d\n", led_state);  // Print current state to console
    gpio_write(led_pin, led_state);  // Blink an LED
    led_state = !led_state;          // Toggle state
    delay_ms(500);                   // Delay a bit
    gpio_write(led_pin1, led_state);  // Blink an LED
    delay_ms(500);                   // Delay a bit

  }

  for (;;) (void) 0;
}
