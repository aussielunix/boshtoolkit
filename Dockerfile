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

# Install cf-cli
RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx -C /usr/local/bin

# Install bosh-cli
RUN curl -L https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.48-linux-amd64 > /usr/local/bin/bosh \
  && chmod a+x /usr/local/bin/bosh

# Install credhub-cli
RUN bash -o pipefail -c "curl -L https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.7.5/credhub-linux-1.7.5.tgz | tar -xz -C /usr/local/bin"

# Install bbl
RUN curl -L "https://github.com/cloudfoundry/bosh-bootloader/releases/download/v6.6.11/bbl-v6.6.11_linux_x86-64" > /usr/local/bin/bbl \
  && chmod 0755 /usr/local/bin/bbl

# Install the concourse cli - fly
RUN curl -L "https://github.com/concourse/concourse/releases/download/v3.13.0/fly_linux_amd64" > /usr/local/bin/fly \
  && chmod 0755 /usr/local/bin/fly

# Install terraform
RUN curl -L https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip > /tmp/terraform.zip \
  && unzip /tmp/terraform.zip terraform -d /usr/local/bin \
  && rm /tmp/terraform.zip
# Install the aws cli
RUN pip install awscli

# Configure Direnv
RUN echo '# get direnv up and running' >> /home/ubuntu/.bashrc \
  && echo '#' >> /home/ubuntu/.bashrc \
  && echo 'eval "$(direnv hook bash)"' >> /home/ubuntu/.bashrc

## Install a minimalist vimrc
RUN git clone https://github.com/pajuna/vimrc.git /home/ubuntu/.vim \
  && ln -s /home/ubuntu/.vim/.vimrc /home/ubuntu/.vimrc

# Install gcloud
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-trusty main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-get update \
  && apt-get -qqy install google-cloud-sdk

# Install a basic gitconfig
#COPY .gitconfig /home/ubuntu

WORKDIR /home/ubuntu
