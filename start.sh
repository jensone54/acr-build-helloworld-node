#!/bin/bash

if [[ ! -v REPOSITORY ]]; then
    echo "REPOSITORY env variable not set, should be in the format of a URL e.g. https://github.com/energinet-datahub/eo-selfhosted-runner"
    exit 1;
fi

if [[ ! -v TOKEN ]]; then
    echo "TOKEN env variable not set, is generated on the GitHub API or WebSite."
    exit 1;
fi

if [[ ! -v NAME ]]; then
    echo "NAME env variable not set, replaces existing runner with same name, since the container is ephemeral."
    exit 1;
fi

if [[ ! -v LABELS ]]; then
    echo "Configure without labels."
    ./config.sh --ephemeral --unattended --url ${REPOSITORY} --token ${TOKEN} --replace --name ${NAME}
else
    echo "Configure with labels: ${LABELS}"
    ./config.sh --ephemeral --unattended --url ${REPOSITORY} --token ${TOKEN} --replace --name ${NAME} --labels ${LABELS}
fi

echo "Starting runner.."
./run.sh
