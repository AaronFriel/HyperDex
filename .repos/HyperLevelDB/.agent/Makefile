THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: all clones HyperLevelDB

all: HyperLevelDB

clones:

HyperLevelDB:
	cd .. && autoreconf -i
	cd .. && ./configure --prefix=/opt/HyperLevelDB
	$(MAKE) -C .. -j$(THREADS)
	$(MAKE) -C .. check
