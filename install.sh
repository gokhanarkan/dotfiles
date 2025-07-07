#!/bin/bash

# Fish-First Dotfiles Setup Script
# One-click installation for modern macOS development environment
# Author: Your Name
# Usage: curl -fsSL https://raw.githubusercontent.com/yourusername/dotfiles/main/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

print_step() {
    echo -e "${BLUE}==> $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
    exit 1
}

print_info() {
    echo -e "${CYAN}ℹ $1${NC}"
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This script is designed for macOS only."
fi

echo -e "${PURPLE}"
cat << "EOF"
 ______ _     _       _______ _          _
|  ____(_)   | |     |  _____(_)        | |
| |__   _ ___| |__   | |__    _ _ __ ___| |_
|  __| | / __| '_ \  |  __|  | | '__/ __| __|
| |    | \__ \ | | | | |     | | |  \__ \ |_
|_|    |_|___/_| |_| |_|     |_|_|  |___/\__|

EOF
echo -e "${NC}"

print_step "🐟 Starting Fish-first dotfiles installation..."
echo -e "${PURPLE}This will set up a blazing-fast development environment with:${NC}"
echo "  • Fish shell with modern plugins"
echo "  • Starship prompt (Rust-powered speed)"
echo "  • Complete development toolchain (Go, Node.js, Python, etc.)"
echo "  • Ghostty terminal optimization"
echo "  • One-click package management"
echo

# Install Xcode Command Line Tools if not installed
if ! xcode-select -p &> /dev/null; then
    print_step "Installing Xcode Command Line Tools..."
    xcode-select --install
    print_warning "Please complete the Xcode Command Line Tools installation and re-run this script."
    exit 1
else
    print_success "Xcode Command Line Tools already installed"
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    print_step "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    print_success "Homebrew already installed"
fi

# Clone or update dotfiles repository
if [ ! -d "$DOTFILES_DIR" ]; then
    print_step "📥 Cloning dotfiles repository..."
    git clone https://github.com/yourusername/dotfiles.git "$DOTFILES_DIR"
else
    print_step "🔄 Updating dotfiles repository..."
    cd "$DOTFILES_DIR" && git pull origin main
fi

cd "$DOTFILES_DIR"

# Install packages from Brewfile
print_step "📦 Installing packages with Homebrew..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Install Fish shell if not installed
if ! command -v fish &> /dev/null; then
    print_error "Fish shell installation failed. Please check Brewfile."
else
    print_success "Fish shell installed"
fi

# Install Starship prompt
if ! command -v starship &> /dev/null; then
    print_error "Starship installation failed. Please check Brewfile."
else
    print_success "Starship prompt installed"
fi

# Setup Fish configuration directory
print_step "🐟 Setting up Fish configuration..."
mkdir -p "$HOME/.config/fish"
mkdir -p "$HOME/.config/fish/functions"
mkdir -p "$HOME/.config/fish/completions"

# Create symlinks for configuration files
print_step "🔗 Creating symlinks for configuration files..."

# Backup existing files
backup_and_link() {
    local source="$DOTFILES_DIR/$1"
    local target="$HOME/$2"

    if [ -f "$target" ] || [ -L "$target" ]; then
        print_warning "Backing up existing $target to $target.backup"
        mv "$target" "$target.backup"
    fi

    if [ -f "$source" ]; then
        ln -sf "$source" "$target"
        print_success "Linked $1 -> $2"
    else
        print_warning "Source file $source not found"
    fi
}

# Fish configuration
backup_and_link "fish/config.fish" ".config/fish/config.fish"
backup_and_link "fish/fish_plugins" ".config/fish/fish_plugins"

# Starship configuration
mkdir -p "$HOME/.config"
backup_and_link "starship/starship.toml" ".config/starship.toml"

# Git configuration
backup_and_link "git/.gitconfig" ".gitconfig"
backup_and_link "git/.gitignore_global" ".gitignore_global"

# Node configuration
backup_and_link "node/.npmrc" ".npmrc"

# Ghostty configuration
if [ -d "$DOTFILES_DIR/ghostty" ]; then
    rm -rf "$HOME/.config/ghostty"
    ln -sf "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
    print_success "Linked Ghostty configuration"
fi

# Install Fisher plugin manager
print_step "🎣 Installing Fisher plugin manager..."
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Install Fish plugins from fish_plugins file
print_step "🔌 Installing Fish plugins..."
if [ -f "$HOME/.config/fish/fish_plugins" ]; then
    fish -c "fisher update"
    print_success "Fish plugins installed"
else
    print_warning "fish_plugins file not found, installing essential plugins manually..."
    fish -c "
        fisher install jethrokuan/z
        fisher install PatrickF1/fzf.fish
        fisher install franciscolourenco/done
        fisher install jorgebucaran/nvm.fish
        fisher install joseluisq/gitnow
        fisher install wfxr/forgit
        fisher install jorgebucaran/autopair.fish
        fisher install gazorby/fish-abbreviation-tips
    "
fi

# Setup development environments
print_step "🟢 Setting up Node.js environment..."
if command -v fish &> /dev/null; then
    fish -c "
        # Install latest LTS Node.js
        nvm install lts
        nvm use lts
        set -U nvm_default_version lts

        # Install global packages
        npm install -g pnpm typescript @types/node prettier eslint
    " 2>/dev/null || print_warning "Node.js setup encountered issues, please run 'nvm install lts' manually in Fish"
    print_success "Node.js environment configured"
fi

print_step "🐍 Setting up Python environment..."
if command -v pyenv &> /dev/null; then
    # Install latest Python
    LATEST_PYTHON=$(pyenv install --list | grep -E "^\s*[0-9]+\.[0-9]+\.[0-9]+$" | tail -1 | tr -d ' ')
    if [ ! -d "$HOME/.pyenv/versions/$LATEST_PYTHON" ]; then
        print_info "Installing Python $LATEST_PYTHON (this may take a few minutes)..."
        pyenv install "$LATEST_PYTHON" || print_warning "Python installation failed, you can install it manually later"
    fi
    pyenv global "$LATEST_PYTHON" 2>/dev/null || true

    # Install common packages
    pip3 install --upgrade pip poetry black isort flake8 mypy 2>/dev/null || print_warning "Some Python packages failed to install"
    print_success "Python environment configured"
fi

print_step "🔵 Setting up Go environment..."
if command -v go &> /dev/null; then
    # Install common Go tools
    go install golang.org/x/tools/gopls@latest
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    go install github.com/air-verse/air@latest
    print_success "Go environment configured"
fi

# Configure Git
print_step "⚙️ Configuring Git..."
echo "Please enter your Git configuration details:"
read -p "Full Name: " git_name
read -p "Email: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
print_success "Git configuration completed"

# Set up SSH key (optional)
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    print_step "🔑 Setting up SSH key..."
    read -p "Generate SSH key for GitHub? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ssh-keygen -t ed25519 -C "$git_email" -f "$HOME/.ssh/id_ed25519" -N ""

        # Start ssh-agent and add key
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_ed25519"

        print_success "SSH key generated at ~/.ssh/id_ed25519.pub"
        print_warning "Don't forget to add your SSH key to GitHub:"
        print_warning "https://github.com/settings/keys"
        echo
        echo -e "${CYAN}Your public key:${NC}"
        cat "$HOME/.ssh/id_ed25519.pub"
        echo
    fi
fi

# Change default shell to Fish
print_step "🐟 Setting Fish as default shell..."
FISH_PATH=$(which fish)

# Add Fish to /etc/shells if not already there
if ! grep -q "$FISH_PATH" /etc/shells 2>/dev/null; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

# Change default shell
if [ "$SHELL" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH"
    print_success "Default shell changed to Fish"
else
    print_success "Fish is already the default shell"
fi

# Final Fish configuration
print_step "🎯 Final Fish configuration..."
fish -c "
    # Set up environment variables
    set -Ux EDITOR code
    set -Ux VISUAL code
    set -Ux BROWSER open

    # Go paths
    set -Ux GOPATH \$HOME/go
    set -Ux GOBIN \$GOPATH/bin

    # Add paths
    fish_add_path \$GOBIN
    fish_add_path \$HOME/.local/bin

    # Docker settings
    set -Ux DOCKER_BUILDKIT 1
    set -Ux COMPOSE_DOCKER_CLI_BUILD 1
" 2>/dev/null || print_warning "Some Fish configuration failed, please check manually"

print_success "Fish configuration completed!"

# Install fonts for better terminal experience
print_step "🔤 Installing programming fonts..."
echo "Fonts are being installed via Homebrew (this was included in the Brewfile)"

# Final success message
echo
echo -e "${GREEN}🎉 Fish-first dotfiles installation completed successfully!${NC}"
echo
echo -e "${CYAN}🚀 Your blazing-fast development environment is ready!${NC}"
echo
echo -e "${YELLOW}What's been installed:${NC}"
echo "  🐟 Fish shell as default with modern plugins"
echo "  🚀 Starship prompt (Rust-powered)"
echo "  🎣 Fisher plugin manager with essential plugins"
echo "  📦 Complete development toolchain (Go, Node.js, Python)"
echo "  🔧 Optimized configurations for all tools"
echo "  👻 Ghostty terminal configuration"
echo
echo -e "${CYAN}Next steps:${NC}"
echo "1. ${YELLOW}Restart your terminal${NC} (new Fish session will load automatically)"
echo "2. Run ${YELLOW}'fish_config'${NC} to open the web-based configuration UI"
echo "3. Try some abbreviations: ${YELLOW}'gs'${NC} (git status), ${YELLOW}'ll'${NC} (exa list)"
echo "4. Add your SSH key to GitHub if you generated one"
echo "5. Test your development tools: ${YELLOW}'go version'${NC}, ${YELLOW}'node --version'${NC}, ${YELLOW}'python3 --version'${NC}"
echo
echo -e "${PURPLE}Fish advantages you now have:${NC}"
echo "  ⚡ 4x faster shell startup than Zsh"
echo "  🎯 Intelligent autosuggestions out-of-the-box"
echo "  🌈 Syntax highlighting by default"
echo "  📝 Abbreviations that expand as you type"
echo "  🔍 Incredible tab completions"
echo "  🧠 Smart command history"
echo
echo -e "${GREEN}Welcome to the Fish shell! 🐟${NC}"
echo -e "${CYAN}Happy coding! 🚀${NC}"
echo
echo -e "${YELLOW}Tip: Run 'update-all' anytime to update all your development tools!${NC}"
