#!/usr/bin/bash
# Open Source Club at Michigan Tech
# Last Modified on February 19, 2019
# Creates a new GitHub Repository from your local machine

ENDPOINT="https://api.github.com/user/repos"
LICENSE_TEMPLATE="gpl-3.0"      # See https://help.github.com/articles/licensing-a-repository/#searching-github-by-license-type

# Finds line labeled with Github_Token
# Extracts portion after "="
OAUTH_KEY=$(grep -h Github_Token < secrets.txt | cut -d "=" -f 2)

read -p "Repo Name: " name
read -p "Repo Desc: " description
read -p "Private [y/n]: " private # Hides GitHub Repository when true

if [ private == "y" ]; then
    private="true"
else
    private="false"
fi

# This chunk creates the variables to be POSTed to Github and
# sends it with the curl command.

# The last line redirects the output to a .log file then 
# pulls out and counts all errors, then prints the error count to the user.

number_of_errors=$(curl -X POST -s -S \
    -H "Authorization: token $OAUTH_KEY" \
    -d "{\"name\":\"$name\", \
        \"description\":\"$description\", \
        \"license_template\":\"$LICENSE_TEMPLATE\", \
        \"auto_init\":true, \"private\":$private}" \
    $ENDPOINT | tee -a $name.log | grep -i "errors" | wc -l)

echo "$number_of_errors errors"


# Get username from .log file
USER=$(grep -h login Test2.log | cut -d ":" -f 2 | cut -d "\"" -f 2)

# Clone repository into specified directory
if [ $number_of_errors -eq 0 ]; then
    read -p "where would you like to clone into?: " repo_path
    current_path=$(pwd)
    cd $repo_path

    read -p "Do you use GitHub 2FA? [y/n]: " tfa
    if [ tfa == "true" ]; then
        git clone git@github.com:$USER/$name.git
    else
        git clone https://github.com/$USER/$name.git
    fi
    cd $current_path
fi
