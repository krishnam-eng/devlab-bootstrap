#!/usr/bin/env zsh

# Function to fix port conflicts when starting web servers
fix_port_conflict() {
    local port=${1:-8080}
    
    echo "🔍 Checking for processes using port $port..."
    
    # Find process using the port
    local pid=$(lsof -ti:$port)
    
    if [[ -z "$pid" ]]; then
        echo "✅ Port $port is available"
        return 0
    fi
    
    # Get process details
    local process_info=$(ps -p $pid -o pid,comm,args --no-headers 2>/dev/null)
    
    if [[ -n "$process_info" ]]; then
        echo "🚨 Port $port is in use by:"
        echo "   PID: $pid"
        echo "   Process: $process_info"
        echo
        
        # Ask user what to do
        echo "Options:"
        echo "1) Kill the process (PID: $pid)"
        echo "2) Show alternative ports"
        echo "3) Exit"
        
        read "choice?Choose an option (1-3): "
        
        case $choice in
            1)
                echo "🔪 Killing process $pid..."
                kill $pid
                sleep 1
                # Verify it's killed
                if kill -0 $pid 2>/dev/null; then
                    echo "⚠️  Process still running. Force killing..."
                    kill -9 $pid
                fi
                echo "✅ Process killed. Port $port should now be available."
                ;;
            2)
                echo "📋 Here are some alternative ports you can use:"
                local alt_ports=(3000 8000 8081 8082 8888 9000 9001)
                for alt_port in $alt_ports; do
                    if ! lsof -ti:$alt_port > /dev/null 2>&1; then
                        echo "   ✅ Port $alt_port is available"
                    else
                        echo "   ❌ Port $alt_port is in use"
                    fi
                done
                ;;
            3)
                echo "👋 Exiting without changes"
                return 1
                ;;
            *)
                echo "❌ Invalid choice"
                return 1
                ;;
        esac
    else
        echo "⚠️  Could not get process information for PID $pid"
        echo "You can manually kill it with: kill $pid"
    fi
}

# Alias for common port 8080 issues
alias fix8080="fix_port_conflict 8080"