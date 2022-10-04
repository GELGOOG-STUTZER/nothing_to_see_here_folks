#include <SFML/Graphics.hpp>
#include "common.h"

extern "C" void put_pixels(int pixels[ROW][COL]);

void init_window(unsigned int width, unsigned height);
bool window_is_open();
void window_clear();
void check_event();
void draw_pixel(int x, int y, sf::Color color);
void flush();