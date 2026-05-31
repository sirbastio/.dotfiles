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

Run the bootstrap script from the repo root:

```
./scripts/bootstrap.sh
```

The script supports macOS and WSL Ubuntu. Both paths use Homebrew: `/opt/homebrew` on macOS, and `/home/linuxbrew/.linuxbrew` on WSL/Linux.

Linux often defaults to Bash, so the script installs `zsh` and prints the `chsh` command to run when your login shell is not zsh.

It also installs Zinit into `~/.local/share/zinit/zinit.git`, so interactive shells only need to load it.

For unattended setup:

```
./scripts/bootstrap.sh --yes
```

Use `./scripts/bootstrap.sh --help` to see optional skips for Homebrew and stow.


### Steps

1. Clone the repo to the home directory `~/<user>` (recommend using ssh)

```
git clone git@github.com:phillipe-s/.dotfiles.git
```

2. Create the `.config` home directory. This ensures stow will not symlink the entire directory, but instead the contents

```
mkdir .config
```
3. Move into the repo

```
cd .dotfiles
```

4. Read through the config files to understand
5. Change the git config file in `~/.dotfiles/.config/git/config` to your own
6. `cd ~/.dotfiles` move back to repo's home directory
7. Create symlinks into the home directory with **stow**, e.g. `~/.dotfiles/.config/zsh` will now be symlinked into `~/.config`. Also, because of step 2, any extra items added to the symlinked directories will NOT be added into `~/.dotfiles`, ensuring no changes in git will be made.

```
stow .
```

8. Move the atuin logs directory and remove the old one if it exists.

```
atuin config set logs.dir "~/.local/share/atuin/logs" 
rm -rf ~/.atuin
```
