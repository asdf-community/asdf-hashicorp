#!/usr/bin/env bats

setup() {
  # Ensure a pristine homedir for tests.
  HOME="$(mktemp -d bats-asdf-hashicorp-XXXXXXXXXXXXXXX)"
  # So we don't have to do rm -rf "${HOME}".
  TEMP_HOME="${HOME}"
  asdf_gitdir="$(dirname "${BATS_TEST_FILENAME}")/../.git"
}

teardown() {
  # Further protection against removing anyone's real homedir.
  echo "${TEMP_HOME}" | grep "^/home" || rm -rf "${TEMP_HOME}"
}

@test "install command fails if the input is not version number" {
  # Since each test gets its own homedir, we need to add the right plugins.
  asdf plugin-add terraform "${asdf_gitdir}"
  run asdf install terraform ref
  [ "$status" -eq 1 ]
  echo "$output" | grep "supports release installs only"
}

@test "can install and verify earliest terraform" {
  asdf plugin-add terraform "${asdf_gitdir}"
  terraform_version="$(asdf list-all terraform | head -n1)"
  echo "installing terraform ${terraform_version}"
  run asdf install terraform "${terraform_version}"
  echo "$output" | grep "Extracting terraform archive"
}

@test "can install and verify latest terraform" {
  asdf plugin-add terraform "${asdf_gitdir}"
  terraform_version="$(asdf list-all terraform | tail -n1)"
  echo "installing terraform ${terraform_version}"
  run asdf install terraform "${terraform_version}"
  echo "$output" | grep "Extracting terraform archive"
}

@test "can install and verify earliest vault" {
  asdf plugin-add vault "${asdf_gitdir}"
  vault_version="$(asdf list-all vault | head -n1)"
  echo "installing vault ${vault_version}"
  run asdf install vault "${vault_version}"
  echo "$output" | grep "Extracting vault archive"
}

@test "can install and verify latest vault" {
  asdf plugin-add vault "${asdf_gitdir}"
  vault_version="$(asdf list-all vault | tail -n1)"
  echo "installing vault ${vault_version}"
  run asdf install vault "${vault_version}"
  echo "$output" | grep "Extracting vault archive"
}

@test "can install and verify earliest consul" {
  asdf plugin-add consul "${asdf_gitdir}"
  consul_version="$(asdf list-all consul | head -n1)"
  echo "installing consul ${consul_version}"
  run asdf install consul "${consul_version}"
  echo "$output" | grep "Extracting consul archive"
}

@test "can install and verify latest consul" {
  asdf plugin-add consul "${asdf_gitdir}"
  consul_version="$(asdf list-all consul | tail -n1)"
  echo "installing consul ${consul_version}"
  run asdf install consul "${consul_version}"
  echo "$output" | grep "Extracting consul archive"
}
