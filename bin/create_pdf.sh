#!/bin/bash
#@author Fred Brooker <git@gscloud.cz>

find . -maxdepth 1 -iname "*.md" -exec echo "converting {} to ADOC ..." \; -exec docker run --rm -v "$(pwd)":/data pandoc/core -f markdown -t asciidoc -i {} -o "{}.adoc" \;
find . -maxdepth 1 -iname "*.adoc" -exec echo "converting {} to PDF ..." \; -exec docker run --rm -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf -a allow-uri-read -d book "{}" \;
find . -maxdepth 1 -iname "*.adoc" -delete
