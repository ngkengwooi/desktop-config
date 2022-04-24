# Ansible for Debian Workstations

Configurations for Debian workstations, managed via Ansible.

Usage:

```
sudo ansible-pull -U https://github.com/ngkengwooi/desktop-config <profile.yml>
```

## Convenience scripts

The convenience scripts can be used to quickly set up Ansible on a new computer. Simply execute the following commands in the terminal and wait:

Fedora for home:

```
curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/fedora-home.sh | sudo sh
```

Fedora for work:

```
curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/fedora-work.sh | sudo sh
```

Debian for home:

```
curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/debian-home.sh | sudo sh
```


Debian for work:

```
curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/debian-work.sh | sudo sh
```
