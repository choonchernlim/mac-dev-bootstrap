# mac-dev-bootstrap

A very opinionated Ansible playbook to install, configure and update software and development tools on a Mac.

## Getting Started

- To begin first-time installation, run `./mac-dev-bootstrap.sh --tags [MACHINE_TYPE]` where `[MACHINE_TYPE]` is `work` for work machines or `personal` for personal machines.
  - Note: When getting `Bash must not run in POSIX mode. Please unset POSIXLY_CORRECT and try again.` error,
    install Homebrew and upgrade Bash to the latest version:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install bash
```

- To install/configure just specific installation(s), run `./mac-dev-bootstrap.sh --tags "[ROLE_TAGS]"`, ex:
  - `./mac-dev-bootstrap.sh --tags "nvm"`: Install just NVM.
  - `./mac-dev-bootstrap.sh --tags "nvm,gcloud"`: Install NVM and Google Cloud SDK.

- To display the arguments passed to each task, run `ANSIBLE_DISPLAY_ARGS_TO_STDOUT=true ./mac-dev-bootstrap.sh`.

- To update all the tools in the future, run `update --tags [MACHINE_TYPE]` where `[MACHINE_TYPE]` is `work` for work machines or `personal` for personal machines.
