# mac-dev-bootstrap

A very opinionated script to install, configure and update the following development tools on a Mac:

- [1Password](https://1password.com/)
- [Alfred](https://www.alfredapp.com/)
- [amix/vimrc](https://github.com/amix/vimrc)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Google Chrome](https://www.google.com/chrome/)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Homebrew](https://brew.sh/)
- [iTerm2](https://www.iterm2.com/)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
- [NordVPN](https://nordvpn.com/)
- [NVM (Node Version Manager)](https://github.com/nvm-sh/nvm)
- [Oh MyZsh](https://ohmyz.sh/)
- [SDKMAN!](https://sdkman.io/)
- [Rectangle](https://rectangleapp.com/)
- [Spotify](https://www.spotify.com/us/)
- [Sublime Text](https://www.sublimetext.com/)
- [Textmate](https://macromates.com/)
- XCode Command Line Tools

## Usage

**Note:** Consider reviewing [mac-dev-bootstrap.log](mac-dev-bootstrap.log) to understand what's going on first before
proceeding. My workflow may not necessarily matches yours, but feel free to fork/modify it to tailor your needs.

- Run `mac-dev-bootstrap.sh` to begin the installation.

- To install/configure just specific installation(s), run `mac-dev-bootstrap.sh --tags "[ROLE_TAG(S)]"`, ex:
  - `mac-dev-bootstrap.sh --tags "nvm"`: Install just NVM.
  - `mac-dev-bootstrap.sh --tags "nvm,gcloud"`: Install NVM and Google Cloud SDK.

- To update all the tools in the future, run `update` in the terminal.

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
