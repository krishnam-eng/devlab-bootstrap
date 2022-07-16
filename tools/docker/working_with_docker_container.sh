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
docker container rm $ID     # use -f to avoid intermediate stop step

# remove all stopped containers
docker container prune -f


# restart policy
#   no
#   always
#   on-failure if it failes with a nonzero exit code
docker container run --restart=always -d -it ubuntu /bin/bash

# privileged access  (_priv_ate _leg_is<law>)
#   linux divides privileges associated with superuser into distinct units
#   a.k.a capabilities `man capabilities`
#
# docker starts container with limited capabilities. and the more can be given.
docker container run -it ubuntu
mount --bind /home/ /mnt/ # permission denied

docker container run --privileged -i -t ubuntu /bin/bash
# now you can mount
# ! this mode causes security risks container can get root level access on the docker host
# use cap-drop for remove access
docker container run --cap-drop=CHOWN ubuntu /bin/bash

# accessing host device inside a container

#  <Host Device>:<Container Device>
#   sdc* - SCSI disk -> Small Computer System Interface Disk
#   xvd* - Xen Virtual Block Device Disk ->
docker container run --device=/dev/sdc:/dev/xvdc


# injecting new process inside container
#   exec comd enters the namespace and executes it
ID=$(docker container run -d ubuntu)
docker container exec -it $ID /bin/bash


# Reading container's metadata while doing debugging, automation and so on.
#   present it in json format
docker container inspect $ID
# use Go Style to access json
docker container inspect $ID --format='{{.Id}}'

# Labeling & Filtering
#   labels are key-value pairs and that can be used in filter
docker container run -d --label stability=dev ubuntu bin/bash -c "while [ true ]; do date; sleep 1; done"
docker container run -d --label stability=dev ubuntu bin/bash -c "while [ true ]; do date; sleep 1; done"
docker container run -d --label stability=prod ubuntu bin/bash -c "while [ true ]; do date; sleep 1; done"
docker container list --filter label=stability=dev

# Reaping a zombie inside a container
#
#  When a process exits, all the resources associated are released except its entry in the process table
#  This entry in the process table is kept until the parent process reads the entry to learn about the exit status of its child. This transient state of a process is called a zombie
# As soon as the parent process reads the entry, the zombie process is removed from the process table, and this is called reaping.
# If the parent process exits before the child process, the init/systemd process (PID 1) adopts the child process

# you need init process to reap the zombie
docker container run --init alpine

