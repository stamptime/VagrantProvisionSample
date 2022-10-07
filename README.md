# Virtualization and containers final project 
## Description:
This project uses vagrant to create 2 VM's by default, both machines are provisioned and configured as a GitHub Runner at the global organization settings.
- The VM 1 is provisioned with Docker.
- The VM 2 is provisioned with Podman.

VM 1 uses a docker-compose.yml file that creates and exposes the following containers and ports:

|||
| --- | --- |
| `sonarqube-service` | `ports: 9000`<br>`image: sonarqube:alpine`|
| `jenkins-service` | `ports: 8080, 8082` <br>`image: jenkins:2.60.3-alpine`|
| `nexus-service` | `ports: 8081` <br>`image: sonatype/nexus3` |
| `postgres-service` | `ports: 5432` <br>`image: postgres:alpine`| 
| `portainer-service` | `ports: 9443, 8000` <br>`image: portainer/portainer-ce:alpine`|

## Requirements:
* Vagrant and VirtualBox installed
* Personal Github Token
* You need to create a local.yml file at the same level of the Vagrantfile


#### Recommendations:
To avoid `Timed out while waiting for the machine to boot` on windows OS we recommend to disable "Hyper V", "Windows hypervisor platform" and "Virtual machine platform" windows features.

Check for [more information](https://stackoverflow.com/questions/43379459/vagrant-up-it-stops-at-ssh-auth-method-private-key).

-----
## `local.yml` environment Variables ##

| Environment Variable | Description |
| --- | --- |
| `token` | For the runner provision you can use or create a [personal token](https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) in your Github account . This token needs repo and admin:org permissions. |


##### `local.yml` file example

```yml
---
token: <your_personal_token>

```
-----
## `settings.yml` environment Variables ##

| Environment Variable | Description |
| --- | --- |
| `image` | Image of OS for the VM, currently using `ubuntu/jammy` 64 by default|
| `base-name` | Base template for the VM naem, currently name `devops-runner-team-4` followed by the vm machine number |
| `amount` | Number of VM's to create, by default set to create `2`|


##### `settings.yml` file example

```yml
---
image: ubuntu/jammy64
vm: 
  base-name: devops-runner-team-4
  amount: 2

```

## Run Program

Use the `vagrant up` command in your terminal.

