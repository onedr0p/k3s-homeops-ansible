# Overview

This end-to-end test leverages Terraform to spin up 4 nodes and supporting components within Azure. It seeks to test the following:

1. That k3s and all required components installs as expected
2. That Ceph and NFS properly launch and provide service to the cluster
3. That basic services will run in the cluster

# High level flow

The terraform process follows the below steps:

1. Builds 4x VMs with associated tags for master/worker and storage (ceph/nfs)
2. The master node doubles as the NFS storage endpoint
3. Terraform kicks off the ansible bootstrap playbook with command line overrides (@overrides.yaml) to ensure that the configuration will deploy in Azure
4. Ansible uses dynamic inventory to find all the nodes and build host groups based on the VM's tags -- type (Worker/Node), and Storage (Ceph/NFS)


# Requirements

Ensure that the following environment variables are set within your shell session. There are a total of 4 values that need to be set. Ansible looks for the same data in a different variable than Terraform.

```
AZURE_TENANT
AZURE_SUBSCRIPTION_ID
AZURE_CLIENT_ID
AZURE_SECRET
ARM_TENANT_ID $AZURE_TENANT
ARM_SUBSCRIPTION_ID $AZURE_SUBSCRIPTION_ID
ARM_CLIENT_ID $AZURE_CLIENT_ID
ARM_CLIENT_SECRET $AZURE_SECRET
```
