# print start time
echo "DATE ||| $(date)"

# Swap out default Ubuntu mirror for a hopefully faster one
sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list

apt-get update && apt-get install --assume-yes \
    apache2 \
    apt-transport-https \
    ca-certificates \
    ccache \
    gdebi \
    git \
    libcurl4-openssl-dev \
    libmysqlclient-dev \
    libpq-dev \
    libssl-dev \
    libx11-dev \
    libxml2-dev \
    linux-image-extra-$(uname -r) \ # for Docker
    lmodern \
    mysql-client \
    python3 \
    wget

source install-docker.sh
