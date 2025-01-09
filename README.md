<div align="center">
<h1 align="center">
<br>Arch Post Install
</h1>
<h3>◦ Developed with the software and tools below.</h3>

<p align="center">
<img src="https://img.shields.io/badge/GNU%20Bash-4EAA25.svg?style&logo=GNU-Bash&logoColor=white" alt="GNU%20Bash" />
<img src="https://img.shields.io/badge/Markdown-000000.svg?style&logo=Markdown&logoColor=white" alt="Markdown" />
</p>
<img src="https://img.shields.io/github/license/ahmetcan/arch-post-install?style&color=5D6D7E" alt="GitHub license" />
<img src="https://img.shields.io/github/last-commit/ahmetcan/arch-post-install?style&color=5D6D7E" alt="git-last-commit" />
<img src="https://img.shields.io/github/commit-activity/m/ahmetcan/arch-post-install?style&color=5D6D7E" alt="GitHub commit activity" />
<img src="https://img.shields.io/github/languages/top/ahmetcan/arch-post-install?style&color=5D6D7E" alt="GitHub top language" />
</div>

---

## 📍 Overview

This project automates the post-installation setup of Arch Linux, installing and configuring essential software, development tools, and system utilities. It streamlines the process of setting up a new Arch Linux system with commonly used applications and development environments.

---

## 📦 Installation Methods

### Quick Install
```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/arch-post-install/main/install.sh)"
```

### Manual Install
1. Clone the repository:
```bash
git clone --depth=1 https://github.com/ahmetcancicek/arch-post-install.git
```

2. Navigate to the directory:
```bash
cd arch-post-install
```

3. Run the installation script:
```bash
sudo bash arch-post-install.sh
```

---

## 📦 Packages

<details closed><summary>Installed Packages</summary>

### System Tools
- Base Development Tools
- Network Utilities
- System Utilities (htop, neofetch, etc.)

### Development
- Java (OpenJDK, Oracle JDK)
- Python and pip
- Docker and Docker Compose
- Git and Version Control
- Build Tools (Maven, Gradle)
- Spring Boot CLI

### IDEs & Editors
- IntelliJ IDEA Ultimate
- Visual Studio Code
- DataGrip
- Vim

### Internet & Communication
- Firefox
- Google Chrome
- Tor Browser
- Thunderbird
- Zoom

### Utilities
- Anki
- Zotero
- KeePassXC
- Timeshift
- Gparted

### Multimedia
- VLC
- GIMP
- Inkscape
- DroidCam

</details>

---

## 📂 Repository Structure

```sh
└── arch-post-install/
    ├── arch-post-install.sh
    ├── install.sh
    ├── setup/
    │   ├── config/
    │   │   ├── colors.sh
    │   │   ├── packages.sh
    │   │   ├── urls.sh
    │   │   └── versions.sh
    │   ├── installers/
    │   │   ├── development/
    │   │   ├── system/
    │   │   └── utilities/
    │   └── utils/
    │       ├── helpers.sh
    │       └── messages.sh
    └── README.md
```

---

## ⚡ Requirements

- Arch Linux installation
- Internet connection
- Root access (sudo)
- Basic system utilities (curl or git)

---

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)