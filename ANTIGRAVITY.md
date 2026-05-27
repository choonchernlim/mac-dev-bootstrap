# ANTIGRAVITY.md

This file provides guidance to the agy command when working with code in this repository.

## What This Repo Does

An opinionated Ansible playbook that installs, configures, and keeps development tools up-to-date on a Mac. The entry point is `mac-dev-bootstrap.sh`, which bootstraps Homebrew, creates a Python venv, installs Ansible, then runs `main.yml`.

## Running the Playbook

```bash
# First-time setup (requires vault.yml with sudo password)
./mac-dev-bootstrap.sh --tags work        # work machine
./mac-dev-bootstrap.sh --tags personal    # personal machine

# Run only specific roles (use role tag names from main.yml)
./mac-dev-bootstrap.sh --tags "nvm"
./mac-dev-bootstrap.sh --tags "nvm,gcloud"

# Debug: show task arguments
ANSIBLE_DISPLAY_ARGS_TO_STDOUT=true ./mac-dev-bootstrap.sh

# Update all tools
update --tags work    # or personal
```

**vault.yml** must exist and contain `ansible_become_pass: [SUDO_PASSWORD]`. It is encrypted with ansible-vault. Create it with `ansible-vault create vault.yml` if missing.

## Linting

After any change, lint runs automatically at the end of `mac-dev-bootstrap.sh`. To run independently:

```bash
source .venv/bin/activate
ansible-lint           # uses .ansible-lint config
yamllint .             # uses .yamllint config
```

ansible-lint rule 401 (explicit git version pinning) is skipped. yamllint allows lines up to 180 chars.

## Architecture

### Role Structure

`main.yml` lists all roles in order; each role has a `tags` list that controls which machine type runs it. Tags `personal` and `work` are the two machine profiles.

```
roles/
  homebrew/           # Generic homebrew role (taps, packages, casks) — included by others, not directly
  homebrew_common/    # Common packages for all machines (calls homebrew role with common vars)
  homebrew_personal/  # Personal-only packages (garmin, nordvpn, etc.)
  homebrew_work/      # Work-only packages (android-studio, node, watchman)
  mac/                # Installs Rosetta on Apple Silicon
  xcode/              # Xcode CLI tools
  ohmyzsh/            # Oh My Zsh + plugins/themes + managed .zshrc block
  sdkman/             # SDKMAN for JVM version management
  nvm/                # Node Version Manager
  iterm2/             # iTerm2 preferences
  gcloud/             # Google Cloud SDK config
  python/             # Python setup
  quicklook/          # QuickLook plugins
  vimrc/              # Vim config
  ai/                 # Copies INSTRUCTIONS.md to ~/.claude/CLAUDE.md, ~/.gemini/antigravity-cli/ANTIGRAVITY.md, ~/.copilot/copilot-instructions.md
  cleanup/            # Post-install cleanup
  debug/              # Never runs by default (tag: never)
```

### Key Conventions

**Adding/removing packages** — edit `defaults/main.yml` in the relevant homebrew role (`homebrew_common`, `homebrew_personal`, `homebrew_work`). Packages go in `_present` or `_absent` lists; the homebrew role handles install/upgrade vs. uninstall.

**The `homebrew` role** is a generic reusable role that accepts `homebrew_taps`, `homebrew_packages_present`, `homebrew_packages_absent`, `homebrew_cask_packages_present`, `homebrew_cask_packages_absent` vars. The `homebrew_common/personal/work` roles call it via `include_role` with their own defaults.

**The `ohmyzsh` role** manages `.zshrc` via a `blockinfile` marker (`MAC-DEV-BOOTSTRAP MANAGED BLOCK - DO NOT EDIT!`). On first run it backs up the existing `.zshrc`. Config fragments go in `~/.zshrc_conf/`.

**The `ai_instructions` role** deploys a single `INSTRUCTIONS.md` source file to all AI tool config locations. To update AI instructions, edit `roles/ai_instructions/files/INSTRUCTIONS.md`.

**vault.yml** is git-ignored and ansible-vault encrypted. It holds `ansible_become_pass` only.

### Ansible Config

`ansible.cfg` sets inventory to `inventory.yml` (localhost with local connection) and uses `ansible.posix.debug` callback for readable output.
