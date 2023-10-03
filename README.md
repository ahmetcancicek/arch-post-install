<div align="center">
<h1 align="center">
<br>Arch Linux Post Install
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
* Tree
* VIM
* Gnome Boxes
* Terminator
* GIMP
* GIT
* Thunderbird
* KeePassXC
* Gnome Boxes
* Spotify
* LibreOffice
* OpenVPN
* Gnome Sound Recorder
* Yay
* Google Chrome
* Visual Studio Code
* Android Tools
* OpenJDK
* Oracle Java JDK
* Spring CLI
* Maven
* Gradle
* IntelliJ IDEA Ultimate
* Postman
* Docker
* Flatpak Repository
* Nvidia Driver

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

### 🔧 Installation

1. Clone the arch-post-install repository:
```sh
git clone https://github.com/ahmetcancicek/arch-post-install
```

2. Change to the project directory:
```sh
cd arch-post-install
```

3. Install the dependencies:
```sh
chmod +x main.sh
```

### 🤖 Running arch-post-install

```sh
./main.sh
```

---


## 🤝 Contributing


---


