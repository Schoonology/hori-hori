# Hori-Hori

An opinionated Swiss Army knife for versioning and releasing Flutter-based software.

## Installation

Currently installation is only available from source:

1. Install the Dart SDK.
2. Clone this repository.
3. Within the repo, run:
  - `make`
  - `make install` (This writes to `/usr/local/bin`, so should _not_ require `sudo`.)
4. Ensure that `/usr/local/bin` is within your `PATH`. A one-liner for this might be `echo $PATH | grep /usr/local/bin | wc -l`, which should output a 1.

## Usage

```
A Swiss Army knife for versioning and releasing Flutter-based software.

Usage: hori-hori <command> [arguments]

Global options:
-h, --help    Print this usage information.
-f, --file    Specify an alternate pubspec file.
              (defaults to "pubspec.yaml")

Available commands:
  bump      Bump version.
  current   Prints only the current package version.
  version   Print version information, then exit.

Run "hori-hori help <command>" for more information about a command.
```

## TODO

- [ ] Extend this to our other languages?

## What's with the name?

Here at ActionSprout, we like to name our services and apps after native Pacific Northwest plants. (Sprout? Geddit?) When we needed custom tools like this, it seemed only fitting that we'd use botanical tool names to do so.

The hori hori is a Japanese gardening knife, named for the onomatopoeia for "dig". In English, we should really call it a "dig dig"!
