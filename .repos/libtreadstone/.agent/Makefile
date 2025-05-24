THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: clones libmacaroons_clone libtreadstone_clone libmacaroons libtreadstone

clones: libmacaroons_clone libtreadstone_clone

libmacaroons_clone:
	@if [ -d libmacaroons/.git ]; then \
	echo "Using existing clone in libmacaroons"; \
	else \
	git clone https://github.com/AaronFriel/libmacaroons.git libmacaroons; \
	fi

libmacaroons: libmacaroons_clone
	cd libmacaroons && autoreconf -i && ./configure && make -j$(THREADS) && make check && make install && ldconfig

libtreadstone_clone:
	@if [ -d libtreadstone/.git ]; then \
	echo "Using existing clone in libtreadstone"; \
	else \
	git clone https://github.com/AaronFriel/libtreadstone.git libtreadstone; \
	fi

libtreadstone: libtreadstone_clone libmacaroons
	cd libtreadstone && autoreconf -i && ./configure && make -j$(THREADS) && make check && make install && ldconfig

