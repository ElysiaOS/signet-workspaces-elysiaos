cmake_minimum_required(VERSION 3.16)
project(workspace-switcher)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required packages
find_package(PkgConfig REQUIRED)

pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
pkg_check_modules(GDK_PIXBUF REQUIRED gdk-pixbuf-2.0)
pkg_check_modules(GTK_LAYER_SHELL REQUIRED gtk-layer-shell-0)

# Add executable
add_executable(workspace-switcher workspace-switcher.cpp)

# Include directories
target_include_directories(workspace-switcher PRIVATE 
    ${GTK3_INCLUDE_DIRS}
    ${GDK_PIXBUF_INCLUDE_DIRS}
    ${GTK_LAYER_SHELL_INCLUDE_DIRS}
)

# Link libraries
target_link_libraries(workspace-switcher 
    ${GTK3_LIBRARIES}
    ${GDK_PIXBUF_LIBRARIES}
    ${GTK_LAYER_SHELL_LIBRARIES}
)

# Compiler flags
target_compile_options(workspace-switcher PRIVATE 
    ${GTK3_CFLAGS_OTHER}
    ${GDK_PIXBUF_CFLAGS_OTHER}
    ${GTK_LAYER_SHELL_CFLAGS_OTHER}
)

# Install target
install(TARGETS workspace-switcher DESTINATION bin)