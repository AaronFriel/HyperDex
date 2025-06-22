THREADS ?= $(shell nproc)
ifeq ($(shell [ $(THREADS) -gt 8 ] && echo yes),yes)
THREADS := 8
endif

.PHONY: all clones \
	    po6_clone e_clone busybee_clone HyperLevelDB_clone \
	    libmacaroons_clone libtreadstone_clone Replicant_clone \
	    po6 e busybee HyperLevelDB libmacaroons libtreadstone Replicant \
	    hyperdex lint-actions

all: hyperdex

clones: po6_clone e_clone busybee_clone HyperLevelDB_clone \
	    libmacaroons_clone libtreadstone_clone Replicant_clone

po6_clone:
	@if [ -d po6/.git ]; then \
	    echo "Using existing clone in po6"; \
	else \
	    git clone https://github.com/AaronFriel/po6.git po6; \
	fi

po6: po6_clone
	cd po6 && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

e_clone:
	@if [ -d e/.git ]; then \
	    echo "Using existing clone in e"; \
	else \
	    git clone https://github.com/AaronFriel/e.git e; \
	fi

e: po6 e_clone
	cd e && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

busybee_clone:
	@if [ -d busybee/.git ]; then \
	    echo "Using existing clone in busybee"; \
	else \
	    git clone https://github.com/AaronFriel/busybee.git busybee; \
	fi

busybee: e busybee_clone
	cd busybee && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

HyperLevelDB_clone:
	@if [ -d HyperLevelDB/.git ]; then \
	    echo "Using existing clone in HyperLevelDB"; \
	else \
	    git clone https://github.com/AaronFriel/HyperLevelDB.git HyperLevelDB; \
	fi

HyperLevelDB: HyperLevelDB_clone
	cd HyperLevelDB && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

libmacaroons_clone:
	@if [ -d libmacaroons/.git ]; then \
	    echo "Using existing clone in libmacaroons"; \
	else \
	    git clone https://github.com/AaronFriel/libmacaroons.git libmacaroons; \
	fi

libmacaroons: libmacaroons_clone
	cd libmacaroons && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

libtreadstone_clone:
	@if [ -d libtreadstone/.git ]; then \
	    echo "Using existing clone in libtreadstone"; \
	else \
	    git clone https://github.com/AaronFriel/libtreadstone.git libtreadstone; \
	fi

libtreadstone: po6 e libtreadstone_clone
	cd libtreadstone && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

Replicant_clone:
	@if [ -d Replicant/.git ]; then \
	    echo "Using existing clone in Replicant"; \
	else \
	    git clone https://github.com/AaronFriel/Replicant.git Replicant; \
	fi

Replicant: busybee Replicant_clone
	cd Replicant && autoreconf -i && ./configure && make -j$(THREADS) && make install && ldconfig

hyperdex: po6 e busybee HyperLevelDB libmacaroons libtreadstone Replicant
	cd .. && autoreconf -i
	rm -rf ../target && mkdir -p ../target/man
	cd ../target && ../configure --prefix="$(pwd)/install"
	$(MAKE) -C ../target -j$(THREADS)
	$(MAKE) -C ../target check
	$(MAKE) -C ../target install

lint-actions:
	@echo "Installing actionlint"
	go install github.com/rhysd/actionlint/cmd/actionlint@latest
	@echo "Running actionlint"
	"$(shell go env GOPATH)/bin/actionlint"
