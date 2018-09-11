FROM ubuntu:16.04

# Install base packages
RUN apt-get update \
  && apt-get -y install \
  apt-transport-https \
  build-essential \
  curl \
  direnv \
  dnsutils \
  git \
  jq \
  libreadline6 \
  libreadline6-dev \
  libsqlite3-dev \
  libssl-dev \
  libxml2-dev \
  libxslt-dev \
  libyaml-dev \
  openssl \
  pwgen \
  python \
  python-dev \
  python-pip \
  python-virtualenv \
  ruby \
  ruby-dev \
  sqlite3 \
  unzip \
  vim \
  wget  \
  zlibc \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*  \
  && groupadd -g 1001 ubuntu \
  && useradd -u 1001 -g 1001 -s /bin/bash -d /home/ubuntu -m --no-log-init -r ubuntu

# Install uaac
RUN gem install cf-uaac

# Install the aws cli
RUN pip install awscli

# Install gcloud
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-trusty main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-get update \
  && apt-get -qqy install google-cloud-sdk

USER ubuntu

# Install cf-cli
RUN mkdir /home/ubuntu/bin \
    && curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx -C /home/ubuntu/bin

# Install cf-mgmt
RUN curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.91/cf-mgmt-config-linux > /home/ubuntu/bin/cf-mgmt-config \
  && chmod a+x /home/ubuntu/bin/cf-mgmt-config

# Install cf-mgmt-config
RUN curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.91/cf-mgmt-linux > /home/ubuntu/bin/cf-mgmt \
  && chmod a+x /home/ubuntu/bin/cf-mgmt

# Install bosh-cli
RUN curl -L https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.48-linux-amd64 > /home/ubuntu/bin/bosh \
  && chmod a+x /home/ubuntu/bin/bosh

# Install credhub-cli
RUN bash -o pipefail -c "curl -L https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.7.5/credhub-linux-1.7.5.tgz | tar -xz -C /home/ubuntu/bin"

# Install bbl
RUN curl -L "https://github.com/cloudfoundry/bosh-bootloader/releases/download/v6.8.3/bbl-v6.8.3_linux_x86-64" > /home/ubuntu/bin/bbl \
  && chmod 0755 /home/ubuntu/bin/bbl

# Install the concourse cli - fly
RUN curl -L "https://github.com/concourse/concourse/releases/download/v3.13.0/fly_linux_amd64" > /home/ubuntu/bin/fly \
  && chmod 0755 /home/ubuntu/bin/fly

# Install pivnet
RUN curl -L "https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.51/pivnet-linux-amd64-0.0.51" > /home/ubuntu/bin/pivnet \
  && chmod 0755 /home/ubuntu/bin/pivnet

# Install terraform
RUN curl -L https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip > /tmp/terraform.zip \
  && unzip /tmp/terraform.zip terraform -d /home/ubuntu/bin \
  && rm /tmp/terraform.zip

# Configure Direnv
RUN echo '# get direnv up and running' >> /home/ubuntu/.bashrc \
  && echo '#' >> /home/ubuntu/.bashrc \
  && echo 'eval "$(direnv hook bash)"' >> /home/ubuntu/.bashrc

## Install a minimalist vimrc
RUN git clone https://github.com/pajuna/vimrc.git /home/ubuntu/.vim \
  && ln -s /home/ubuntu/.vim/.vimrc /home/ubuntu/.vimrc

RUN echo "PATH=/home/ubuntu/bin:$PATH" >> /home/ubuntu/.bashrc

WORKDIR /home/ubuntu
