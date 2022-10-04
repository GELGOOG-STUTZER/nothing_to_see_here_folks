#include "graphics.h"
#include "common.h"

sf::RenderWindow window;
sf::Event event;


void graphics::init_window(unsigned int width, unsigned int height) {
    window.create(sf::VideoMode(width, height), "Something");
}

bool graphics::window_is_open() {
    return window.isOpen();
}

void graphics::window_clear() {
    window.clear();
}

void graphics::check_event() {
    while ( window.pollEvent(event) ) {
        if ( event.type == sf::Event::Closed ) {
            window.close();
        }
    }
}


void graphics::put_pixels(int display_info[ROW][COL]) {
    sf::Color color;
    for(int y = 0; y < ROW; ++y) {
        for(int x = 0; x < COL; ++x) {
            if(display_info[x][y] == 1) {
                color = sf::Color(0, 255, 0, 255);
            }
            else {
                color = sf::Color();
            }
            graphics::draw_pixel(x, y, color);
        }
    }
}

void graphics::draw_pixel(int x, int y, sf::Color color) {
    sf::Vertex point({static_cast<float>(x), static_cast<float>(y)}, color);
    window.draw(&point, 1, sf::Points);
}

void graphics::flush() {
    window.display();
}

extern "C" {
void init_window(unsigned int width, unsigned int height) {
    graphics::init_window(width, height);
}

int window_is_open() {
    return graphics::window_is_open();
}

void put_pixels(int display_info[ROW][COL]) {
    graphics::put_pixels(display_info);
}

void window_clear() {
    graphics::window_clear();
}

void check_event() {
    graphics::check_event();
}

void flush() {
    graphics::flush();
}
}