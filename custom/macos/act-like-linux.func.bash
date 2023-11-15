# Linux like functions for macOS

# Usage: free -h
function free() {
    echo "Memory Usage:"
    echo "--------------"

    total_memory=$(sysctl -n hw.memsize)
    free_memory=$(vm_stat | grep 'Pages free:' | awk '{print $3 * 4096}')
    used_memory=$(vm_stat | grep 'Pages active:' | awk '{print $3 * 4096}')
    cached_memory=$(vm_stat | grep 'Pages occupied by compressor:' | awk '{print $6 * 4096}')

    if [[ $1 == "-h" ]]; then
        total_memory=$(($total_memory / 1024 / 1024 /1024))
        free_memory=$(($free_memory / 1024 / 1024))
        used_memory=$(($used_memory / 1024 / 1024))
        cached_memory=$(($cached_memory / 1024 / 1024))
        echo "Total:   ${total_memory} GiB"
        echo "Free:    ${free_memory} MiB"
        echo "Used:    ${used_memory} MiB"
        echo "Cached:  ${cached_memory} MiB"
    else
        echo "Total:   ${total_memory} bytes"
        echo "Free:    ${free_memory} bytes"
        echo "Used:    ${used_memory} bytes"
        echo "Cached:  ${cached_memory} bytes"
    fi

    echo "\n"
    echo "Additional Info from Top:"
    echo "-------------------------"
    top -l 1 -n 0 -stats cpu,mem

}