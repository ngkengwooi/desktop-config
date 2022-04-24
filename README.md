# Desktop configurations

Configuration tools to deploy and manage Fedora and Debian workstations using Ansible.

## Usage

When deploying a workstation for the first time, use the convenience scripts to quickly set up Ansible on a fresh OS install and then use that to pull in the configurations. Simply execute the following commands in the terminal and wait:

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

Once deployed, the workstation will automatically update according to the latest configuration file in this repo every hour.
