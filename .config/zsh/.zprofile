# This file is read only on LOGIN

# Initialize Homebrew based on OS / installation path
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  # Ubuntu / Linux
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
