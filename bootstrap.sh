# print start time
echo "DATE ||| $(date)"

# Variables
RSTUDIOVERSION='rstudio-server-0.99.792-amd64.deb'

# Add CRAN mirror to apt-get sources
add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu trusty/"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Swap out default Ubuntu mirror for a hopefully faster one
sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list

# install LaTeX, nodejs, R, and base Haskell
apt-get update && apt-get install --assume-yes \
    wget

# Install Docker
wget -qO- https://get.docker.com/ | sh

# Add vagrant user to docker group
usermod -aG docker vagrant

# Verify Docker works properly
docker run hello-world
