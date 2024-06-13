# Ansible MacOS Setup

[![MIT license][badge-license]][link-license]
[![CI][badge-gh-actions]][link-gh-actions]

Sets up MacOS machines with my preferred apps and configurations. Can be run from a Control node to apply to multiple
hosts or standalone to set up a single machine.

## Configuration Options

The following variables in var.yaml can be changed if not all features are required.

`install_missing_homebrew` - Installs Homebrew if it's not installed.

`install_homebrew_packages` - Installs brew packages listed in vars.yaml.

`install_fisher_plugins` - Installs plugins for the Fish shell using Fisherman.

`install_nvim_plugins` - Install plugins for the neovim text editor.

`install_python` - Install the latest Python version with Pyenv.

`install_rust` - Install the latest Rust version with Rustup.

`setup_dock` - Configure Dock size and app positions.

`setup_dotfiles` - Copies dotfiles in files directory and applies custom configurations.

`setup_system_defaults` - Sets OSX default behaviours.

## Run Locally

- Clone project.
- Install Ansible.

`python3 -m pip install ansible`

- Run playbook.

`ansible-playbook -i inventory.ini -l local main.yaml`

## Using Control Node/Running On Multiple Hosts

### On Hosts (MacOS)

- Allow Remote Login via Settings > General > Sharing > Remote Login.
- Ensure each host has x-code developer tools installed.

`xcode-select --install`

### On Control Node

- Install Ansible.

`python3 -m pip install ansible`

- Add local IP address of each host node to the inventory.ini config file under [myhosts]

- [Generate SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) if required.

- Copy SSH key to each host using `ssh-copy-id`:

`ssh-copy-id {{username}}@{{host_address}}`

- Check connections with:

`ansible myhosts -m ping -i inventory.ini`

- Run the playbook

`ansible-playbook -i inventory.ini -l myhosts playbook.yaml -K`

If you do not need ansible to install homebrew the `-K` flag can be ommitted and no sudo password will be required.


## Tags

- `brew` - Installation of brew and brew packages/taps/casks.
- `dock` - Configure the MacOS dock.
- `dotfiles` - Copy dotfile configurations.
- `fish` - Install fish plugins with fisherman.
- `nvim` - Install nvim plugins.
- `python` - Install Python
- `rust` - Install Rust.
- `system` - System configurations such as OSX defaults. Includes `dock` tagged tasks.

[badge-gh-actions]: https://github.com/k-aziz/ansible_dev_setup/actions/workflows/ci.yaml/badge.svg?event=push
[link-gh-actions]: https://github.com/k-aziz/ansible_dev_setup/actions/workflows/ci.yaml
[badge-license]: https://img.shields.io/github/license/k-aziz/ansible_dev_setup
[link-license]: https://github.com/k-aziz/ansible_dev_setup/blob/main/LICENSE
