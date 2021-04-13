#!/usr/bin/env bats

@test "install command fails if the input is not version number" {
  run asdf install terraform ref
  [ "$status" -eq 1 ]
  echo "$output" | grep "supports release installs only"
}
