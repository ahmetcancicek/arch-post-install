<div align="center">
<h1 align="center">
<br>Arch Post Install
</h1>
<h3>◦ Developed with the software and tools below.</h3>

<p align="center">
<img src="https://img.shields.io/badge/GNU%20Bash-4EAA25.svg?style&logo=GNU-Bash&logoColor=white" alt="GNU%20Bash" />
<img src="https://img.shields.io/badge/Markdown-000000.svg?style&logo=Markdown&logoColor=white" alt="Markdown" />
</p>
<img src="https://img.shields.io/github/license/ahmetcancicek/arch-post-install?style&color=5D6D7E" alt="GitHub license" />
<img src="https://img.shields.io/github/last-commit/ahmetcancicek/arch-post-install?style&color=5D6D7E" alt="git-last-commit" />
<img src="https://img.shields.io/github/commit-activity/m/ahmetcancicek/arch-post-install?style&color=5D6D7E" alt="GitHub commit activity" />
<img src="https://img.shields.io/github/languages/top/ahmetcancicek/arch-post-install?style&color=5D6D7E" alt="GitHub top language" />
</div>

---


## 📍 Overview

The project located at https://github.com/ahmetcancicek/arch-post-install automates the installation and configuration process for a variety of essential software and tools on an Arch Linux system. It installs packages like GNOME extensions, Vim, GIMP, Git, Thunderbird, and more, as well as development tools like Java, Maven, and IntelliJ IDEA. Additionally, it sets up fonts including Powerline Fonts, Roboto, Ubuntu, and JetBrains Mono. This project saves significant time and effort for Arch Linux users by streamlining the software installation and configuration process.

---


## 📦 Packages

<details closed><summary>All Packages List</summary>

* Curl
* Wget
* ZSH
* HTOP
* Snap
* Flatpak
* Google Chrome
* Chromium
* Spotify
* Opera
* Microsoft Edge
* Brave
* Zoom
* Discord
* Thunderbird
* GIT
* OpenJDK
* Oracle Java JDK
* Spring CLI
* Go
* VSCODE
* IntelliJ IDEA Ultimate
* Postman
* Docker
* Maven
* Gradle
* VIM
* DataGrip
* Gnome Tweak Tool
* Dropbox
* KeePassXC
* VirtualBox
* Gnome Boxes
* Terminator
* Web Apps
* OpenVPN
* Timeshift
* Gparted
* GIMP
* Droidcam
* Kdenlive
* Krita
* Inkscape
* LibreOffice

</details>

---


## 📂 Repository Structure

```sh
└── arch-post-install/
    ├── .gitignore
    ├── LICENSE
    ├── README.md
    ├── fonts.sh
    └── main.sh
```

---


## ⚙️ Modules

<details closed><summary>Root</summary>

| File                                                                              | Summary                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ---                                                                               | ---                                                                                                                                                                                                                                                                                                                                                                                                                                |
| [main.sh](https://github.com/ahmetcancicek/arch-post-install/blob/main/main.sh)   | The code in main.sh performs a series of installations and configurations for various software and tools. It installs essential packages, Bluetooth driver, GNOME extensions, Vim, Gnome-Boxes, GIMP, Git, Thunderbird, KeePassXC, Spotify, LibreOffice, OpenVPN, and more. It also installs Java, Spring CLI, Maven, Gradle, IntelliJ IDEA, and Postman. Additionally, it installs Docker, Flatpak repository, and Nvidia driver. |
| [fonts.sh](https://github.com/ahmetcancicek/arch-post-install/blob/main/fonts.sh) | This code installs various fonts including Powerline Fonts, Roboto, Noto Sans, Fira Mono, Clear Sans, Fira Sans, Roboto Slab, Overpass, Ubuntu, Ubuntu Mono, Ubuntu Condensed, Overpass Mono, JetBrains Mono, Inter, Hack, Monaco, and MesloLGS.                                                                                                                                                                                   |

</details>

---



## 🚀 Getting Started

***Dependencies***

Please ensure you have the following dependencies installed on your system:

```sh
sudo pacman -S git make
```

### 🔧 Installation

1. Clone the arch-post-install repository:
```sh
git clone https://github.com/ahmetcancicek/arch-post-install
```

2. Change to the project directory:
```sh
cd arch-post-install
```

### 🤖 Running arch-post-install

```sh
make run
```

**For Fonts**

```sh
make install-fonts
```

---


## 📄 License

Distributed under the GNU License. See LICENSE.md for more information.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

---