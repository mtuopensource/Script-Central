#!/usr/bin/bash
# Open Source Club at Michigan Tech
# Last Modified on February 19, 2019
# Creates a new GitHub Repository from your local machine

ENDPOINT="https://api.github.com/user/repos"
LICENSE_TEMPLATE="gpl-3.0" # See https://help.github.com/articles/licensing-a-repository/#searching-github-by-license-type
OAUTH_KEY="FILL_ME_IN"

read -p "Repo Name: " name
read -p "Repo Desc: " description
read -p "Private [y/n]: " private # Hides GitHub Repository when true

if [ private == "y" ]; then
    private="true"
else
    private="false"
fi

number_of_errors=$(curl -X POST -s -S \
    -H "Authorization: token $OAUTH_KEY" \
    -d "{\"name\":\"$name\", \
        \"description\":\"$description\", \
        \"license_template\":\"$LICENSE_TEMPLATE\", \
        \"auto_init\":true, \"private\":$private}" \
    $ENDPOINT | tee -a $name.log | grep -i "errors" | wc -l)

echo "$number_of_errors errors"
