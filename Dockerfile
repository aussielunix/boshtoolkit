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

# Install gcloud
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-trusty main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-get update \
  && apt-get -qqy install google-cloud-sdk

# Install the aws cli
RUN pip install awscli

USER ubuntu

# Configure Direnv
RUN echo '# get direnv up and running' >> /home/ubuntu/.bashrc \
  && echo '#' >> /home/ubuntu/.bashrc \
  && echo 'eval "$(direnv hook bash)"' >> /home/ubuntu/.bashrc

## Install a minimalist vimrc
RUN git clone https://github.com/pajuna/vimrc.git /home/ubuntu/.vim \
  && ln -s /home/ubuntu/.vim/.vimrc /home/ubuntu/.vimrc

COPY tools/* /home/ubuntu/bin/

# Install a basic gitconfig
COPY .gitconfig /home/ubuntu

WORKDIR /home/ubuntu
