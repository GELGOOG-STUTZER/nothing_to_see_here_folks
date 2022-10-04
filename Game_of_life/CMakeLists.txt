cmake_minimum_required(VERSION 3.23)
project(Game_of_life)

set(CMAKE_CXX_STANDARD 14)

find_package(SFML 2.5 COMPONENTS graphics audio REQUIRED)
add_executable(Game_of_life main.cpp logic.c graphics.cpp)
target_link_libraries(Game_of_life sfml-graphics sfml-audio)
