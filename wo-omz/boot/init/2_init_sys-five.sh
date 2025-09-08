function main() {
  _start_init_as_first_user_space_process
}

# Starts with default.target (composed of high-level other targets)
function _activate_unit() {
        sh ../sys-v/inittab.sh
}