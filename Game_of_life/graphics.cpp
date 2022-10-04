#include "graphics.h"
#include "common.h"

sf::RenderWindow window;
sf::Event event;


void init_window(unsigned int width, unsigned int height) {
    window.create(sf::VideoMode(width, height), "Something");
}

bool window_is_open() {
    return window.isOpen();
}

void window_clear() {
    window.clear();
}

void check_event() {
    while ( window.pollEvent(event) ) {
        if ( event.type == sf::Event::Closed ) {
            window.close();
        }
    }
}

void draw_pixel(int x, int y, sf::Color color) {
    sf::Vertex point({static_cast<float>(x), static_cast<float>(y)}, color);
    window.draw(&point, 1, sf::Points);
}

void put_pixels(int display_info[ROW][COL]) {
    sf::Color color;
    for(int y = 0; y < ROW; ++y) {
        for(int x = 0; x < COL; ++x) {
            if(display_info[x][y] == 1) {
                color = sf::Color(0, 255, 0, 255);
            }
            else {
                color = sf::Color();
            }
            draw_pixel(x, y, color);
        }
    }
}

void flush() {
    window.display();
}