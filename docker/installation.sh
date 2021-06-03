#### Verify Docker Requirements

# not supported in 32-bit architecture
uname -i

# kernal version should be above 3.8
uname -r

# namespace and cgroups should be enabled
grep -i namespace /boot/config-5.11.0-17-generic
grep -i cgroups /boot/config-5.11.0-17-generic


#### Installing

# Update the apt package index and install packages to allow apt to use a repository over HTTPS
sudo apt-get upgrade

sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Use the following command to set up the stable repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \\n  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index, and install the latest version of Docker Engine and containerd
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io


###### Pulling image and running container

# Verify that Docker Engine is installed correctly by running the hello-world image.
sudo docker run hello-world

# docker deamon is located at /etc/docker
docker info
sudo systemctl start docker
sudo systemctl stop docker
sudo systemctl status docker
sudo systemctl enable docker

##### Adding nonroot user to admin docker
sudo groupadd docker
sudo useradd dockertester
sudo usermod -aG docker dockertester

##### Finding Help at various level
man docker
docker --help
docker container --help
docker container list --help

