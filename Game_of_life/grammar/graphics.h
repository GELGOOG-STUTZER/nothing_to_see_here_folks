#include <SFML/Graphics.hpp>
#include "common.h"

extern "C" void put_pixel(int x, int y, int status);

extern "C" void print(int a);
void init_window(unsigned int width, unsigned int height);
bool window_is_open();
void window_clear();
void check_event();
void flush();