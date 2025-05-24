THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: all clones libmacaroons_clone libmacaroons libtreadstone

all: libtreadstone

clones: libmacaroons_clone

libmacaroons_clone:
	@if [ -d libmacaroons/.git ]; then echo "Using existing clone in libmacaroons"; else git clone https://github.com/AaronFriel/libmacaroons.git libmacaroons; fi

libmacaroons: libmacaroons_clone
	cd libmacaroons && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

libtreadstone: libmacaroons
	cd .. && autoreconf -i
	cd .. && ./configure --prefix=/opt/libtreadstone
	$(MAKE) -C .. -j$(THREADS)
	$(MAKE) -C .. check
