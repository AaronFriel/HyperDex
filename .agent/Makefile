THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: all clones \
	    po6_clone e_clone busybee_clone HyperLevelDB_clone \
	    libmacaroons_clone libtreadstone_clone Replicant_clone \
	    po6 e busybee HyperLevelDB libmacaroons libtreadstone Replicant \
	    hyperdex

all: hyperdex

clones: po6_clone e_clone busybee_clone HyperLevelDB_clone \
	    libmacaroons_clone libtreadstone_clone Replicant_clone

po6_clone:
	git clone https://github.com/AaronFriel/po6.git po6 || true

po6: po6_clone
	cd po6 && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

e_clone:
	git clone https://github.com/AaronFriel/e.git e || true

e: po6 e_clone
	cd e && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

busybee_clone:
	git clone https://github.com/AaronFriel/busybee.git busybee || true

busybee: e busybee_clone
	cd busybee && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

HyperLevelDB_clone:
	git clone https://github.com/AaronFriel/HyperLevelDB.git HyperLevelDB || true

HyperLevelDB: HyperLevelDB_clone
	cd HyperLevelDB && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

libmacaroons_clone:
	git clone https://github.com/AaronFriel/libmacaroons.git libmacaroons || true

libmacaroons: libmacaroons_clone
	cd libmacaroons && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

libtreadstone_clone:
	git clone https://github.com/AaronFriel/libtreadstone.git libtreadstone || true

libtreadstone: libtreadstone_clone libmacaroons
	cd libtreadstone && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

Replicant_clone:
	git clone https://github.com/AaronFriel/Replicant.git Replicant || true

Replicant: busybee Replicant_clone
	cd Replicant && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

hyperdex: po6 e busybee HyperLevelDB libmacaroons libtreadstone Replicant
	cd .. && autoreconf -i
	cd .. && ./configure --prefix=/opt/hyperdex
	$(MAKE) -C .. -j$(THREADS)
	$(MAKE) -C .. check
