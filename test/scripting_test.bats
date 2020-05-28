#!/usr/bin/env bats

@test "'updated' in if should run the tool if updated" {
  if dart main.dart -f test/fixtures/compare/updated.yaml updated "$(cat test/fixtures/compare/snapshot)"
  then
    true
  else
    false
  fi
}

@test "'updated' in if should NOT run the tool if current" {
  if dart main.dart -f test/fixtures/compare/existing.yaml updated "$(cat test/fixtures/compare/snapshot)"
  then
    false
  else
    true
  fi
}

@test "'updated' in if should NOT run the tool if older" {
  if dart main.dart -f test/fixtures/compare/older.yaml updated "$(cat test/fixtures/compare/snapshot)"
  then
    false
  else
    true
  fi
}
