#include <SFML/Graphics.hpp>
#include <iostream>

#define ROW 400
#define COL 400

namespace graphics {
    void init_window(unsigned int width, unsigned height);
    bool window_is_open();
    void window_clear();
    void check_event();
    void put_pixels(int **pixels);
    void draw_pixel(int x, int y, sf::Color color);
    void flush();
}

void recalc(int **a, int **b, int row, int col);

extern "C" {
void init_window(unsigned int width, unsigned int height);
int window_is_open();
void put_pixels(int **pixels);
void flush();
void check_event();
void window_clear();
}