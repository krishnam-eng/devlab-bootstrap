#!/usr/bin/env bash
################
#description    : Helper functions to work with debian env
#ubuntu_version : 21.04
#author	        : krishnam
################

function update {
  echo ${LOG_TS}$CS_bcyan"UPDATE: resynchronize the package index files from their sources....."$CS_reset
	sudo apt-get update --fix-missing

	echo ${LOG_TS}$CS_bgreen"UPGRADE: install the newest versions of all packages currently installed....."$CS_reset
	sudo apt-get dist-upgrade

  echo ${LOG_TS}$CS_bred"AUTO REMOVE: clean up unused dependencies....."$CS_reset
	sudo apt-get autoremove

  echo ${LOG_TS}$CS_bred"AUTO CLEAN: remove all strored archives in cache that can not be downloaded anymore....."$CS_reset
  sudo apt-get autoclean

  while getopts "ca" opt
  do
    case $opt in
      a)
        echo ${LOG_TS}$CS_bgreen"PIP: upgrade....."$CS_reset;
        sudo pip install --upgrade pip;;
      c)
        echo ${LOG_TS}$CS_bred"CLEAN: remove all strored archives in cache....."$CS_reset;
        sudo apt-get clean;;
    esac
  done
}
