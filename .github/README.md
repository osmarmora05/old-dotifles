<!-- CREDITS FOR AWESOME PEOPLE -->

> **Important**
>  My configuration files have been created based on the [gwileful](https://github.com/Gwynsav/gwileful/) and [crystal](https://github.com/chadcat7/crystal) projects. So I ask people to give credit to these amazing people.

<!-- PROFILE PICTURE -->
<p align="center">
  <img width="25%" src="https://github.com/osmarmora05.png"/>
</p>

<!-- NAME PROYECT -->
<p align="center">
  <b>~ osmarmora05's configuration files ~</b>
</p>

<!-- BUTTONS -->
<p align="center">
<a href="#setup"><img width="130px" style="padding: 0 5px;" src="./assets/button-setup.svg"></a>
<a href="#configuration"><img width="130px" style="padding: 0 5px;" src="./assets/button-config.svg"></a>
<a href="#usage"><img width="130px" style="padding: 0 5px;" src="./assets/button-usage.svg"></a>
<a href="https://github.com/osmarmora05/dotfiles/wiki"><img width="130px" style="padding: 0 5px;" src="./assets/button-wiki.svg"></a>
</p>

<!-- SHOWCASE -->
## 
<div align="center">
<img src="./screenshots/1.jpg" alt="showcase1">
<img src="./screenshots/2.jpg" alt="showcase2">
<img src="./screenshots/3.jpg" alt="showcase4">
<img src="./screenshots/4.jpg" alt="showcase3">
</div>

<!-- WARNING BROKEN CODE -->
> **Warning**
It is not uncommon for me to commit broken code. Also I don't guarantee this setup to be stable
or the slightest bit safe for use. You have been warned.

<!-- INFORMATION -->
## Hello! Thanks for coming! ❤️ 
These are my configuration files for **AwesomeWM** which includes a control center, panel with shortcuts to popular pages with a task list, notifications, screenshot tools, interactive calendar, cute battery face, minimalist Exitscreen, multiple color schemes and much more...

<!-- INFORMATION -->
## Features of config
- **WM:** [AwesomeWM](https://github.com/awesomeWM/awesome) 
- **Operating system:** [Fedora](https://fedoraproject.org/workstation/download/)
- **Terminal:** [Kitty](https://github.com/kovidgoyal/kitty)
- **Shell:** zsh
- **Prompt:** [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **File Manager CLI:** [Ranger](https://github.com/ranger/ranger) 
- **File Manager UI:** nautilus

<!-- SETUP -->
## Setup

<details>
<summary><b>1. Install Required Dependencies</b></summary>

1. First of all you should install the Awesome-git.


    **Arch users** can use the [Awesome-git AUR package](https://aur.archlinux.org/packages/awesome-git/).
    ```shell
    yay -S awesome-git
    ```

    In the case of **Fedora-based distributions**, it is necessary to install certain libraries before proceeding with the Awesome-git installation.
    ```shell
    sudo dnf install xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel 
    startup-notification-devel libxdg-basedir-devel xcb-util-xrm-devel libxkbcommon-x11-devel xcb-cursor-devel 
    make automake gcc gcc-c++ cmake glib2-devel gdk-pixbuf2-devel cairo-devel libX11-devel xcb-util-cursor-devel 
    xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel libxkbcommon-devel cairo-devel xcb-util-image-devel 
    libstartup-notification-devel libxdg-basedir-devel xcb-util-xrm-devel libxcb-devel lua-devel cmake 
    startup-notification-devel libxkbcommon-devel libxkbcommon-x11-devel libxdg-basedir-devel xcb-util-xrm-devel
    ```

    Once we have completed the prerequisites, we proceed to follow the Awesome-git build instructions found [here](https://github.com/awesomeWM/awesome/#building-and-installation).

2. Installation of dependencies
   
    **Mandatory**
    - [Awesome-git](https://github.com/awesomeWM/awesome) (If you have reached this point you should already have it installed (๑ᵔ⤙ᵔ๑))
    - [Network Manager](https://github.com/NetworkManager/NetworkManager) (network signals)
    - [Pipewire](https://github.com/PipeWire/pipewire) and
    [Wireplumber](https://github.com/PipeWire/wireplumber) (audio signals)
    - [maim](https://github.com/naelstrof/maim),
    [slop](https://github.com/naelstrof/slop),
    [xclip](https://github.com/astrand/xclip) (screenshots)
    - [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme), [WhiteSur-icon-theme](https://github.com/vinceliuice/WhiteSur-icon-theme)  (icon pack)
    - [IBM Plex Sans](https://github.com/IBM/plex/tree/master/IBM-Plex-Sans/fonts/complete/ttf), [IBM-Plex-Mono](https://github.com/IBM/plex/tree/master/IBM-Plex-Mono/fonts/complete/ttf),
    [Material Icons](https://github.com/google/material-design-icons) and [CaskaydiaCove Nerd Font](https://www.nerdfonts.com/font-downloads) or (you can find the required fonts inside the `misc/fonts` folder of this repository)
    - [brightnessctl](https://github.com/Hummer12007/brightnessctl) (brightness signals)
    - [bluez](https://github.com/bluez/bluez) (bluetooth signals)
    - [upower](https://github.com/freedesktop/upower) (battery signals)
    - [gpick](https://github.com/thezbyg/gpick) , [ImageMagick](https://github.com/ImageMagick/ImageMagick) (color picker)
    <p align="center">
      <b> </b>
    </p>

    > **Important**
    > The following commands do not include the dependency: [WhiteSur-icon-theme](https://github.com/vinceliuice/WhiteSur-icon-theme), [IBM Plex Sans](https://github.com/IBM/plex/tree/master/IBM-Plex-Sans/fonts/complete/ttf), [IBM-Plex-Mono](https://github.com/IBM/plex/tree/master/IBM-Plex-Mono/fonts/complete/ttf),
    [Material Icons](https://github.com/google/material-design-icons), [CaskaydiaCove Nerd Font](https://www.nerdfonts.com/font-downloads)


    <details>
    <summary><b> In fedora (Fedora-based distributions)</b></summary>

    ```shell
    sudo dnf install NetworkManager pipewire wireplumber maim slop xclip brightnessctl bluez upower papirus-icon-theme gpick ImageMagick
    ```

    </details>

    <details>
    <summary><b> In Arch</b></summary>

    ```shell
    sudo yay -s NetworkManager pipewire wireplumber main slop xclip brightnessctl bluez upower papirus-icon-theme gpick imagemagick
    ```

    </details>

</details>


<details>

<!-- INSTALL MI CONFIGURATIONS -->
<summary><b>2. Install my configuration files</b></summary>



1. Clone this repository

    ```shell
    git clone https://github.com/osmarmora05/dotfiles.git
      ```

2. Install my AwesomeWM configuration files

    If you want just my AwesomeWM configuration

    ```shell
    cd dotfiles
    cp -r config/awesome/* ~/.config/
    ```
    
    Or if you want all the configuration

    ```shell
    cd dotfiles
    cp -r config/* ~/.config/
    ```
    **Optional** - Now if you want to get the fonts from the repository

    ```shell
    cd dotfiles
    cp -r misc/fonts/* /usr/share/fonts/
    ```

    Congratulations, at this point you have installed my configurations! 🎉

    Log out from your current desktop session and log in into AwesomeWM
    
</details>

> **Note**
If you find any spelling or installation errors, let me know.

<!-- CONFIGURATION -->
## Configuration

Simple Configuration

<details>

<p align="center">
    <b> </b>
</p>

Most of this project follows the structure of the [Suconakh](https://github.com/suconakh/awesome-awesome-rc) project. However, there are some additions by [gwynsav](https://github.com/Gwynsav/gwileful).

~ `config/user.lua` aggregates user options like the wallpaper, avatar, and other options like gaps, colorscheme, screenshot.

| Variable       | Type      | Description                                                                        |
| -------------- | --------- | ---------------------------------------------------------------------------------- |
| gaps           | `integer` | Spacing between clients and screen padding size                                    |
| colorscheme    | `string`  | `everblush`, `everforest`, `tokyonight`, `fullerene`, `oxocarbon` ,`catppuccin`,`mar`,`nord`,`gruvbox_dark`,`dracula`,`default`, `gruvbox_dark`, `adwaita`, `janleigh`, `gruvbox_light`, `solarized`,`plata`, and more to come  |
| avatar         | `string`  | Path to user profile picture                                                       |
| wallpaper      | `string`  | Path to user wallpaper                                                             |
| screenshot_dir | `string`  | Directory to save screenshots to                                                   |

<p align="center">
  <b> </b>
</p>

> **Warning**
It is not recommended to move the `colorscheme` variable in the `config/user.lua` file from line **21**. Because it is linked to the `themer` widgets, since its functionality is to edit this line depending on the theme set. If you move it from the current line, you must modify the second argument of the `setTheme` function call in the `widgets/control_center/module/themer.lua` file.

```lua
set_theme(' colourscheme = "' .. currTheme:gsub('"', '\\"') .. '",',line number,gfs.get_configuration_dir() .."config/username.lua") --Change theme
```

~ `config/auto.lua` contains autostart commands to be executed:

- At the start of an X session.
- Every time Awesome is loaded (and reloaded).
- Shell code.

</details>

<!-- TODO -->
<!-- KEYBINDS -->
## Usage
<details>
<summary><b>Main keybinds</b></summary>


| Keybind                | Description                                                |
| ---------------------- | ---------------------------------------------------------- |
| AwesomeWM              | -                                                          |
| `mod + Control + r`    | Reload AwesomeWM.                                          |
| `mod + s`              | Show help.                                                 |
| Applications           | -                                                          |
| `mod + Return`         | Opens a terminal.                                          |
| `mod + Shift + e`      | Opens a GUI file manager.                                  |
| Window Management      | -                                                          |
| `mod + q`              | Close focused client.                                      |
| `Control + mod + Space` | toggle floating.                                          |
| `Shift + mod + j`      | Swap with next client by index.                            |
| `Shift + mod + k`      | Swap with previous client by index.                        |
| `Shift + mod + m`      | (un)maximize horizontally.                                 |
| `mod + f`              | Toggle fullscreen.                                         |
| `mod + j`              | Focus next by index.                                       |
| `mod + k`              | Focus previous by index.                                   |
| `mod + m`              | (un)maximize.                                              |
| `mod + n`              | Minimze.                                                   |
| `mod + u`              | Jump to urgent client.                                     |
| Layout Management      | -                                                          |
| `Alt + mod + j`        | Decrease client with factor.                               |
| `Alt + mod + k`        | Increase client with factor.                               |
| `Control + mod + h`    | Increase the number of columns.                            |
| `Control + mod + l`    | Decrease the number of columns.                            |
| `Shift + mod + h`      | Increase the number of master clients.                     |
| `Shift + mod + l`      | Decrease the number of master clients.                     |
| `Shift + mod + Space`  | Select previous.                                           |
| `mod + h`              | Decrease master with factor.                               |
| `mod + l`              | Increase master with factor.                               |
| `mod + space`          | Select next.                                               |
| Media Management       | -                                                          |
| `XF86AudioRaiseVolume` | Increase system audio volume.                              |
| `XF86AudioLowerVolume` | Decrease system audio volume.                              |
| `XF86MonBrightnessUp`  | Increase screen backlight brightness.                      |
| `XF86MonBrightnessDown`| Decrease screen backlight brightness.                      |
| `Print`                | Take cursor selection screenshot.                          |
| `mod + Print`          | Take fullscreen screenshot.                                |
| `mod + o`          | Color picker.                                |
| Tag                    | -                                                          |
| `Control + mod + 1/2/3/4/5/6/7/8/9/0` | Toggle tag.                                 |
| `Shift + mod + 1/2/3/4/5/6/7/8/9/0` | Move focused client to tag.                   |
| `mod + Left`           | View previous.                                             |
| `mod + Right`          | View next.                                                 |
| `mod + 1/2/3/4/5/6/7/8/9/0` | Only view tag.                                        |
| `mod + Esc`            | Go back.                                                   |
| UI                     | -                                                          |
| `mod + c`              | Toggle control center visibility.                          |
| `mod + t`              | Toggle themer-panel visibility.                            |
| `mod + Shift + c`      | Toggle calendar visibility.                                |
| `mod + p`              | Toggle menu bar visibility.                                |

</details>


<!-- MODULES -->
## Modules
AwesomeWM Modules:

<details>

<p align="center">
  <b> </b>
</p>

- [json.lua](https://github.com/rxi/json.lua)
  - A lightweight JSON library for Lua
- [color](https://github.com/andOrlando/color)
  - Clean and efficient api for color conversion in lua
- [UPower](https://github.com/Aire-One/awesome-battery_widget)
  - A UPowerGlib based battery widget for the Awesome WM
- [rubato](https://github.com/andOrlando/rubato)
  - Smooth animations with a slope curve for AwesomeWM
  
</details>

<!-- CREDITS -->
## Credits

My configuration files are the result of merging the brilliant [gwileful](https://github.com/Gwynsav/gwileful) and [crystal](https://github.com/chadcat7/crystal) projects. So without them this would not have been possible.  ૮꒰ ˶• ༝ •˶꒱ა ♡

- [gw's creator gwileful](https://github.com/Gwynsav/)
- [chadcat7's creator crystal](https://github.com/chadcat7/)

<!-- REFERENCES -->
## References
These people's dotfiles (and in some cases they themselves) have massively
helped me create this configuration.

[Blyaticon's cropping helper](https://git.gemia.net/paul.s/homedots). 

[Alpha.'s NixOS Awesome setup](https://github.com/AlphaTechnolog/nixdots). 

[Stardust-kyun's dotfiles](https://github.com/Stardust-kyun/dotfiles). 

[Aproxia's dotfiles](https://github.com/Aproxia-dev/.dotfiles). 

Also got a few ideas from [elenapan's dotfiles](https://github.com/elenapan/dotfiles) 
and [rxyhn's Yoru](https://github.com/rxyhn/yoru).