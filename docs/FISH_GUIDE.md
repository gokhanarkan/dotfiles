# 🐟 Fish Shell Productivity Guide

> A comprehensive guide to mastering Fish shell for maximum development productivity

## Table of Contents

1. [Fish Shell Basics](#fish-shell-basics)
2. [Abbreviations vs Aliases](#abbreviations-vs-aliases)
3. [Universal Variables](#universal-variables)
4. [Functions and Scripts](#functions-and-scripts)
5. [Tab Completions](#tab-completions)
6. [History and Search](#history-and-search)
7. [Plugin Development](#plugin-development)
8. [Advanced Tips and Tricks](#advanced-tips-and-tricks)

## Fish Shell Basics

### Why Fish is Different

Fish (Friendly Interactive Shell) is designed to be user-friendly out of the box. Unlike bash or zsh, Fish provides:

- **Syntax highlighting** - Commands are colored as you type
- **Autosuggestions** - Gray text suggests completions based on history
- **Tab completions** - Rich completions for commands and their options
- **Web-based configuration** - `fish_config` opens a GUI in your browser

### Essential Fish Commands

```fish
# Get help
help                    # Opens Fish documentation in browser
help set               # Help for specific command
man fish               # Manual page

# Configuration
fish_config            # Web-based configuration GUI
fish_update_completions  # Refresh completions from man pages

# Variables
set                    # List all variables
set -x VAR value       # Export variable
set -g VAR value       # Global variable
set -U VAR value       # Universal variable (persistent)
set -e VAR             # Erase variable

# Functions
functions              # List all functions
functions -e name      # Erase function
```

### Fish vs Bash/Zsh Syntax

#### Variables

```fish
# Fish (cleaner)
set name "John Doe"
set -x PATH $PATH /new/path
echo $name

# Bash/Zsh
name="John Doe"
export PATH="$PATH:/new/path"
echo $name
```

#### Arrays (Lists in Fish)

```fish
# Fish (1-indexed, space-separated)
set fruits apple banana orange
echo $fruits[1]        # apple
echo $fruits[2..3]     # banana orange
set fruits $fruits grape  # append

# Bash (0-indexed, different syntax)
fruits=("apple" "banana" "orange")
echo ${fruits[0]}      # apple
fruits+=("grape")      # append
```

#### Conditionals

```fish
# Fish (readable)
if test $status -eq 0
    echo "Success"
else if test $status -eq 1
    echo "Minor error"
else
    echo "Major error"
end

# Bash (cryptic)
if [ $? -eq 0 ]; then
    echo "Success"
elif [ $? -eq 1 ]; then
    echo "Minor error"
else
    echo "Major error"
fi
```

## Abbreviations vs Aliases

### Why Abbreviations are Superior

**Abbreviations** expand when you press space or enter, showing the full command:

```fish
abbr -a gc 'git commit'
# Type: gc<space> → expands to: git commit
```

**Aliases** hide the actual command:

```fish
alias gc='git commit'
# Type: gc<enter> → runs git commit (but you don't see it)
```

### Benefits of Abbreviations

1. \*\*
