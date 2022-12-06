#include "graphics.h"
#include "common.h"

sf::RenderWindow window;
sf::Event event;

void print(int a) {
    printf("print %d\n", a);
}

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

void put_pixel(int x, int y, int status) {
    sf::Color color;
    if(status == 1) {
        color = sf::Color(0, 255, 0, 255);
    }
    else {
        color = sf::Color();
    }
    sf::Vertex point({static_cast<float>(x), static_cast<float>(y)}, color);
    window.draw(&point, 1, sf::Points);
}

void flush() {
    window.display();
}