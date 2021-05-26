# asdf-hashicorp

[HashiCorp](https://www.hashicorp.com) plugin for asdf version manager

## Build History

[![Build history](https://buildstats.info/github/chart/asdf-community/asdf-hashicorp?branch=master)](https://github.com/asdf-community/asdf-hashicorp/actions)

## Installation

```bash
asdf plugin-add boundary https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add consul https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add nomad https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add packer https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add sentinel https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add serf https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add vault https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add waypoint https://github.com/asdf-community/asdf-hashicorp.git
```

## Usage

Check [asdf](https://github.com/asdf-vm/asdf) readme for instructions on how to
install & manage versions.

### Environment Variable Options
- ASDF_HASHICORP_SKIP_VERIFY: skip verifying checksums and signatures
- ASDF_HASHICORP_OVERWRITE_ARCH: forces the downloading of versions of the specified processor architecture rather it selecting versions with the processor architecture that it detects on your computer. Useful for example, for forcing M1 macs to use amd64 versions of terraform

## License

Licensed under the
[MIT license](https://github.com/asdf-community/asdf-hashicorp/blob/master/LICENSE).
