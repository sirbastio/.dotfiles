<h1 align="center">Dotfiles</h1>

## What's Included

### Zsh (Z-shell)

- **Plugin Manager**: Zinit
- **`cd` Replacement**: Zoxide
- **`ls` Replacement**: eza
- **`cat` Replacement**: bat

#### Plugins

- **Theme**: Starship
- **Completions**: zsh-completions
- **Autosuggestions**: zsh-autosuggestions
- **Completion Menu**: fzf-tab

## Other Tools

- **Terminal**: Ghostty/Warp (I keep switching between these two)
- **Package Manager**: Brew (MacOS), Pacman (WSL w/Arch)
- **CLI Tools**: curl, fd, gh, ripgrep, lazygit
- **IDE**: VS Code, Cursor, Codex, ~~Neovim~~
- **Apps**: Chrome, Notion, Obsidian, Raycast, TickTick, Outlook, Excel

## Setup

### Requirements

- git
- fzf
- stow
- zoxide
- tmux
- bat
- eza
- starship

### Steps

1. Clone the repo to the home directory `~/<user>` (recommend using ssh)
2. `mkdir .config` in the home directory `~/.config`.
   This ensures stow will not symlink the entire directory, but instead the contents
3. `cd .dotfiles` move into the repo
4. Read through the config files to understand
5. Change the git config file in `~/.dotfiles/.config/git/config` to your own
6. `cd ~/.dotfiles` move back to repo's home directory
7. `stow .` this will create symlinks into the home directory e.g. `~/.dotfiles/.config/zsh`
will now be symlinked into `~/.config`. Also, because of step 2, any extra items added to
the symlinked directories will NOT be added into `~/.dotfiles`, ensuring no changes in git will be made.
