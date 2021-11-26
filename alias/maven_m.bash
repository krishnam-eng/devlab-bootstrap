#!/usr/bin/env bash

### Frequently Used alias
alias m='mvn'

# Cool Tricks

# Run mvn against the pom found in a project's root directory (assumes a git repo)
alias 'mvn!'='mvn -f $(git rev-parse --show-toplevel 2>/dev/null || echo ".")/pom.xml'

# Default Life Cycle 
alias mvd='mvn validate'	# Validates that the project is correct and all necessary information is available. This also makes sure the dependencies are downloaded.
alias mc='mvn compile'	# Compiles the source code of the project.
alias mut='mvn test'	  # Runs the tests against the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed.
alias mp='mvn package'	# Builds the project described by your Maven POM file and installs the resulting artifact (JAR) into your local Maven repository
alias mit='mvn integration-test'	# Runs all integration tests found in the project. This can be configured to do addtional checks also.
alias mvf='mvn verify'	# This can be configured to do addtional checks.
alias mi='mvn install'	# Install the package into the local repository, for use as a dependency in other projects locally.
alias md='mvn deploy'	  # Copies the final package to the remote repository for sharing with other developers and projects.

# Buit-in Life Cycle
alias mct='mvn clean' # Clears the target directory into which Maven normally builds your project.
alias mcp='mvn clean package'	# Clears the target directory and Builds the project and packages the resulting JAR file into the target directory.
alias mcv='mvn clean verify'	# Cleans the target directory, and runs all integration tests found in the project.
alias mci='mvn clean install'	# Clears the target directory and builds the project described by your Maven POM file and installs the resulting artifact (JAR) into your local Maven repository


# Test 
alias mpst='mvn package -Dmaven.test.skip=true'	# Builds the project and packages the resulting JAR file into the target directory - without running the unit tests during the build.
alias mcpst='mvn clean package -Dmaven.test.skip=true'	# Clears the target directory and builds the project and packages the resulting JAR file into the target directory - without running the unit tests during the build.
alias mist='mvn install -Dmaven.test.skip=true'	# Builds the project described by your Maven POM file without running unit tests, and installs the resulting artifact (JAR) into your local Maven repository
alias mcist='mvn clean install -Dmaven.test.skip=true'	# Clears the target directory and builds the project described by your Maven POM file without running unit tests, and installs the resulting artifact (JAR) into your local Maven repository

# Dependency
alias mdt='mvn dependency:tree'	# Prints out the dependency tree for your project - based on the dependencies configured in the pom.xml file.
alias mdtv='mvn dependency:tree -Dverbose'	# Prints out the dependency tree for your project - based on the dependencies configured in the pom.xml file. Includes repeated, transitive dependencies.
alias mdti='mvn dependency:tree -Dincludes=' # com.fasterxml.jackson.core	Prints out the dependencies from your project which depend on the com.fasterxml.jackson.core artifact.

alias mdbc='mvn dependency:build-classpath'	# Prints out the classpath needed to run your project (application) based on the dependencies configured in the pom.xml file.

alias mdcp='mvn dependency:copy-dependencies'	# Copies dependencies from remote Maven repositories to your local Maven repository.


# Others
alias mvnag='mvn archetype:generate'
alias mvnboot='mvn spring-boot:run'
alias mvn-updates='mvn versions:display-dependency-updates'