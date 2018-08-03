# BOSH & Cloud Foundry Toolkit

**WIP**

This is a collection of tools to help with the day1 and day2 operations of a
BOSH operator. This includes IaaS, BOSH, Cloud Foundry runtimes (PAS, PKS, PFS
etc) and more.

``` bash
docker run -it --rm --user $(id -u):$(id -g) -v $(pwd):/workspace aussielunix/cftoolkit:latest /bin/bash

```

The current list of tools installed are:

* direnv
* git
* jq
* pwgen
* python
* ruby
* vim
* wget
* curl
* cf-cli
* bosh-cli
* credhub-cli
* bbl
* fly (concourse-cli)
* pivnet
* terraform
* aws-cli
* gcloud-cli
* cf-mgmt
* cf-mgmt-config
* uaac

## TODO

Need to add the following tools:

* om
* azure cli
