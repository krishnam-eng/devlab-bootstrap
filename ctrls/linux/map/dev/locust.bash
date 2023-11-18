alias lo="locust"

alias locf="locust --config"

# locust execute swarm
lostsw(){
  locustfile=$1

  basedir=$(dirname $locustfile)

  conf_file=$(find ${basedir}/*.conf)

  echo "${LOG_TS} Found ${conf_file}"

  locust --locustfile $locustfile --config ${conf_file}
}

alias lohp="locust --help"
