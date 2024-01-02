# Desktop configurations

Configuration scripts to configure Debian workstations.

## Usage

You need `curl` to pull the scripts to the local computer. To install it, run in the terminal: 

```
sudo apt -y install curl
```

Then, execute the following commands:

- For Debian with the GNOME desktop environment:
  ```
  curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/debian-gnome.sh | sudo bash
  ```

- Or, for Debian with the XFCE desktop environment instead of GNOME:
  ```
  curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/debian-xfce.sh | sudo bash
  ```
- To install Docker:
  ```
  curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/docker.sh | sudo bash
  ```
