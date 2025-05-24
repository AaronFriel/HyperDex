THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: all clones libmacaroons

all: libmacaroons

clones:

libmacaroons:
	cd .. && autoreconf -i
	cd .. && ./configure --prefix=/opt/libmacaroons
	$(MAKE) -C .. -j$(THREADS)
	$(MAKE) -C .. check
