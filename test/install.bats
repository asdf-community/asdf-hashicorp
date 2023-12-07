#!/usr/bin/env bats

setup() {
  ASDF_HASHICORP="$(dirname "$BATS_TEST_DIRNAME")"
  # If we put this in $BATS_RUN_TMPDIR, no teardown is required since it's
  # handled by bats.
  ASDF_TMPDIR="$(TMPDIR="${BATS_RUN_TMPDIR}" mktemp -t "test-${BATS_SUITE_TEST_NUMBER}.XXXXXXXXX" -d)"
  ASDF_DATA_DIR="$(bats_readlinkf "${ASDF_TMPDIR}")"
  export ASDF_DATA_DIR
  asdf plugin-add terraform "${ASDF_HASHICORP}"
  asdf plugin-add consul "${ASDF_HASHICORP}"
  asdf plugin-add vault "${ASDF_HASHICORP}"
}

@test "install command fails if the input is not version number" {
  run asdf install terraform ref
  [ "$status" -eq 1 ]
  echo "$output" | grep "supports release installs only"
}

@test "can install and verify earliest terraform" {
  terraform_version="$(asdf list-all terraform | head -n1)"
  echo "installing terraform ${terraform_version}"
  run asdf install terraform "${terraform_version}"
  echo "$output" | grep "Extracting terraform archive"
}

@test "can install and verify latest terraform" {
  terraform_version="$(asdf list-all terraform | tail -n1)"
  echo "installing terraform ${terraform_version}"
  run asdf install terraform "${terraform_version}"
  echo "$output" | grep "Extracting terraform archive"
}

@test "can install and verify earliest vault" {
  vault_version="$(asdf list-all vault | head -n1)"
  echo "installing vault ${vault_version}"
  run asdf install vault "${vault_version}"
  echo "$output" | grep "Extracting vault archive"
}

@test "can install and verify latest vault" {
  vault_version="$(asdf list-all vault | tail -n1)"
  echo "installing vault ${vault_version}"
  run asdf install vault "${vault_version}"
  echo "$output" | grep "Extracting vault archive"
}

@test "can install and verify earliest consul" {
  consul_version="$(asdf list-all consul | head -n1)"
  echo "installing consul ${consul_version}"
  run asdf install consul "${consul_version}"
  echo "$output" | grep "Extracting consul archive"
}

@test "can install and verify latest consul" {
  consul_version="$(asdf list-all consul | tail -n1)"
  echo "installing consul ${consul_version}"
  run asdf install consul "${consul_version}"
  echo "$output" | grep "Extracting consul archive"
}
