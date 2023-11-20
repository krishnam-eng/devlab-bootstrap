#!/bin/bash
# Example usage:
#       labctl start docker
#       labctl stop docker
#       labctl restart docker
#       labctl status docker
#       labctl purge docker

labctl() {
    action="$1"
    service_name="$2"

    case "$service_name" in
        "docker")
            case "$action" in
                "start")
                    echo "Starting $app_name..."
                    init_docker_environment
                    ;;
                "stop")
                    echo "Stopping $app_name..."
                    shutdown_docker -A
                    ;;
                "restart")
                    echo "Restarting $app_name..."
                    shutdown_docker
                    init_docker_environment
                    ;;
                "status")
                    echo "Status of $app_name:"
                    inspect_docker
                    ;;
                "purge")
					echo "Purging $app_name..."
					purge_docker
					;;
                *)
                    echo "Invalid action for $app_name. Use {start|stop|restart|status}"
                    ;;
            esac
            ;;
        "k8s")
            # Similar case statements for other apps
            ;;
        *)
            echo "Unknown app: $app_name"
            ;;
    esac
}