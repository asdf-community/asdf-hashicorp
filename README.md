# asdf-hashicorp

[HashiCorp](https://www.hashicorp.com) plugin for asdf version manager

## Build History

[![Build history](https://buildstats.info/github/chart/asdf-community/asdf-hashicorp?branch=master)](https://github.com/asdf-community/asdf-hashicorp/actions)

## Installation

```bash
asdf plugin-add boundary https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add consul https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add levant https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add nomad https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add packer https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add sentinel https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add serf https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add terraform-ls https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add tfc-agent https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add vault https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add waypoint https://github.com/asdf-community/asdf-hashicorp.git
```

## Usage

Check [asdf](https://github.com/asdf-vm/asdf) readme for instructions on how to
install & manage versions.

### Environment Variable Options
- ASDF_HASHICORP_SKIP_VERIFY: skip verifying checksums and signatures
- ASDF_HASHICORP_OVERWRITE_ARCH: force the plugin to use a specified processor architecture rather than the automatically detected value. Useful, for example, for allowing users on M1 Macs to install `amd64` binaries when there's no `arm64` binary available.
- ASDF_HASHICORP_OVERWRITE_ARCH_<specific tool>: like the previous override, but for each specific tool, e.g. ASDF_HASHICORP_OVERWRITE_ARCH_TERRAFORM. Works with ASDF_HASHICORP_OVERWRITE_ARCH, and tool-specific overrides take precedence.
- ASDF_HASHICORP_TERRAFORM_VERSION_FILE: Which `.tf`-file to examine for version constraints when using the `legacy_version_file` option in `~/.asdfrc`. Defaults to `main.tf`
- ASDF_HASHICORP_RELEASES_HOST: Specify a different host to get the binaries from. (Default is https://releases.hashicorp.com)

## License

Licensed under the
[MIT license](https://github.com/asdf-community/asdf-hashicorp/blob/master/LICENSE).
