# Ansible MacOS Setup

Sets up MacOS machines with my preferred apps and configurations. Can be run from a Control node to apply to multiple
hosts or standalone to set up a single machine.

# Configuration Options

The following variables in var.yaml can be changed if not all features are required.

`install_missing_homebrew` - Installs Homebrew if it's not installed.

`install_homebrew_packages` - Installs brew packages listed in vars.yaml.

`setup_system_defaults` - Sets OSX default behaviours.

`setup_dotfiles` - Copies dotfiles in files directory and applies custom configurations.


# Using Control Node/Running On Multiple Hosts

## On Hosts (MacOS)

- Allow Remote Login via Settings > General > Sharing > Remote Login.
- Ensure each host has x-code developer tools installed.

`xcode-select --install`


## On Control Node

- Install Ansible.

`brew install ansible`

- Add local IP address of each host node to the inventory.ini config file under [myhosts]

- Copy SSH key to each host using `ssh-copy-id`:

`ssh-copy-id {{username}}@{{host_address}}`

- Check connections with:

`ansible myhosts -m ping -i inventory.ini`

- Run the playbook

`ansible-playbook -i inventory.ini -l myhosts playbook.yaml -K`


If you do not need ansible to install homebrew the `-K` flag can be ommitted and no sudo password will be required.
