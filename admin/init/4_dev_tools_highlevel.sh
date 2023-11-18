function load_dev_tools(){
    # Java Dev: Basic Development Tools & Others
    sudo apt install openjdk-11-jre-headless
    sudo apt install openjdk-8-jre-headless
    sudo add-apt-repository ppa:cwchien/gradle # use this repo to get latest gradle version
    sudo apt install gradle          # build tool & dependency manager
    sudo apt install httpie          # user-friendly command-line HTTP client for the API era
    sudo apt install apache2         # [optional] web server
    sudo apt install nginx           # [optional] web server
    sudo apt install tomcat9         # [optional] servlet container
    sudo apt install nodejs          # [optional] servlet container
    sudo apt install npm             # [optional] package manager for the nodejs platform
    sudo apt install apache2-utils   # [optional] ab: apache bench for cli single page load test, htpassword : create pwd
    sudo apt install openssl         # [optional] to create ssl certificates
    sudo snap install intellij-idea-community --classic # [optional] IDE for JVM

    # Python Dev: Virtual Env & Others
    sudo apt install python3.9       # python latest (already installed)
    sudo apt install python3-pip     # package management - Pip Installs Packages
    pip install autopep8             # vscode needs this for auto formatting
    sudo apt install virtualenv      # provides virtual environment - has its own Python binary and independent set of Python packages
    pip install virtualenvwrapper    # provides a set of commands that extend Python virtual environments for more control and better manageability. It places all your virtual environments in one directory
    sudo apt install pipx            # [optional] help you install and run end-user applications written in Python into an isolated environment. It's roughly similar to apt-get.
    pip install locust               # [optional] open source load testing tool, define user behaviour with Python code
    pip install rope                 # [optional] python refactoring library - used in vscode
    sudo snap install --classic code # IDE for light weight project (python, scripts)

    # Container: Check latest instructions from
    # https://docs.docker.com/engine/install/ubuntu/
    # Step 1: Set up the repository
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-releasesudo apt install docker-ce
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # Step 2: Install Docker Engine
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    # Step3: Check
    sudo docker run hello-world
    # Docker Compose
    # https://docs.docker.com/compose/install/
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version

    # just for fun
    sudo apt install cowsay            # An ASCII cow in terminal that will say what ever you want
    sudo apt install figlet            # utility for creating ASCII text banners or large letters out of ordinary text
    sudo apt install cmatrix           # shows a scrolling ‘Matrix‘ like screen in a Linux terminal [Not in venv setup]
    sudo apt install lolcat            # [Not in venv setup]

    # clean if any package is no longer needed
    sudo apt update; sudo apt upgrade ; sudo apt autoremove
}