# [1] Creating an image from a container
# two ways of creating image
#   1. from modified container
#   2. from dockerfile
docker container diff $ID # list all changes to the container filesystem
docker container commit $ID imagename_1

#e.g
docker container -it run ubuntu
apt-get update && apt-get install apapche2


# [2] Creating an account with Docker Hub
#
# Docker Hub is a cloud-based public registry service to host both public and private images,
# share them, and collaborate with others. It has integration with GitHub and Bitbucket, and
# can trigger automated builds

# username: krishnam86
# email: krishnam.balamurugan.eng@gmail.com
# test repo created - krishnam86/ubuntu-apache

# [3] Logging in and out of a Docker image registry
#
#   By default, both the docker login and docker logout commands assume
#   hub.docker.com as the default registry, but this can be changed (e.g about.gitlab.com).
docker login
docker logout
docker login -u xuser -p xpass

# [4] Publishing an image to a registry
docker image tag ubuntu-apache krishnam86/ubuntu-apache
docker image push krishnam86/ubuntu-apache

# [5] Looking at the history of an image
#
# It is imperative to have deep understanding of the docker image that we use
docker image history $ID

# Removing an image

# Exporting an image

# Importing an image

# Building an image using a Dockerfile

# Building an Apache image - a Dockerfile example

# Setting up a private index/registry

# Automated builds - with GitHub and Bitbucket

# Creating a custom base image

# Creating a minimal image using a scratch base image

# Building images in multiple stages

# Visualizing the image hierarchy
