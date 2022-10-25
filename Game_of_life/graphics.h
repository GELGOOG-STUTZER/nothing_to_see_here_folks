#include <SFML/Graphics.hpp>
#include "common.h"

extern "C" void put_pixel(int x, int y, int status);

void init_window(unsigned int width, unsigned height);
bool window_is_open();
void window_clear();
void check_event();
void flush();