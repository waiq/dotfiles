## dotfiles-ansible-thing

Neverending "work in progress"!

## Why

Im trying to make it easy to have the same develop experiace on all my computors.

## How

By using ansible to install and setup, I have a record on how and what have
been installed.

## Overview

The 'core' folder contains tooling on how to maintaining the dotfiles itself.
This 'customs' folder contains the playbooks for setting upp the system.

## Install (WIP)

Install pipx

```
$> mkdir ~/.my/dotfiles/ && git clone
```

For now: clone and run

```
$> core/install.sh
```

## Command

The dotfiles will be controlled by the bash script dotrun

```
$> dotrun --help
```

By running the command without any parameters. It will ty to run all roles
defined under: 'custom/common/profile.yml'

```
$> dotrun
```
