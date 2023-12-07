#!/usr/bin/env bats

setup() {
  ASDF_HASHICORP="$(dirname "$BATS_TEST_DIRNAME")"
  PARSE_LEGACY_FILE="${ASDF_HASHICORP}/bin/parse-legacy-file"
}

@test "supports legacy terraform version 'required_version' with strict equality" {
  local -r expected_terraform_version=0.13.7
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "= ${expected_terraform_version}"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "${expected_terraform_version}" ]]
}

@test "supports alternate file for terraform version constraints" {
  local -r expected_terraform_version=0.13.7
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/versions.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "= ${expected_terraform_version}"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_TERRAFORM_VERSION_FILE=versions.tf ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "${expected_terraform_version}" ]]
}

@test "supports legacy terraform version 'required_version' with strict equality, no equals literal" {
  local -r expected_terraform_version=0.13.7
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "${expected_terraform_version}"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "${expected_terraform_version}" ]]
}

@test "supports legacy file .terraform-version" {
  local -r expected_terraform_version=0.13.7
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/.terraform-version"

  echo "${expected_terraform_version}" >"${tmpdir}/.terraform-version"

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "${expected_terraform_version}" ]]
}

@test "does not support 'not equal' version constraint expressions" {
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "!= 0.13.7"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "" ]]
}

@test "does not support 'greater than' version constraint expressions" {
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "> 0.13.7"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "" ]]
}

@test "does not support 'less than' version constraint expressions" {
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "< 0.13.7"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "" ]]
}

@test "does not support squiggly arrow version constraint expressions" {
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "~> 0.13.7"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "" ]]
}

@test "does not support compound version constraint expressions" {
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "> 0.13.0, < 0.14.0"
}
EOF

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "" ]]
}

# https://github.com/asdf-community/asdf-hashicorp/pull/43#discussion_r816027246
@test 'does not get confused by multiple legacy version files for different plugins' {
  local -r expected_terraform_version=0.13.7
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF >"${version_file}"
terraform {
  required_version = "= ${expected_terraform_version}"
}
EOF

  echo 'foo' >"${tmpdir}/.packer-version"

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ ${actual_terraform_version} == "${expected_terraform_version}" ]]
}

@test "does not output error if required_version is not specified" {
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  touch "${version_file}"

  local -r actual_terraform_version="$(ASDF_HASHICORP_THIS_PLUGIN=terraform "${PARSE_LEGACY_FILE}" "${version_file}" 2>&1)"

  [[ ${actual_terraform_version} == "" ]]
}
