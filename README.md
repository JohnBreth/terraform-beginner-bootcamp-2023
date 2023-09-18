# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This project is going to use semantic versioning for it's tagging.
[semver.org](https://semver.org/)

The general format: 

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform CLI

### Considerations with the Terraform CLI changes

The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest Terraform CLI documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distributions

This project built against Ubuntu. Please make sure to check your distribution and change configuration as required.

[How to Check Linux OS Version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:
```
$ cat /etc/os-release 

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Back Script

While fixing the Terraform CLI gpg issues, we noticed the bash script steps were of considerible length. We decided to create a bash script to install the Terraform CLI.

The bash file can be found here [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

- This will keep Gitpod task file([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow for easier debug and manual installation of Terraform CLI.
- This will allow for better portability for other project that require the install of the Terraform CLI.

#### Shebang

A shebang (pronounced sha-bang) tells the bash interpretuer which program will interpret the script. eg. `#!/bin/bash`

ChatGPT recommends this format for bash scripts: `#!/usr/bin/env bash`

- For portability with different OS distribuitions
- Will search the user's PATH for bash executables

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script we can use `./` shorthand to execute the script.

eg. `./bin/install_terraform_cli.sh`

If we are executing a script in gitpod.yml, we need to point it towards a program to interpret it.

eg. `source ./bin/install_terraform_cli.sh`

#### Linux Permissions

In order to make our bash scripts executable we need to change user permissions of the script to be executable at the user mode.

```
sh
chmod u+x ./bin/install_terraform_cli.sh
```

Alternatively:
```
sh
chmod 744 ./bun/install_terraform_cli.sh
```

https://en.wikipedia.org/wiki/Chmod

### Gitpod Lifecycle (Before, Commit, Command)

We need to becareful when using Init because it will not rerun if we restart an existing workspace.
https://www.gitpod.io/docs/configure/workspaces/tasks

