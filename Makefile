OUT_DIR=build

.DEFAULT_GOAL := $(OUT_DIR)/hori-hori
.PHONY: clean install test

clean:
	rm -rf .packages build

install:
	ln -sf `pwd .`/$(OUT_DIR)/hori-hori /usr/local/bin/hori-hori

test:
	pub run test
	bats test/scripting_test.bats

$(OUT_DIR):
	mkdir -p ./$(OUT_DIR)

$(OUT_DIR)/hori-hori: $(OUT_DIR) main.dart
	pub get
	dart2native main.dart -o $(OUT_DIR)/hori-hori
