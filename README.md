# Overview

The purpose of this project is to provision your machines (VM or bare metal) for running [k3s](https://github.com/rancher/k3s)

Utilizing Ansible, the current coverage of playbooks will:

- Provision your servers for running k3s
- Install k3s
- ...

## Install Local Dependancies

Before getting started make sure you have these following packages installed on your local machine

### Ubuntu

...

### Mac

```bash
brew install ansible curl jq kubernetes-cli kubectl kubernetes-helm git calicoctl git-crypt pre-commit terraform
```

## Running the Playbook

1) Update the Ansible vars and host inventory

    ```bash
    # Copy and update the variables to your liking
    cp ./ansible/group_vars/all.sample.yml ./ansible/group_vars/all.yml

    # Copy and update the hosts to your liking
    cp ./ansible/hosts.sample.yml ./ansible/hosts.yml
    ```

2) Run the playbook

    ```bash
    ansible ansible-playbook \
        -i ansible/hosts.yml \
        ansible/main.yml --ask-become-pass
    ```

## Running Tests

### Terraform

...

### Vagrant

#### Install Vagrant and Virtualbox On Mac

1) Install Vagrant

    ```bash
    brew cask install vagrant
    ```

2) Install Virtualbox 6.0

    ```bash
    # There's a bug with the latest version of Vagrant so it is recommended to install this version of Virtualbox
    brew cask install https://raw.githubusercontent.com/Homebrew/homebrew-cask/7e703e0466a463fe26ab4e253e28baa9c20d5f36/Casks/virtualbox.rb
    ```

3) Change Vagrant permissions

    ```bash
    sudo chown -R <YOUR_USERNAME>: /opt/vagrant/embedded/gems/2.2.6/gems/vagrant-2.2.6
    ```

#### Run Tests

1) Change to Vagrant directory

    ```bash
    cd test/vagrant
    ```

2) Run Vagrant

    ```bash
    vagrant up
    ```

3) Stop and remove Virtualbox VMs

    ```bash
    vagrant destroy -f
    ```

## Sources

A lot of this is a combination of various other playbooks that people have put together. See below for a handful of helpful source materials I used when piecing it together.

- https://github.com/itwars/k3s-ansible
- https://github.com/pixelpiloten/k3s-ansible
- https://github.com/geerlingguy/ansible-role-kubernetes
- https://github.com/onedr0p/k3s-gitops
- https://coderwall.com/p/13lh6w/dump-all-variables
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#best-practices-for-variables-and-vaults
- e2e test

