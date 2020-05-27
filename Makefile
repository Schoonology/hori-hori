.DEFAULT_GOAL := hori-hori
.PHONY: install

OUT_DIR=build

install:
	ln -sf `pwd .`/$(OUT_DIR)/hori-hori /usr/local/bin/hori-hori

$(OUT_DIR):
	mkdir -p ./$(OUT_DIR)

hori-hori: $(OUT_DIR) main.dart
	dart2native main.dart -o $(OUT_DIR)/hori-hori
