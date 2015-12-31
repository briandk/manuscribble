# print start time
echo "DATE ||| $(date)"

# Swap out default Ubuntu mirror for a hopefully faster one
sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list

apt-get update && apt-get install --assume-yes \
    wget

# Install Docker
wget -qO- https://get.docker.com/ | sh

# Add vagrant user to docker group
usermod -aG docker vagrant

# Verify Docker works properly
docker run hello-world
