THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: all clones po6

all: po6

clones:

po6:
	cd .. && autoreconf -i
	cd .. && ./configure --prefix=/opt/po6
	$(MAKE) -C .. -j$(THREADS)
	$(MAKE) -C .. check
