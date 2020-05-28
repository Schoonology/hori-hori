.DEFAULT_GOAL := hori-hori
.PHONY: install test

OUT_DIR=build

install:
	ln -sf `pwd .`/$(OUT_DIR)/hori-hori /usr/local/bin/hori-hori

test:
	pub run test
	bats test/scripting_test.bats

$(OUT_DIR):
	mkdir -p ./$(OUT_DIR)

hori-hori: $(OUT_DIR) main.dart
	dart2native main.dart -o $(OUT_DIR)/hori-hori
