#!/usr/bin/env bash
# Installs the Copilot agents, prompts and skills for every workspace (user) or into one repo (workspace).
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)/.github"

usage() {
  echo "Usage: $0 user | workspace <path-to-repo>"
  exit 1
}

link() {
  local target="$2/$(basename "$1")"
  if [[ -e "$target" && ! -L "$target" ]]; then
    echo "skipped $(basename "$1") (a real file/folder already exists at $target)"
    return
  fi
  ln -sfn "$1" "$target"
  echo "linked  $(basename "$1")"
}

case "${1:-}" in
  user)
    case "$(uname -s)" in
      Darwin) PROMPTS="$HOME/Library/Application Support/Code/User/prompts" ;;
      Linux)  PROMPTS="$HOME/.config/Code/User/prompts" ;;
      *)      echo "Unsupported OS. Use: $0 workspace <path>"; exit 1 ;;
    esac
    SKILLS="$HOME/.copilot/skills"
    mkdir -p "$PROMPTS" "$SKILLS"
    for f in "$SRC"/agents/*.agent.md "$SRC"/prompts/*.prompt.md; do link "$f" "$PROMPTS"; done
    for d in "$SRC"/skills/*/; do link "${d%/}" "$SKILLS"; done
    echo "Done. Reload VS Code (Developer: Reload Window)."
    ;;
  workspace)
    [[ -n "${2:-}" && -d "$2" ]] || usage
    for sub in agents prompts skills; do
      mkdir -p "$2/.github/$sub"
      # -n: never overwrite files the target repo already has
      cp -Rn "$SRC/$sub/." "$2/.github/$sub/"
    done
    echo "Copied into $2/.github. Commit it so everyone who opens that repo gets the agents."
    ;;
  *) usage ;;
esac
