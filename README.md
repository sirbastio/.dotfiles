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

## Personal Tools

- **Terminal**: Ghostty
- **Package Manager**: Homebrew/Linuxbrew
- **CLI Tools**: Check Brewfile
- **IDE**: Neovim, VS Code, Cursor, Codex
- **Apps**: Chrome, Notion, Obsidian, Raycast, TickTick, Outlook, Excel

## Setup

Clone the repo and run the bootstrap script:

```
git clone git@github.com:phillipe-s/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/bootstrap.sh
```

Alternatively, clone over HTTPS if SSH access is not configured:

```
git clone https://github.com/phillipe-s/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/bootstrap.sh
```

The script supports Apple silicon macOS and Ubuntu (including Ubuntu on WSL). Other macOS architectures and Linux distributions exit before making changes. Both environments use Homebrew: `/opt/homebrew` on macOS and `/home/linuxbrew/.linuxbrew` on Ubuntu.

On Ubuntu/WSL, the script uses `apt` for OS-level prerequisites like `zsh` and the build tools Linuxbrew needs. It does not install zsh through Homebrew.

The script also creates the XDG directories, installs Homebrew/Linuxbrew if needed, runs `brew bundle`, installs Zinit into `~/.local/share/zinit/zinit.git`, links the dotfiles with `stow`, and configures Atuin's log directory. Zinit downloads the configured Zsh plugins when a new shell first starts, and Neovim installs its plugins on first launch.

Stow does not overwrite conflicting files. If the target paths already contain unmanaged dotfiles, move or merge them before running the bootstrap again.

For unattended setup:

```
./scripts/bootstrap.sh --yes
```

Use `./scripts/bootstrap.sh --help` to see optional skips   for Homebrew, apt packages, Zinit, and stow.

The bootstrap script does not change your login shell automatically. If your shell is not zsh, it prints the `chsh` command to run after you have reviewed the detected zsh path.
