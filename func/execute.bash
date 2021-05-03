: <<'END'
=head1
Recipe: Running All Scripts in a Directory
todo: WIP
=cut
END

function runscripts () {
  dir="$(realpath $1)/*"
  echo $LOGTS"Running scripts from ${dir}"
  for script in ${dir}
  do
    echo ${script}
    if [ -f "${script}" -a -x "${script}" ]
    then
      echo "$LOG_TS ${script} ..."
      ${script}
    fi
  done
}
