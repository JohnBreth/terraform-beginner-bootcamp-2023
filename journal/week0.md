# Terraform Beginner Bootcamp 2023 - Week 0

  * [Semantic Versioning](#semantic-versioning)
  * [Install Terraform CLI](#install-terraform-cli)
    + [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
    + [Considerations for Linux Distributions](#considerations-for-linux-distributions)
    + [Refactoring into Back Script](#refactoring-into-back-script)
      - [Shebang](#shebang)
      - [Execution Considerations](#execution-considerations)
      - [Linux Permissions](#linux-permissions)
    + [Gitpod Lifecycle (Before, Commit, Command)](#gitpod-lifecycle--before--commit--command-)
    + [Working With Env Vars](#working-with-env-vars)
      - [env command](#env-command)
      - [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
      - [Printing Vars](#printing-vars)
      - [Scoping of Env Vars](#scoping-of-env-vars)
      - [Persisiting Env Vars in Gitpod](#persisiting-env-vars-in-gitpod)
    + [AWS CLI Installation](#aws-cli-installation)
  * [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
    + [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud and Gitpod](#issues-with-terraform-cloud-and-gitpod)
- [Git Save Work and Transfer to Other Branch](#git-save-work-and-transfer-to-other-branch)

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

### Working With Env Vars

#### env command

We can list out all Environment Variables (Env Vars) using the `env` command.

We can filter specific env vars using the grep command eg. `env | grep AWS`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command.
```sh
HELLO='world' ./bin/print_message.sh
```

Within a bash script we can set an env var without using export, eg.
```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open a new bash terminal (terraform/AWS-cli/etc.) in VSCode, it will not be aware of env vars you set in another window.

If you want env vars to persist across all future bash terminals, you need to set env vars in your bash profile, eg. `.bash_profile`

#### Persisiting Env Vars in Gitpod

We can persist env vars in Gitpod by storing them in Gitpod Secrets Storage.
```
gp HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensative env vars.

### AWS CLI Installation

AWS CLI is installed for this project via the bash script [`.bin/install_aws_cli.sh`](`.bin/install_aws_cli.sh`)

[Getting Stared Install(AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following cli command:

```sh
aws sts get-caller-identity
```

If it is successful, you will get a json payload that looks like this:

```json
    "UserId": "AID3CSV9MQAPJ1K3GFC8",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::1234567890122:user/terraform-beginner-bootcamp"
```

We'll need to generate AWS credentials in order to use the AWS CLI. Can also enable MFA for the account.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform Registry [registry.terraform.io](https://registry.terraform.io/)

- Providers are interfaces to API's that allow you to create interfaces in Terraform
- Modules are templates of Terraform configurations that shareable, resusuable, and portable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console

We can see all of the Terraform commands available by typing `terraform`

### Terraform Init

At the start of a Terraform project we will run `terraform init` to download the binaries used for the providers in the Terraform project.

### Terraform Plan

This will generate out a changeset for our current infrastructure state and what will be changed.

We can output this changeset by running `terraform plan`

### Terraform Apply

`terraform apply` will run a plan and pass the changeset to be executed by Terraform. This will prompt for approval, if we would like to auto-approve we can run `terraform apply --auto-aprove`

### Terraform Destroy

`terraform destroy` will delete resources.

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked file that maintains the current versioning of the modules and providers that should be used in this project.

This file should be backed up to the Version Controls System (VCS) .ie Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be commited** to your VCS. There is also a `.backup` file which contains the last previous state. **This should also not be commited to your VCS.**

These files contain sensative information. If you lose this information you will lose knowing the state of your infrastructure.

### Terraform Directory

`.terraform` directory contains binaries of Terraform providers. This directory is not backup up and sent to the VCS (see `.gitignore`)

## Issues with Terraform Cloud and Gitpod

When attempting to run terraform login it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud
```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```
Then create the file manually here:

```
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```
We have automated this workaround with the following bash script `bin/generate_tfrc_credentials`

# Git Save Work and Transfer to Other Branch

In branch you have been working run:

```sh
git fetch
git add .
git stash save
git checkout "name of branch you want to move saved dated into"
git stash apply
```
