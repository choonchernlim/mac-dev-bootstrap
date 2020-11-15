# mac-dev-bootstrap

## One-Time Setup

## Iterm2

- `General -> Preferences`.
    - Check "Load preferences from a custom folder or URL".
    - Specify the path to `iterm2` dir in the Git repo: `[PATH]/mac-dev-bootstrap/iterm2`.
    - Check "Save changes to folder when iTerm2 quits".
- `Profiles`.
    - Click on `mac-dev-bootstrap`.
    - `Other Actions...`.
    - `Set as Default`.
    - Delete other existing profiles.

## .zshrc

- Copy `[PATH]/mac-dev-bootstrap/zshrc/.zshrc` and paste at the bottom of`~/.zshrc`.
- Add the following to the top of `~/.zshrc`:

```shell script
export MAC_DEV_BOOTSTRAP_HOME="[PATH]/mac-dev-bootstrap" # Fix [PATH]!
export MAC_DEV_BOOTSTRAP_SCRIPT="${MAC_DEV_BOOTSTRAP_HOME}/mac-dev-bootstrap.sh"
alias update="cd ${MAC_DEV_BOOTSTRAP_HOME} && git pull --ff-only; ${MAC_DEV_BOOTSTRAP_SCRIPT}"
```