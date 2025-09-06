## Docker Compose
### Docker Compose Core
* Declarative Tool
  * Configuration as Code
    * Self-Documenting 
    * Version Controlled
    * Easy Management
  * Designed for 
    * Single hosted server - not for distributed systems
    * Non-Production environments - Local Dev, Staging, CI Testing 
  
  #### Build Arguments
  * Env Var
    * Set at runtime
    * Can be changed without rebuilding
  * Build Var
    * Set at build time
    * Cannot be changed without rebuilding

#### Volume Mount 
* Mount a host directory as a data volume
* supports bash directory expansion
* :access mode e.g., :ro

#### Named Volume
for sharing data between different services' containers
or persisting data between runs of different containers for the same service.

```docker-compose down --volumes : to remove named volumes```

#### Port Mapping

#### Startup Order
* depends_on
  * only waits for container to be created, not for it to be ready
  * does not wait for links to be fully up
  * does not wait for volumes to be fully up
  * rocker compose gives health checks to wait for container to be ready

#### Service Profiles 
 * Named subsets of services
 * Can be used to define different configurations for different environments
```docker-compose --profile backburner up```

#### Multiple compose files 
* It is recommended to use a single compose file
* however, use multiple compose files to override the base file 
```docker-compose -f docker-compose.yml -f docker-compose.dev.yml up```

#### Environment Variables
Host Machine -> docker-compose.yml -> Container
.env -> docker-compose.yml -> Container
```docker-compose --env-file .env up```