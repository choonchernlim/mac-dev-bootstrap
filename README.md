# mac-dev-bootstrap

A very opinionated Ansible playbook to install, configure and update the following development tools on a Mac:

- [1Password](https://1password.com/)
- [Alfred](https://www.alfredapp.com/)
- [amix/vimrc](https://github.com/amix/vimrc/)
- [ChronoSync](https://www.econtechnologies.com/)
- [CleanMyMac](https://macpaw.com/cleanmymac/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Google Chrome](https://www.google.com/chrome/)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install/)
- [Homebrew](https://brew.sh/)
- [iTerm2](https://www.iterm2.com/)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/)
- [NVM (Node Version Manager)](https://github.com/nvm-sh/nvm/)
- [Oh MyZsh](https://ohmyz.sh/)
- [Postman](https://www.postman.com/)
- [Rectangle](https://rectangleapp.com/)
- [Skitch](https://evernote.com/products/skitch/)
- [Spotify](https://www.spotify.com/us/)
- [Sublime Text](https://www.sublimetext.com/)
- [Textmate](https://macromates.com/)
- XCode Command Line Tools
- ... and many commonly used DevOps commands

Tested on:

- macOS Sonoma
- macOS Big Sur
- macOS Catalina
- macOS Ventura

## Getting Started

- Run `./mac-dev-bootstrap.sh` to begin the installation.

- To install/configure just specific installation(s), run `./mac-dev-bootstrap.sh --tags "[ROLE_TAGS]"`, ex:
  - `./mac-dev-bootstrap.sh --tags "nvm"`: Install just NVM.
  - `./mac-dev-bootstrap.sh --tags "nvm,gcloud"`: Install NVM and Google Cloud SDK.

- To display the arguments passed to each task, run `ANSIBLE_DISPLAY_ARGS_TO_STDOUT=true ./mac-dev-bootstrap.sh`.

- To update all the tools in the future, run `update` in the terminal.
