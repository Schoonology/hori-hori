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

@test "kitchen sink" {
  # Setup
  PUBSPEC="$BATS_TMPDIR/_active.yaml"
  SNAPSHOT="$BATS_TMPDIR/snapshot"

  cp test/fixtures/compare/existing.yaml "$PUBSPEC"

  dart main.dart -f "$PUBSPEC" current > $SNAPSHOT

  # Should exit with 1, i.e. false.
  if dart main.dart -f "$PUBSPEC" updated "$(cat "$SNAPSHOT")"
  then
    false
  else
    true
  fi

  # ...some work occurs, and the version is changed.
  dart main.dart -f "$PUBSPEC" bump minor

  # Should exit with 0, i.e. true. This should trigger a build somewhere.
  dart main.dart -f "$PUBSPEC" updated "$(cat "$SNAPSHOT")"

  # ...CI or somesuch updates the snapshot again.
  dart main.dart -f "$PUBSPEC" current > $SNAPSHOT

  # Should exit with 1, i.e. false.
  if dart main.dart -f "$PUBSPEC" updated "$(cat "$SNAPSHOT")"
  then
    false
  else
    true
  fi

}
