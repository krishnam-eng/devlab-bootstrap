# help
# > docker <cmd> help

# terms
#   client - docker cli, docker daemon, docker engine, docker host, docker hub, registry

# Listing and searching for an image
docker search -limit 5 alpine


# Pulling a image - name:tag@digest
#   tag - by default latest , use --all-tag to get all
#   digest- addressable identifier - if you want work with specific image
docker image pull ubuntu:latest

# List: talks to docker engine to get list of images that are downloaded to the docker host
docker image ls
docker image list
docker images

# Run container
#   -i -> interactive mode by keeping STDIN open
#   -t -> tty/pty
#         teletype - allows you to interact with the system by passing what you input and displaying the outp
#         allocates pseudo-tty and attache it to std input
docker container run -it --name mytestctr ubuntu /bin/bash

# ctr+p+q quit with detach and later, `docker container attach`
# ctr+d exit

# run = create + start, create and later you can start
ID=$(docker container create -it ubuntu /bin/bash)
docker conatiner start -a -i $ID

# -a attach mode -d detach mode
ID=$(docker container run -d -t -i ubuntu /bin/bash)
docker container attach $ID

# to remove container after cmd exit, use -rm
docker container run --rm ubuntu date

# List container - daemon will look at the metadata
docker container ls
docker container list
docker ps

docker container ls --latest # last created
docker container ls --size   # display total size
docker conatiner ls --quiet  # only display the container id

# view log
ID=$(docker container run -d ubuntu bin/bash -c "while [ true ]; do date; sleep 1; done")
docker container logs $ID

# stopping a container. move from running -> stop state, this can be moved to -> start again
ID=$(docker container run -d ubuntu bin/bash -c "while [ true ]; do date; sleep 1; done")
docker container stop $ID

# Stop all conatiners
docker container stop $(docker ps -q)

# Remove it permanently
ID=$(docker container run -d ubuntu bin/bash -c "while [ true ]; do date; sleep 1; done")
docker container stop $ID
docker container rm $ID   # use -f to avoid intermediate stop step

