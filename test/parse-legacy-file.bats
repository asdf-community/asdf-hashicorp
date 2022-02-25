#!/usr/bin/env bats

setup() {
  ASDF_HASHICORP="$(dirname "$BATS_TEST_DIRNAME")"
  PARSE_LEGACY_FILE="${ASDF_HASHICORP}/bin/parse-legacy-file"
}

@test "supports legacy terraform version 'required_version' with strict equality" {
  local -r expected_terraform_version=0.13.7
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/main.tf"
  cat <<EOF > "${version_file}"
terraform {
  required_version = "= ${expected_terraform_version}"
}
EOF

  local -r actual_terraform_version="$("${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ "${actual_terraform_version}" == "${expected_terraform_version}" ]]
}

@test "supports legacy file .terraform-version" {
  local -r expected_terraform_version=0.13.7
  local -r tmpdir="$(mktemp -d)"
  local -r version_file="${tmpdir}/.terraform-version"

  echo "${expected_terraform_version}" > "${tmpdir}/.terraform-version"

  local -r actual_terraform_version="$("${PARSE_LEGACY_FILE}" "${version_file}")"

  [[ "${actual_terraform_version}" == "${expected_terraform_version}" ]]
}
