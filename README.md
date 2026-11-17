# dotfiles

macOS dotfiles. Each tool has its own directory, and `scripts/link.sh` symlinks the files into `~`.

| Directory | Linked to |
|---|---|
| `claude/` | `~/.claude/settings.json` |
| `ghostty/` | `~/.config/ghostty/config` |
| `git/` | `~/.config/git/{config,ignore}` |
| `mise/` | `~/.config/mise/{config.toml,mise.lock}` |
| `zsh/` | `~/.zshrc`, `~/.p10k.zsh` |

## Who manages what

| What | Managed by |
|---|---|
| Language runtimes and CLI tools | mise (`mise/config.toml`, `mise/mise.lock`) |
| GUI apps and formulae that need system libraries or services | Homebrew (`Brewfile`) |
| Config files | `scripts/link.sh` |

Each tool has exactly one owner. Do not install a tool with Homebrew if mise can manage it.

## Bootstrap a new Mac

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
git clone https://github.com/ktsu2i/dotfiles.git ~/repos/dotfiles
cd ~/repos/dotfiles
make install
exec zsh
```

`make install` runs `brew bundle`, `scripts/link.sh` and `mise install`. `link.sh` moves any existing file to `~/.dotfiles-backup/<timestamp>/` before linking, and is safe to re-run.

### Machine-local files (not in this repo)

| File | Contents |
|---|---|
| `~/.config/git/config.local` | `[user] email = ...` |
| `~/.config/ghostty/background` | `background-image = ...` and related Ghostty options |

### Manual steps

- Generate or restore SSH keys
- `gh auth login`
- Sign in to Claude Code, Raycast and other apps
- Grant accessibility and other privacy permissions in System Settings

## Daily use

Edit files in `~` as usual; they are symlinks into this repo, so `git diff` here shows the change.

To add a config, put it under a directory named after the tool, add a `link` line to `scripts/link.sh`, and run `make link`.

```sh
mise upgrade --bump   # bump pins in config.toml and mise.lock (skips releases < 7 days old)
brew upgrade
```

mise tools are pinned to exact versions, and `mise/mise.lock` records their checksums. Review the diff after `mise upgrade --bump` before committing. To take a release newer than 7 days, pin it explicitly (`mise use -g tool@x.y.z`).

Some tools replace a file instead of writing through the symlink. If `git status` stops showing your edits, check that the file in `~` is still a symlink.

## Project-only tool versions

Put `mise.local.toml` in a repository you cannot add files to. `~/.config/git/ignore` keeps it out of Git.
