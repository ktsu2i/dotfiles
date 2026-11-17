# dotfiles

macOS dotfiles. `scripts/link.sh` symlinks each file into `~`.

- CLI tools and runtimes: mise (`mise/config.toml`)
- GUI apps and formulae needing system libraries: Homebrew (`Brewfile`)

## Setup

Install [Homebrew](https://brew.sh), clone this repo, then:

```sh
make install
```

Existing files are moved to `~/.dotfiles-backup/` before linking.

Then:

- Create `~/.config/git/config.local` (`[user] email = ...`)
- Create `~/.config/ghostty/background` (optional)
- Run `gh auth login`
- Sign in to apps and grant privacy permissions

## Update

```sh
mise upgrade --bump   # skips releases < 7 days old
brew upgrade
```

Tools are pinned and checksummed in `mise/mise.lock`. To add a config, add a `link` line to `scripts/link.sh` and run `make link`.
