LDFLAGS=-stdlib=libc++

BUILD_DIR = build

BUILD_SRC = $(BUILD_DIR)/CMakeCache.txt $(BUILD_DIR)/CMakeFiles

SRC = CMakeLists.txt src/CMakeLists.txt src/Main.cpp

CMAKE = cmake

EXE = $(BUILD_DIR)/bin/hello-world

EXTRA =

all: $(EXE)

init:
	@(test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR))
	(test -f $(BUILD_DIR)/CMakeCache.txt || cmake $(EXTRA) -DCMAKE_BUILD_TYPE=Release -S . -B $(BUILD_DIR))

$(EXE): init $(SRC)
	cmake --build $(BUILD_DIR)

clean:
	rm -rf build

.PHONY: init all clean
