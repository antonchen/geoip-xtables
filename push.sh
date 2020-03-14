#!/bin/bash

setup_git() {
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis CI"
}

commit_files() {
    cd ~
    if ! (git clone --depth=1 -b releases https://${GH_TOKEN}@github.com/antonchen/geoip-xtables.git > /dev/null 2>&1); then
        git clone https://${GH_TOKEN}@github.com/antonchen/geoip-xtables.git > /dev/null 2>&1
        cd ~/geoip-xtables
        git checkout --orphan releases
        git rm -rf .
    else
        cd ~/geoip-xtables
        git checkout -b releases
    fi
    rm -rf BE LE
    cp -r ~/xt_build/{BE,LE} .
    git add .
    git commit -m "Travis build: $(date +%F)"
}

upload_files() {
    git push origin releases
}

setup_git
commit_files
upload_files
