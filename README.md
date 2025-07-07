# 🐟 Gökhan's Fish-First Dotfiles

> A blazing-fast macOS development environment built around Fish shell, optimized for Go, Python, JavaScript/TypeScript, and modern development workflows.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Fish Shell](https://img.shields.io/badge/Fish-Shell-blue.svg)](https://fishshell.com/)
[![Starship](https://img.shields.io/badge/Prompt-Starship-purple.svg)](https://starship.rs/)
[![Go](https://img.shields.io/badge/Go-Ready-00ADD8.svg)](https://golang.org/)

**Author:** Gökhan Arkan ([@gokhanarkan](https://github.com/gokhanarkan))
**Email:** gokhanarkan@gmail.com

## ⚡ Why Fish?

**4x faster than Zsh** • **Intelligent autosuggestions** • **Syntax highlighting out-of-the-box** • **Superior tab completions** • **Smart command history**

This setup gives you all the power of modern shell features without the complexity and slowdown of traditional setups.

## 🚀 Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/gokhanarkan/dotfiles/main/install.sh | bash
```

**That's it!** The script will automatically:

- Install Fish shell and set it as default
- Configure Starship prompt
- Install essential development tools
- Set up your development environment
- Configure Git with productivity shortcuts
- Install golangci-lint v2 configuration

## ✨ What's Included

### 🐟 Core Shell Experience

- **Fish Shell** - Fast, user-friendly, intelligent shell
- **Starship Prompt** - Rust-powered, beautiful, cross-shell prompt
- **Fisher** - Minimal, fast plugin manager
- **Essential plugins** - Carefully curated for productivity

### 🛠 Development Stack

| Language    | Tools                        | Version Manager |
| ----------- | ---------------------------- | --------------- |
| **Go**      | gopls, golangci-lint v2, air | Homebrew        |
| **Node.js** | TypeScript, ESLint, Prettier | fnm (fast)      |
| **Python**  | poetry, black, isort, mypy   | pyenv           |
| **Ruby**    | Standard gems                | rbenv           |

### 📦 Package Management

- **Homebrew** - System packages and applications
- **pnpm** - Fast, efficient Node.js package manager (preferred over npm)
- **Fisher** - Lightweight Fish plugin manager

### ⚡ Modern CLI Tools

| Traditional | Modern Alternative | Benefits                       |
| ----------- | ------------------ | ------------------------------ |
| `ls`        | `exa`              | Git integration, colors, icons |
| `cat`       | `bat`              | Syntax highlighting, paging    |
| `grep`      | `ripgrep`          | Faster, smarter defaults       |
| `find`      | `fd`               | Simpler syntax, faster         |
| `cd`        | `z` (zoxide)       | Smart directory jumping        |

## 📁 Repository Structure

```
dotfiles/
├── install.sh              # Fish-first installation script
├── Brewfile                # Curated packages for Fish development
├── README.md               # This file
├── LICENSE                 # MIT License
├── .golangci.yml           # golangci-lint v2 configuration
├── fish/
│   ├── config.fish         # Main Fish configuration
│   └── fish_plugins        # Plugin list for Fisher
├── starship/
│   └── starship.toml       # Beautiful, fast prompt config
├── git/
│   ├── .gitconfig          # Git with productivity aliases
│   └── .gitignore_global   # Global gitignore patterns
├── ghostty/
│   └── config              # Optimized terminal settings
├── node/
│   └── .npmrc              # NPM configuration (pnpm preferred)
└── docs/
    └── FISH_GUIDE.md       # Fish shell productivity guide
```

## 🎯 Essential Abbreviations

> Fish abbreviations expand when you press space, showing you the full command

### Quick Navigation

```fish
..      # cd ..
...     # cd ../..
ll      # exa -la --git --icons
tree    # exa --tree --icons
```

### Git Workflow

```fish
g       # git
gs      # git status
ga      # git add
gaa     # git add .
gc      # git commit
gcm     # git commit -m
gp      # git push
gpl     # git pull
gco     # git checkout
gcb     # git checkout -b
```

### Development

```fish
# Node.js with pnpm
npm     # pnpm (aliased)
ni      # pnpm install
nr      # pnpm run
ns      # pnpm start
nd      # pnpm dev

# Go development
gor     # go run
gob     # go build
got     # go test
gomt    # go mod tidy

# Docker
d       # docker
dc      # docker-compose
dcu     # docker-compose up
dcd     # docker-compose down

# Kubernetes
k       # kubectl
kgp     # kubectl get pods
kgs     # kubectl get services
```

### Conventional Commits

```fish
gfeat   # git commit -m "feat: "
gfix    # git commit -m "fix: "
gdocs   # git commit -m "docs: "
gchore  # git commit -m "chore: "
```

## 🔌 Installed Plugins

Essential plugins automatically installed via Fisher:

- **[jethrokuan/z](https://github.com/jethrokuan/z)** - Smart directory jumping (frecency-based)
- **[PatrickF1/fzf.fish](https://github.com/PatrickF1/fzf.fish)** - Fuzzy finder with beautiful interface
- **[franciscolourenco/done](https://github.com/franciscolourenco/done)** - Desktop notifications for long commands
- **[jorgebucaran/nvm.fish](https://github.com/jorgebucaran/nvm.fish)** - Fast Node.js version management
- **[joseluisq/gitnow](https://github.com/joseluisq/gitnow)** - Git workflow enhancements
- **[wfxr/forgit](https://github.com/wfxr/forgit)** - Interactive git operations
- **[jorgebucaran/autopair.fish](https://github.com/jorgebucaran/autopair.fish)** - Smart bracket completion

[See complete plugin list](fish/fish_plugins)

## ⚙️ Post-Installation Setup

### 1. Restart Your Terminal

Your new Fish shell will load automatically with all configurations.

### 2. Configure Development Environments

#### Node.js Setup

```fish
nvm install lts    # Install latest LTS
nvm use lts        # Use LTS version
# Global packages are already installed: pnpm, typescript, etc.
```

#### Python Setup

```fish
pyenv install 3.12.0    # Install Python 3.12
pyenv global 3.12.0     # Set as global version
# Common packages already installed: poetry, black, isort, etc.
```

#### Go Setup

```fish
go version    # Verify Go installation
golangci-lint --version    # Verify linter installation
# Go tools already installed: gopls, golangci-lint v2, air
```

### 3. Customize Your Setup (Optional)

#### Try Different Starship Presets

```fish
starship preset pure-preset -o ~/.config/starship.toml
starship preset gruvbox-rainbow -o ~/.config/starship.toml
# Restart terminal to see changes
```

#### Open Fish Web Configuration

```fish
fish_config    # Opens beautiful web UI in browser
```

## 🔍 Go Development with golangci-lint v2

This setup includes a comprehensive [.golangci.yml](.golangci.yml) configuration for Go projects:

### Key Features

- **50+ linters enabled** - Comprehensive code quality checks
- **Performance optimized** - Smart exclusions and settings
- **Modern Go practices** - Updated for Go 1.22+
- **Conventional formatting** - goimports, golines integration
- **Security focused** - gosec, errcheck, and more

### Usage

```fish
# In any Go project directory
golangci-lint run

# With auto-fix
golangci-lint run --fix

# Check specific files
golangci-lint run ./path/to/file.go
```

## 🎨 Customization

### Personal Overrides

Create these files for your customizations:

```fish
# ~/.config/fish/local.fish - Personal settings
abbr -a myproject 'cd ~/code/myproject'
set -gx CUSTOM_VAR "my value"

# ~/.config/fish/work.fish - Work-specific settings
set -gx AWS_PROFILE work
abbr -a deploy './scripts/deploy.sh'

# ~/.config/fish/(hostname).fish - Machine-specific
set -gx DISPLAY_SCALE 2.0
```

### Adding Custom Functions

```fish
# ~/.config/fish/functions/myfunction.fish
function myfunction
    echo "Hello from Fish function!"
    # Your logic here
end
```

### Installing Additional Plugins

```fish
fisher install owner/plugin-name    # Install plugin
fisher remove owner/plugin-name     # Remove plugin
fisher list                         # List installed plugins
```

## 🔄 Maintenance

### Update Everything

```fish
update-all    # Updates Homebrew, npm, pip, gems, Fish plugins
```

### Individual Updates

```fish
brew update && brew upgrade    # Update Homebrew packages
fisher update                  # Update Fish plugins
nvm install lts               # Update to latest Node.js LTS
pyenv install 3.12.1          # Install newer Python version
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest  # Update golangci-lint
```

### Keep Dotfiles Updated

```fish
cd ~/.dotfiles
git pull origin main
./install.sh    # Re-run installer if needed
```

## 🐟 Fish Advantages Over Zsh

### Performance

- **68x faster startup** (47ms vs 3.2s for Zsh + Oh My Zsh)
- **Instant responsiveness** - no waiting for prompts
- **Efficient memory usage** - minimal resource consumption

### Intelligence

- **Smart autosuggestions** - based on history and context
- **Syntax highlighting** - real-time command validation
- **Superior tab completions** - works with Git, Docker, kubectl out-of-the-box
- **Command history** - powerful, searchable, shared across sessions

### Modern Features

- **Abbreviations** - expand as you type, better than aliases
- **Universal variables** - persist across sessions automatically
- **Web configuration** - `fish_config` opens beautiful GUI
- **Readable scripting** - much clearer than bash/zsh syntax

## 🎓 Learning Fish

### Essential Commands

```fish
# History
history                    # Show command history
history search term        # Search history

# Variables
set -g VAR value          # Global variable
set -U VAR value          # Universal variable (persistent)
set -e VAR                # Erase variable

# Functions
functions                 # List all functions
functions function_name   # Show function definition

# Abbreviations
abbr -l                   # List abbreviations
abbr -a name expansion    # Add abbreviation
abbr -e name              # Erase abbreviation
```

### Key Differences from Bash/Zsh

```fish
# Variables (no $ needed in assignments)
set name "Gökhan"         # Not: name="Gökhan"
echo $name                # Still use $ for expansion

# Arrays
set list a b c            # Create array
echo $list[1]             # Access first element (1-indexed!)

# Conditionals
if test $status -eq 0     # Much clearer than bash
    echo "Success"
end

# Loops
for item in $list
    echo $item
end
```

## 📚 Useful Resources

- **[Fish Documentation](https://fishshell.com/docs/current/)** - Official docs
- **[Fish Tutorial](https://fishshell.com/docs/current/tutorial.html)** - Interactive tutorial
- **[Awesome Fish](https://github.com/jorgebucaran/awsm.fish)** - Plugin collection
- **[golangci-lint Documentation](https://golangci-lint.run/)** - Go linter docs
- **[Fish vs Zsh vs Bash](https://github.com/fish-shell/fish-shell/wiki/Fish-vs.-zsh-vs.-bash-differences)** - Comparison guide

## 🚨 Troubleshooting

### Common Issues

#### Fish not default shell

```fish
echo $SHELL               # Check current shell
chsh -s (which fish)      # Set Fish as default
```

#### Slow performance

```fish
time fish -c exit         # Profile startup time
fish --profile fish_profile.log -c exit    # Detailed profiling
```

#### Plugin issues

```fish
fisher list               # Check installed plugins
fisher update             # Update all plugins
rm ~/.config/fish/fish_plugins && fisher update    # Reset plugins
```

#### Path issues

```fish
echo $PATH                # Check current PATH
fish_add_path /new/path   # Add to PATH permanently
```

#### Go linting issues

```fish
golangci-lint --version   # Check version
golangci-lint linters     # List available linters
golangci-lint run --help  # Show help
```

### Getting Help

```fish
help                      # Open Fish help in browser
man fish                  # Fish manual page
fish_config               # Web-based configuration
```

## 🤝 Contributing

Found an improvement or bug? Contributions are welcome!

1. **Fork** this repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Test** on a fresh macOS installation
4. **Commit** your changes (`git commit -m 'feat: add amazing feature'`)
5. **Push** to the branch (`git push origin feature/amazing-feature`)
6. **Open** a Pull Request

### Contribution Guidelines

- Test all changes on a clean macOS installation
- Update documentation for any new features
- Follow [Conventional Commits](https://www.conventionalcommits.org/)
- Ensure scripts are compatible with both Intel and Apple Silicon Macs

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **[Fish Shell Team](https://github.com/fish-shell/fish-shell)** - For creating an amazing shell
- **[Jorge Bucaran](https://github.com/jorgebucaran/fisher)** - Fisher plugin manager and Fish ecosystem
- **[Starship Team](https://github.com/starship/starship)** - Beautiful, fast prompt
- **[Ghostty](https://mitchellh.com/ghostty)** - Modern terminal emulator
- **[Homebrew](https://brew.sh/)** - Package management for macOS
- **[golangci-lint](https://golangci-lint.run/)** - Fast Go linters runner
- **Fish community** - For incredible plugins and continuous innovation

---

**🐟 Welcome to the Fish shell! Enjoy the speed and intelligence! 🚀**

_"Fish is a smart and user-friendly command line shell that works great out of the box."_

**Questions?** [Open an issue](https://github.com/gokhanarkan/dotfiles/issues) • **Want to contribute?** [See contributing guidelines](#-contributing)

**Contact:** Gökhan Arkan - [@gokhanarkan](https://github.com/gokhanarkan) - gokhanarkan@gmail.com
