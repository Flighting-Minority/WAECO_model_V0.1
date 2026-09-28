cmake_minimum_required(VERSION 4.2)
project(WAECO_model_V0_1)

set(CMAKE_CXX_STANDARD 20)

add_executable(WAECO_model_V0_1 Interior/main.cpp
        Interior/waeco.cpp
        Interior/waeco.h)
