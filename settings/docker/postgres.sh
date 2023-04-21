/usr/bin/env bash

# download required imagesß
docker pull postgres
docker pull dpage/pgadmin4

# Set password for pg server and the use name is what you give in the <X>@domain
docker run -d --name dev-postgres -e POSTGRES_PASSWORD=dpgpwd -v ${HOME}/hrt/vol/postgres-data/:/var/lib/postgresql/data -p 5432:5432 postgres

# Give the actual valid email id
docker run -p 80:80 -e 'PGADMIN_DEFAULT_EMAIL=X@domain.local' -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' --name dev-pgadmin -d dpage/pgadmin4

# IP Address of the running container
docker container inspect dev-postgres -f "{{json .}}" | jq

# Connect to localhost:80 for pg admin
# Connect to pg server from pg admin using the IP address obtained from inspect command.

# Detailed Explanation -> https://towardsdatascience.com/local-development-set-up-of-postgresql-with-docker-c022632f13ea





