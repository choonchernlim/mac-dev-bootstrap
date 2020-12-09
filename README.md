# mac-dev-bootstrap

A very opinionated script to install, configure and update the following development tools on a Mac:

- [1Password](https://1password.com/)
- [Alfred](https://www.alfredapp.com/)
- [amix/vimrc](https://github.com/amix/vimrc/)
- [ChronoSync](https://www.econtechnologies.com/)
- [CleanMyMac](https://macpaw.com/cleanmymac/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Google Backup and Sync](https://www.google.com/intl/en-GB_ALL/drive/)
- [Google Chrome](https://www.google.com/chrome/)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install/)
- [Homebrew](https://brew.sh/)
- [iTerm2](https://www.iterm2.com/)
- [MAMP](https://www.mamp.info/en/windows/)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/)
- [NoMachine](https://www.nomachine.com/)
- [NVM (Node Version Manager)](https://github.com/nvm-sh/nvm/)
- [Oh MyZsh](https://ohmyz.sh/)
- [Postman](https://www.postman.com/)
- [Rectangle](https://rectangleapp.com/)
- [SDKMAN!](https://sdkman.io/)
- [Skitch](https://evernote.com/products/skitch/)
- [Spotify](https://www.spotify.com/us/)
- [Sublime Text](https://www.sublimetext.com/)
- [Textmate](https://macromates.com/)
- XCode Command Line Tools
- ... and many commonly used DevOps commands

Tested on:

- macOS Big Sur
- macOS Catalina

## Usage

> IMPORTANT: Consider reviewing [mac-dev-bootstrap.log](mac-dev-bootstrap.log) to understand what's going on first before
> proceeding. Unless you are a clone of me, my workflow may not necessarily matches yours, but feel free to fork this repo and
> customize it to fit your needs.

- Run `mac-dev-bootstrap.sh` to begin the installation.

> NOTE: If you see this Homebrew error ( **Error: It seems there is already an App at '/Applications/[NAME].app'** ),
> this is because you may have already installed the app before running the playbook. To fix this, simply delete the
> app, then rerun the playbook. You will not lose your app's configuration.

- To install/configure just specific installation(s), run `mac-dev-bootstrap.sh --tags "[ROLE_TAG(S)]"`, ex:
  - `mac-dev-bootstrap.sh --tags "nvm"`: Install just NVM.
  - `mac-dev-bootstrap.sh --tags "nvm,gcloud"`: Install NVM and Google Cloud SDK.

- To update all the tools in the future, run `update` in the terminal.

## One-Time Setup

## iTerm2

- `Profiles`.
    - Click on `mac-dev-bootstrap`.
    - `Other Actions...`.
    - `Set as Default`.
    - Delete other existing profiles.
