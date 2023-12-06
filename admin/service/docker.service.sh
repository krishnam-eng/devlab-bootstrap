# [Unit]
# Description=Enable Docker Ecosystem

function main(){
    _activate_dependencies

    _container_registry_authentication
}

# Authenticate with a container registry, such as Docker Hub.
# It allows you to log in to a registry so that you can push or pull images to and from that registry
function _container_registry_authentication(){
	# Generate a token with read/write access to the registry from Docker Hub
	#       > Account Settings > Security > New Access Token
	docker login -u balakrishnam --password-stdin < $HOME/hrt/vault/docker/access-token-homelab-rwd
}

function _activate_dependencies(){
  sudo apt install ufw
}