#!/usr/bin/env bash
# Symlink configs in this repo into $HOME. Existing files are moved to a backup dir first.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
backup="$HOME/.dotfiles-backup/$(date +%Y%m%d%H%M%S)"

link() {
  local src="$repo/$1" rel="$2" dst="$HOME/$2"

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$backup/$(dirname "$rel")"
    mv "$dst" "$backup/$rel"
    echo "backup ~/$rel -> $backup/$rel"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link   ~/$rel -> $1"
}

link zsh/zshrc            .zshrc
link zsh/p10k.zsh         .p10k.zsh
link git/config           .config/git/config
link git/ignore           .config/git/ignore
link mise/config.toml     .config/mise/config.toml
link mise/mise.lock       .config/mise/mise.lock
link ghostty/config       .config/ghostty/config
link claude/settings.json .claude/settings.json
