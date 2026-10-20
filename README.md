# GOX Homebrew tap

Install GOX with Homebrew on macOS or Linux, on Intel/AMD x64 or ARM64.
This tap downloads the official binaries exclusively from
[GOX Server GitHub Releases](https://github.com/gox-lang/server/releases).
Homebrew verifies each archive against the SHA-256 recorded in the formula.
No GOX binaries are stored or built in this repository.

## Install

With [Homebrew](https://brew.sh) installed and available on your PATH:

```sh
brew install gox-lang/tap/gox
gox version
```

Homebrew exposes the command through its own bin directory. GOX prepares its Go
and frontend toolchains when needed. Running projects also requires Xcode Command
Line Tools on macOS, or GCC and development headers on Linux. On Windows, use WSL.

## Update

```sh
brew update
brew upgrade gox-lang/tap/gox
```

The launcher redirects `gox update` to these instructions and disables automatic
LSP binary updates, keeping Homebrew in charge of this installation.

## Uninstall

```sh
brew uninstall gox-lang/tap/gox
```

Project files and the GOX toolchain cache are not removed.

## Maintaining the formula

After publishing a GOX Server release, update the version, four GitHub archive URLs
and their SHA-256 values in [Formula/gox.rb](Formula/gox.rb), using
`checksums.sha256` from that same release. Do not use moving `latest` URLs or mirrors.

The CI workflow installs the formula from this checkout on Linux and macOS, on both
architectures. It checks the version, update guidance, project creation, plugin
compilation, HTTP serving and uninstall. All platforms must pass before announcing
support for a new release.

## Project

- [GOX website](https://gox-lang.dev)
- [GOX Server](https://github.com/gox-lang/server)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)

## License

[MIT](LICENSE), Copyright (c) 2026 Javier Marquez.
