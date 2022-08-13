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
# test repo created - krishnam86/debian-apache

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
docker image inspect $ID

# [6] Removing an image
#   there is a -f force option also to remove image with multiple tags
docker image tag ubuntu-apache:latest ubuntu:20210601
docker image tag ubuntu-apache:latest ubuntu:20210501
docker image ls
docker image rm $ID

# error: image is referenced in multiple repo..
docker image rm -f $ID

# to delete all images
docker image rm $(docker image -ls -q)


# [7] Exporting an image (save as tar)
#
#   Let's say you have a customer who has very strict policies that do not allow them to use
# images from the public domain. In such cases, you can share one or more images through
# tarballs, which can then later be imported on another system.
docker image save --output=file.tar $ID

# [8] Importing an image
docker image save --output=alpine.tar alpine:latest
docker image import alpine.tar alpine:imported
docker image ls

# [9] Building an image using a Dockerfile
# docker build images as prescribed as per build instruction file _Dockerfile_
mkdircd sampleimg
nano Dockerfile
# FROM debian
# LABEL key=value
# CMD date
#
# only one CMD is allowed in file and RUN can be many
# ENTRYPOINT - to make container executable
# EXPOSE - network port on container on which it will listen at runtime
# ENV this is set env
# ADD/COPY this will copy from source (host os) to the destination (guest os)
# VOLUME will create mount
# USER set username for the following run instructions
# WORKDIR sets working dor for run,cmd, entrypoint
docker image build -t sample .
docker container run sample

# Building an Apache image - a Dockerfile example
# FROM alpine:3.6
# LABEL maintainer="Jeeva S. Chelladhurai <sjeeva@gmail.com>"
# RUN apk add --no-cache apache2 && \
# mkdir -p /run/apache2 && \
# echo "<html><h1>Docker Cookbook</h1></html>" > \
# /var/www/localhost/htdocs/index.html
# EXPOSE 80
# ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# [10] Setting up a private index/registry
#
#   to use something else other than default docker hub
# https://github.com/docker/docker-registry

# Automated builds - with GitHub and Bitbucket
#   The GitHub/Bitbucket repository should contain the Dockerfile and also the content that is to be
# copied/added inside the image
#
# Link GitHub with Docker Hub

# [11] Creating a custom base image
#
# install debootstrap and create image out of it as a base
apt-get install debootstrap
# using debootstrap, install Ubuntu 18.04 (Xenial Xerus)
sudo debootstrap xenial .
# You will see the directory tree, similar to any Linux root filesystem


# [12] Creating a minimal image using a scratch base image
#we custom-created a base image without any parent image
#However, that image is bloated with all the binaries and libraries that are shipped with the
#Ubuntu distribution. Typically, to run an application, we don't need the majority of
#the binaries and libraries we have bundled in the image. Besides, it leaves a large image
#footprint, and thus becomes a portability problem. To overcome this issue, you can
#diligently hand-pick the binaries and libraries that will constitute your image and then
#bundle the Docker image. Alternatively, you can build using Docker's reserved image,
#called a scratch image. This scratch image is explicitly an empty image, and it does not add
#any additional layer to your image.

# add the binary you want- build it with gcc

# FROM scratch
# ADD demo /
# CMD "/demo"

# [13] Building images in multiple stages
#

# [14] Visualizing the image hierarchy
