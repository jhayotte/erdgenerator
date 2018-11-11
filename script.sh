#!/bin/bash

: '
This script is used to generate the data model of
a postgres database passed in argument.

It generates a PDF in ouptut named docs/erd_from_{$1}.pdf

The following script is called through the target
`make run` with all argument required.
'

# ensure the correctness of the argument.
if [ "$1" != "" ]; then
    echo "Missing docker image name"
elif [ "$2" != "" ]; then
    echo "Missing database name in argument"
elif [ "$3" != "" ]; then
    echo "Missing database login"
elif [ "$4" != "" ]; then
    echo "Missing database password"
fi

export LOCALE_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1)

$(docker run --rm -e IP=$(printenv LOCALE_IP) -v "$(pwd):$(pwd)" -w "$(pwd)" --entrypoint=/bin/sh jhayotte/erdgenerator -xec "eralchemy -i "postgresql+psycopg2://$3:$4@$(printenv LOCALE_IP):5432/$2" -o docs/erd_from_$2.pdf")

exit 0