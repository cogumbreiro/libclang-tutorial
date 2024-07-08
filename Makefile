
BUILD_DIR = build

BUILD_SRC = $(BUILD_DIR)/CMakeCache.txt $(BUILD_DIR)/CMakeFiles

SRC = CMakeLists.txt src/CMakeLists.txt src/CToJSON.cpp src/JSONNodeDumper.cpp src/JSONNodeDumper.h

CMAKE = cmake

EXE = $(BUILD_DIR)/bin/c-to-json

DESTDIR = /usr/local
BINDIR = $(DESTDIR)/bin
SHAREDIR = $(DESTDIR)/share
GITLAB_CACHE = /tmp/gitlab-cache

all: $(EXE)

init:
	@(test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR))
	@(test -f $(BUILD_DIR)/CMakeCache.txt || cmake -DCMAKE_BUILD_TYPE=Release -S . -B $(BUILD_DIR))

$(EXE): init $(SRC)
	cmake --build $(BUILD_DIR)

gitlab-build:
	 gitlab-runner exec docker build --cache-dir=${GITLAB_CACHE} --docker-cache-dir=${GITLAB_CACHE} --docker-volumes=${GITLAB_CACHE}

gitlab: gitlab-build


install: $(EXE)
	mkdir -p $(BINDIR)
	cp -a $(BUILD_DIR)/bin/c-to-json $(BINDIR)/
	strip $(BINDIR)/c-to-json
	cp -a src/cu-to-json $(BINDIR)/
	mkdir -p $(SHAREDIR)/c-to-json
	cp -a dist-include/ $(SHAREDIR)/c-to-json/include

uninstall:
	rm -f $(BINDIR)/c-to-json
	rm -f $(BINDIR)/cu-to-json
	rm -rf $(SHAREDIR)/c-to-json

bdist:
	$(eval TMP := $(shell mktemp -d))
	$(MAKE) install DESTDIR=$(TMP)
	tar jcvf $(BUILD_DIR)/c-to-json-bin.tar.bz2 -C $(TMP) .
	rm -rf $(TMP)

clean:
	rm -f c-to-json
	rm -rf build

.PHONY: init all bindist install uninstall clean
