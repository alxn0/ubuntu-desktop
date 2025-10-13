# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Ubuntu workstation setup automation script that installs and configures a complete development environment. The project is intentionally kept simple using bash scripts rather than configuration management tools like Ansible or YAML-based solutions.

## Architecture

The project has a two-level architecture:

1. **Main Setup Script** (`./setup`): Orchestrates the entire installation process by calling individual installation scripts and performing system-level package installations via apt, flatpak, pipx, go, and npm.

2. **Modular Install Scripts** (`install/` directory): Each complex installation that requires multiple steps (downloading binaries, verifying signatures, adding repositories, etc.) is isolated in its own executable script.

The `install()` function in `./setup` provides a simple interface to call scripts from the `install/` directory.

## Running the Setup

**Full system setup:**
```bash
./setup
```

Note: The script is fully automated and requires no user interaction.

**Run individual installation script:**
```bash
bash install/<script-name>
```

For example:
```bash
bash install/go
bash install/nodejs
bash install/sops
```

## Key Installation Patterns

### Package Managers Used

- **apt**: System utilities and terminal tools (lines 25-39 in setup)
- **pipx**: Python CLI applications (lines 54-59)
- **flatpak**: GUI applications (lines 82-90)
- **go install**: Go binaries from GitHub (lines 67-70)
- **npm install -g**: Node.js packages (line 74)

### Complex Installations (install/ directory)

Scripts in `install/` follow these patterns:

1. **Binary downloads with verification** (e.g., `sops`):
   - Download binary from GitHub releases
   - Verify checksums using cosign
   - Move to `/usr/local/bin` and make executable

2. **Version manager installations** (e.g., `nodejs`, `miniconda3`):
   - Install version manager (nvm, conda)
   - Source the manager script
   - Install specific version

3. **Repository additions** (e.g., `gh`):
   - Add GPG keys
   - Add apt repository
   - Install via apt

### Configuration Management

Configuration files are managed in `configs/`:
- `configs/setup` creates symlinks to configuration files in `$HOME/.config/`
- Currently handles appimagelauncher.cfg
- Config files for most tools are maintained in a separate `alxn0/dotfiles` repository

## Development Notes

### Adding New Installations

1. Simple apt packages can be added directly in the `./setup` script
2. Complex installations should get their own script in `install/`:
   - Make it executable (`chmod +x`)
   - Use shebang `#!/bin/bash`
   - Include echo statement showing what's being installed
   - Call it from `./setup` using the `install` function

### Version Numbers

Version numbers are hardcoded in installation scripts (see `install/go` line 8, `install/sops` line 7). When updating versions:
- Check the script for VERSION variables or hardcoded version strings in URLs
- Update checksums/signatures if applicable

### Architecture Assumptions

Scripts assume:
- Linux operating system
- Intel/AMD64 architecture (`linux-amd64`)
- Ubuntu-based distribution (uses apt)

### Known Issues

See the Todo section in Readme.md for outstanding issues, including:
- PATH configuration for go and npm binaries needs to happen earlier in setup
- Gnome configurations (keybindings, dock) not yet automated
