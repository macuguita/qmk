// vim: set ft=c :

#include "timer.h"

RGB_MATRIX_EFFECT(time_reactive)

#ifdef RGB_MATRIX_CUSTOM_EFFECT_IMPLS

#define IDLE_BRIGHTNESS 20
#define PEAK_BRIGHTNESS 150
#define DURATION_MS     600

static uint16_t key_time[RGB_MATRIX_LED_COUNT]   = {0};
static bool     key_active[RGB_MATRIX_LED_COUNT] = {false};

bool process_record_user_rgb(uint16_t keycode, keyrecord_t *record) {
    if (record->event.pressed) {
        uint8_t row = record->event.key.row;
        uint8_t col = record->event.key.col;
        uint8_t led_index = g_led_config.matrix_co[row][col];
        if (led_index != NO_LED) {
            key_time[led_index]   = timer_read();
            key_active[led_index] = true;
        }
    }
    return true;
}

static uint8_t ease(uint8_t x) {
    return scale8(x, x);
}

static bool time_reactive(effect_params_t* params) {
    RGB_MATRIX_USE_LIMITS(led_min, led_max);
    for (uint8_t i = led_min; i < led_max; i++) {
        uint8_t v;
        if (key_active[i]) {
            uint16_t t = timer_elapsed(key_time[i]);
            if (t >= DURATION_MS) {
                key_active[i] = false;
                v = IDLE_BRIGHTNESS;
            } else {
                uint8_t x = (t * 255) / DURATION_MS;
                x = 255 - x;
                x = ease(x);
                v = IDLE_BRIGHTNESS + scale8(x, PEAK_BRIGHTNESS - IDLE_BRIGHTNESS);
            }
        } else {
            v = IDLE_BRIGHTNESS;
        }
        rgb_matrix_set_color(i, v, v, v);
    }
    return rgb_matrix_check_finished_leds(led_max);
}

#endif // RGB_MATRIX_CUSTOM_EFFECT_IMPLS
