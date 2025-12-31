#!/usr/bin/env bash

#
# Directory schema is $file/$site/$media
#   where:  $file =  `Details`, `HTML`, `Index`, `KeyValue`, or `YAML`.
#           $site =  `MetArt`, `SexArt`, `VivThomas`, or `X-Art`
#           $media = `Movies` or `Galleries`
#

SITES="MetArt SexArt VivThomas X-Art"
TYPES="Galleries Movies"

SITE_D=${HOME}/Developer/AJPippin/Other/Site
SRC_D=${SITE_D}/KeyValue    # .../$site/$media
JSN_D=${SITE_D}/JSON        # .../$site/$media
YML_D=${SITE_D}/YAML        # .../$site/$media

function render_all() {
  format=yaml
  case "${1:-yaml}" in
    *json*)
      format=json
      target="${JSN_D}"
      ;;
    *yaml*)
      format=yaml
      target="${YML_D}"
      ;;

    *)
      echo "Unrecognized format: \"${format}\"" >>/dev/stderr
      ;;
  esac

  echo "Rendering ${format}:"
  for site in ${SITES}; do
    if [[ -d "${SRC_D}/${site}" ]]; then
      for type in ${TYPES}; do
        if [[ -d "${SRC_D}/${site}/${type}" ]]; then

          echo "  * ${site}/${type} ..."
          for f in $(find ${SRC_D}/${site}/${type} -type f -or -type l -name \*.txt | sort); do
            in="${f}"
            out="${target}/${site}/${type}/$(basename "${in}" .txt).${format}"
#            echo "in:  ${in}"
#            echo "out: ${out}"
#            echo ""
            mkdir -p "${target}"/"${site}"/"${type}"
            nnma kv --"${format}" ${in} > ${out}
          done

        fi # type dir exists
      done
    fi # site dir exists
  done
}

render_all yaml
echo ""
render_all json


