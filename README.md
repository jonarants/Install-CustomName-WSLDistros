# Install-CustomName-WSLDistros

This PowerShell script automates the process of creating multiple custom Windows Subsystem for Linux (WSL) 2 distributions from a clean Ubuntu-24.04 base image. It's designed for users who need consistent, isolated WSL environments for different projects or tasks.

## Features

* **Automated Base Image Setup:** Automatically installs Ubuntu-24.04 (if not present), exports it to a `.tar` file, and then unregisters the initial installation to maintain a clean system.
* **Custom Distro Creation:** Interactively prompts you to name and create new WSL2 instances based on the prepared base image.
* **Local Storage:** All generated files (the base `.tar` and the new WSL distro files) are stored in subfolders relative to the script's location, making your WSL setup portable within your local system.

## Getting Started

### Prerequisites

1.  **Windows 10/11 with WSL Enabled:** Ensure Windows Subsystem for Linux is enabled and configured to run WSL2 distributions. You can typically do this by running `wsl --install` in an elevated PowerShell/Command Prompt.
2.  **PowerShell:** The script is written in PowerShell.
3.  **Administrator Privileges:** You must run the PowerShell script with Administrator privileges for `wsl.exe` commands and directory creation to succeed.

### Setup

1.  **Clone or Download the Repository:**
    ```bash
    git clone [https://github.com/jonarants/Install-CustomName-WSLDistros.git](https://github.com/jonarants/Install-CustomName-WSLDistros.git)
    cd Install-CustomName-WSLDistros
    ```

2.  **Script Location:** place the `CustomNameWSLDistro.ps1` script in the root of your project directory where you want to store you distros.

3.  **Directory Structure:**
    The script expects and will create the following subdirectories:
    ```
    YourRepoName/
    ├── CustomNameWSLDistro.ps1
    ├── base/        <-- Where 'Ubuntu-24.04-Base.tar' will be stored
    └── distros/     <-- Where your new custom WSL instances will be installed
    ```

### Usage

1.  **Open PowerShell as Administrator.**
2.  **Navigate to the script's directory:**
    ```powershell
    cd <Path\To\Your\Install-CustomName-WSLDistros>
    ```
    (e.g., `cd C:\Users\YourUser\Documents\GitHub\Install-CustomName-WSLDistros`)
3.  **Run the script:**
    ```powershell
    .\CustomNameWSLDistro.ps1
    ```

The script will guide you through the following steps:

* It will install `Ubuntu-24.04`, export it, and then unregister the temporary installation.
* It will then prompt you to enter a custom name for each new WSL distro you wish to create.
* Once you're done, it will list all currently installed WSL distributions.

## Important Notes

* **No Default User Configuration:** This script, in its current form, **does not** prompt for a default user or password for the newly created distros. After import, they will default to the `root` user. You will need to manually set a default user and password within each distro after its first launch (or modify the script to include the user setup steps).
* **Disk Space:** WSL distros can consume significant disk space. Ensure you have enough free space on the drive where you run the script, as it will store the `.tar` file and all new distro installations locally.

## Contribution

Feel free to open issues or submit pull requests if you have suggestions for improvements or encounter any bugs.
````