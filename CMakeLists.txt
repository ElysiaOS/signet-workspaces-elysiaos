cmake_minimum_required(VERSION 3.16)
project(workspace-switcher)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --- Add your compile and link flags (like your Makefile) ---
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=x86-64-v2 -mtune=generic")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-z,x86-64-v2 -Wl,--no-as-needed")

# --- Required packages ---
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
pkg_check_modules(GDK_PIXBUF REQUIRED gdk-pixbuf-2.0)
pkg_check_modules(GTK_LAYER_SHELL REQUIRED gtk-layer-shell-0)

# --- Build executable ---
add_executable(workspace-switcher workspace-switcher.cpp)

# --- Include directories ---
target_include_directories(workspace-switcher PRIVATE 
    ${GTK3_INCLUDE_DIRS}
    ${GDK_PIXBUF_INCLUDE_DIRS}
    ${GTK_LAYER_SHELL_INCLUDE_DIRS}
)

# --- Link libraries ---
target_link_libraries(workspace-switcher 
    ${GTK3_LIBRARIES}
    ${GDK_PIXBUF_LIBRARIES}
    ${GTK_LAYER_SHELL_LIBRARIES}
)

# --- Compiler options from pkg-config ---
target_compile_options(workspace-switcher PRIVATE 
    ${GTK3_CFLAGS_OTHER}
    ${GDK_PIXBUF_CFLAGS_OTHER}
    ${GTK_LAYER_SHELL_CFLAGS_OTHER}
)

# --- Post-build command to remove .note.gnu.property section ---
add_custom_command(TARGET workspace-switcher POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} --remove-section=.note.gnu.property $<TARGET_FILE:workspace-switcher>
    COMMENT "Fixing x86-64 ISA level requirements for workspace-switcher..."
)

# --- Install target ---
install(TARGETS workspace-switcher DESTINATION bin)
