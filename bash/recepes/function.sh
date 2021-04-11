#!/usr/bin/env bash

mk_bkp_dir_for_file()
{
	abs_src_filepath=$1

	dir_name=dirname $abs_src_filepath
	bkp_dir="~/bkp/$dirname"
	mkdir -p $bkp_dir
	return $bkp_dir
}


take_bkp()
{
	abs_src_filepath=$1
	bkp_dir = mk_bkp_dir_for_file($abs_src_filepath)
	filename = filename $abs_src_filepath
	target_filename=$filename_$(date +%FT%T)
	echo $target_filename
	echo $bkp_dir
	cp $abs_src_filepath $bkp_dir/$target_filename
}
