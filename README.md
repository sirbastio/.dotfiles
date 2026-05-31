# What's Included

## Zsh (Z-shell)

- **Plugin Manager**: Zinit
- **`cd` Replacement**: Zoxide
- **`ls` Replacement**: eza
- **`cat` Replacement**: bat
- **History Replacement**: Atuin

#### Plugins

- **Theme**: Starship
- **Completions**: zsh-completions
- **Autosuggestions**: zsh-autosuggestions
- **Completion Menu**: fzf-tab

## Other Tools

- **Terminal**: Ghostty
- **Package Manager**: Homebrew/Linuxbrew
- **CLI Tools**: atuin, bat, curl, eza, fnm, fzf, gh, git, lazygit, ripgrep, starship, stow, uv, zoxide
- **IDE**: VS Code, Cursor, Codex, ~~Neovim~~
- **Apps**: Chrome, Notion, Obsidian, Raycast, TickTick, Outlook, Excel

## Setup

Clone the repo and run the bootstrap script:

```
git clone git@github.com:phillipe-s/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/bootstrap.sh
```

The script supports macOS and WSL Ubuntu. Both environments use Homebrew: `/opt/homebrew` on macOS and `/home/linuxbrew/.linuxbrew` on WSL/Linux.

On Ubuntu/WSL, the script uses `apt` for OS-level prerequisites like `zsh` and the build tools Linuxbrew needs. It does not install zsh through Homebrew.

The script also creates the XDG directories, installs Homebrew/Linuxbrew if needed, runs `brew bundle`, installs Zinit into `~/.local/share/zinit/zinit.git`, links the dotfiles with `stow`, and configures Atuin's log directory.

For unattended setup:

```
./scripts/bootstrap.sh --yes
```

Use `./scripts/bootstrap.sh --help` to see optional skips for Homebrew, apt packages, Zinit, and stow.

The bootstrap script does not change your login shell automatically. If your shell is not zsh, it prints the `chsh` command to run after you have reviewed the detected zsh path.
