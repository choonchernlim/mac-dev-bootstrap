# mac-dev-bootstrap

A very opinionated script to install, configure and update the following development tools on a Mac:

- [Homebrew](https://brew.sh/)
- [Oh MyZsh](https://ohmyz.sh/)
- [SDKMAN!](https://sdkman.io/)
- [NVM (Node Version Manager)](https://github.com/nvm-sh/nvm)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [amix/vimrc](https://github.com/amix/vimrc)
- [iTerm2](https://www.iterm2.com/)
- [Alfred](https://www.alfredapp.com/)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
- [Rectangle](https://rectangleapp.com/)
- [Spotify](https://www.spotify.com/us/)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [1Password](https://1password.com/)
- [Textmate](https://macromates.com/)
- [Google Chrome](https://www.google.com/chrome/)
- [Sublime Text](https://www.sublimetext.com/)
- [NordVPN](https://nordvpn.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- XCode Command Line Tools

## Usage

**IMPORTANT:** Please read [mac-dev-bootstrap.sh](mac-dev-bootstrap.sh) and understand what's going on first before
proceeding.

- Run `mac-dev-bootstrap.sh` to begin the installation.

- To install/configure just specific installation(s), run `mac-dev-bootstrap.sh --tags "[ROLE_TAG(S)]"`, ex:
  - `mac-dev-bootstrap.sh --tags "nvm"`: Install just NVM.
  - `mac-dev-bootstrap.sh --tags "nvm,gcloud"`: Install NVM and Google Cloud SDK.

- To update the all the tools in the future, run `update` in the terminal.

## Troubleshooting

### Error: It seems there is already an App at '/Applications/[NAME].app'

This is due to the fact the app was already installed before running the playbook. To fix this, simply delete the
app and rerun the playbook. You will not lose your app's configuration.

## One-Time Setup

## iTerm2

- `Profiles`.
    - Click on `mac-dev-bootstrap`.
    - `Other Actions...`.
    - `Set as Default`.
    - Delete other existing profiles.
