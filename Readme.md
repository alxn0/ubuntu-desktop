# Workstation Setup Script for Ubuntu

Script that I use to automates the installation and configuration of Ubuntu workstations.
I found that `.yaml` are a bit overkill for my usage.

Applications are mostly installed from `apt`, `github` (go binaries), `flatpak`
and `pipx`.

Others that need more "complex" process are in individuals scripts in
`/install`.

Last tested on ubuntu 25.04, funny little penguin.

## Instalations
Clone the repo, run `./setup`

## Note
The script will prompt you at some point, so it is not fully autonomus.
Configurations for some tools are in `alxn0/dotfiles`

## Todo

- [ ] Add go and npm to path in setup
- [ ] Explore if filen CLI can automaticaly set sync
- [ ] Gnome configs (keybindings and dock)
- [ ] Print what remaining to do at the end of ./setup
- [ ] See why the last line of miniconda3/setup does not work (stop
  source base when opening terminal)
