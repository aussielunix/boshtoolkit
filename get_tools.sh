#!/bin/bash

curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx -C tools
curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.91/cf-mgmt-config-linux > tools/cf-mgmt-config
curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.91/cf-mgmt-linux > tools/cf-mgmt
curl -L https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.48-linux-amd64 > tools/bosh
curl -L "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.7.5/credhub-linux-1.7.5.tgz" | tar -xz -C tools/credhub
curl -L "https://github.com/cloudfoundry/bosh-bootloader/releases/download/v6.8.3/bbl-v6.8.3_linux_x86-64" > tools/bbl
curl -L "https://github.com/concourse/concourse/releases/download/v3.13.0/fly_linux_amd64" > tools/fly
curl -L "https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.51/pivnet-linux-amd64-0.0.51" > tools/pivnet
curl -L https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip > terraform.zip
unzip terraform.zip -d tools/
rm terraform.zip
chmod -R 0755 tools
