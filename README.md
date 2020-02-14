# Overview

This is my take on using Ansible to deploy both K3S and then also bootstrap the cluster to the point that it's able to use Flux to deploy additional services from a git repository.

There are points that are opinionated for my environment. For example, I keep all my secrets in code, but use encryption to limit access to them. This enables my environment to be portable and also secure.

This is also serving as a learning environment for Ansible too. PRs welcome and comments also welcome. :)

## Sources:

A lot of this is a combination of various other playbooks that people have put together. See below for a handful of helpful source materials I used when piecing it together.

- https://github.com/itwars/k3s-ansible
- https://github.com/pixelpiloten/k3s-ansible
- https://github.com/geerlingguy/ansible-role-kubernetes
- https://github.com/onedr0p/k3s-gitops
- https://coderwall.com/p/13lh6w/dump-all-variables
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#best-practices-for-variables-and-vaults

## Requirements
- Ansible
- jq
`sudo apt install jq`
- curl
- kubectl
- fluxctl
- calicoctl
- git-crypt
- pre-commit
