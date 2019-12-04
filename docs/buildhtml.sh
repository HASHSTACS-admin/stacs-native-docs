#!/bin/bash

# buildhtml.sh

# Builds the html static site, using mkdocs

set -e

GENERATOR_DIR="docs"
SRC_DIR="${GENERATOR_DIR}/src"


echo "Fetching localization project"
LOC_DIR=${GENERATOR_DIR}/localization

echo "Preparing directories"
MKDOCS_DIR="doc"
DOCS_DIR=${GENERATOR_DIR}/${MKDOCS_DIR}
MKDOCS_CONFIG_FILE="${DOCS_DIR}/mkdocs.yml"
rm -rf ${DOCS_DIR}

prep_html() {
	lang="${1}"

	echo "Calling mkdocs"

	# Build html docs
	mkdocs build --config-file="${MKDOCS_CONFIG_FILE}"
}

for d in "zh" "en"; do
	echo "Preparing source for $d"
	cp -dr ${SRC_DIR} ${DOCS_DIR}
	cp -a ${LOC_DIR}/${d}/* ${DOCS_DIR}/
	prep_html $d
	rm -rf ${DOCS_DIR}
done

# Remove cloned projects and temp directories
rm -rf  ${DOCS_DIR}

echo "Finished"
