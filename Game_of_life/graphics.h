#include <SFML/Graphics.hpp>
#include <iostream>
#include "common.h"

namespace graphics {
    void init_window(unsigned int width, unsigned height);
    bool window_is_open();
    void window_clear();
    void check_event();
    void put_pixels(int pixels[ROW][COL]);
    void draw_pixel(int x, int y, sf::Color color);
    void flush();
}

extern "C" {
void init_window(unsigned int width, unsigned int height);
int window_is_open();
void put_pixels(int pixels[ROW][COL]);
void flush();
void check_event();
void window_clear();
}