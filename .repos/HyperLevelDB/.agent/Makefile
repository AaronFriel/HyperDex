THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: clones HyperLevelDB_clone HyperLevelDB

clones: HyperLevelDB_clone

HyperLevelDB_clone:
	@if [ -d HyperLevelDB/.git ]; then \
	echo "Using existing clone in HyperLevelDB"; \
	else \
	git clone https://github.com/AaronFriel/HyperLevelDB.git HyperLevelDB; \
	fi

HyperLevelDB: HyperLevelDB_clone
	cd HyperLevelDB && autoreconf -i && ./configure && make -j$(THREADS) && make check && make install && ldconfig

