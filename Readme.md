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

The script is fully automated and requires no user interaction.

## Note
Configurations for some tools are in `alxn0/dotfiles`

## Todo

- [ ] Add go, npm llm to path in setup so that later install find
  command.
- [ ] Explore if filen CLI can automaticaly set sync
- [ ] Gnome configs (keybindings and dock)
- [ ] Print what remaining to do at the end of ./setup
- [ ] See why the last line of miniconda3/setup does not work (stop
  source base when opening terminal)
