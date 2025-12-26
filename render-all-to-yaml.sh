#!/usr/bin/env bash

SITE_D=${HOME}/Developer/AJPippin/Other/Site
SRC_D=${SITE_D}/KeyValue
DST_D=${SITE_D}/YAML

for f in $(find ${SRC_D} -mindepth 3 -maxdepth 3 -type f -or -type l -name \*.txt | sort); do
  type=$(basename $(dirname $(dirname $f)))
  site=$(basename $(dirname $f))
  year=$(basename $f .txt)
#  echo "type=\"${type}\", site=\"${site}\", year=\"${year}\""

  src="${SRC_D}/${type}/${site}/${year}.txt"
  dst="${DST_D}/${type}/${site}/${year}.yaml"

  echo "${type}/${site}/${year}.txt:"
  nnma kv ${src} > ${dst}
done
