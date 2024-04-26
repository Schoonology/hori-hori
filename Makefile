OUT_DIR=build

.DEFAULT_GOAL := $(OUT_DIR)/hori-hori
.PHONY: clean install test

DART_FILES=$(shell rg --files | rg .dart)

clean:
	rm -rf .packages build

install:
	ln -sf `pwd .`/$(OUT_DIR)/hori-hori /usr/local/bin/hori-hori

test:
	dart pub run test
	bats test/scripting_test.bats

$(OUT_DIR):
	mkdir -p ./$(OUT_DIR)

$(OUT_DIR)/hori-hori: $(OUT_DIR) $(DART_FILES)
	dart pub get
	dart compile exe main.dart -o $(OUT_DIR)/hori-hori
