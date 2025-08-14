CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra
TARGET = ely-workspace-switcher
SOURCE = workspace-switcher.cpp

# GTK and Layer Shell packages
PKG_CONFIG_PACKAGES = gtk+-3.0 gtk-layer-shell-0 gdk-pixbuf-2.0

# Get compiler flags from pkg-config
CXXFLAGS += $(shell pkg-config --cflags $(PKG_CONFIG_PACKAGES))
LDFLAGS = $(shell pkg-config --libs $(PKG_CONFIG_PACKAGES))

# Build target
$(TARGET): $(SOURCE)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SOURCE) $(LDFLAGS)

# Clean target
clean:
	rm -f $(TARGET)

# Install target (optional)
install: $(TARGET)
	install -D $(TARGET) $(DESTDIR)/usr/local/bin/$(TARGET)

# Debug build
debug: CXXFLAGS += -g -DDEBUG
debug: $(TARGET)

.PHONY: clean install debug