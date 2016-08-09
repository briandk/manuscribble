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
    linux-image-extra-$(uname -r) \
    lmodern \
    mysql-client \
    python3 \
    wget

install_docker() {

##################################################################################
#  Install Docker https://docs.docker.com/engine/installation/linux/ubuntulinux/ #
##################################################################################

## Add docker GPG key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
## Add docker APT Repository
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main"> /etc/apt/sources.list.d/docker.list
apt-get update
## purge the old repo if it exists
apt-get purge lxc-docker
## verify that APT is pulling from the right repo
apt-cache policy docker-engine
## install the main docker package and start the service
apt-get install --assume-yes docker-engine && \
    service docker start

##################################################################################
#  Install TeXlive full distribution, but skip all the docs packages             #
##################################################################################
curl https://gist.githubusercontent.com/briandk/924d101f28dbf309758206fa3eff32b4/raw/cf6da6ccf5fc5f9c07b655c6bb44262cedc4bf4c/install-texlive-without-docs.py | python3

# Add ubuntu user to docker
#   https://docs.oracle.com/cd/E52668_01/E54669/html/section_rdz_hmw_2q.html
groupadd docker
service docker restart
usermod -aG docker ubuntu
}
