#!/bin/bash


setting_author() {
    echo -e "\033[0;32mSetting author alastairruhm@gmail.com\033[0m"
    git config user.name "alastairruhm"
    git config user.email "alastairruhm@gmail.com"
}

generate_static_pages() {
    set -o errexit #abort if any command fails
    # Build the project.
    echo -e "\033[0;32mGenerate static pages using theme [null]...\033[0m"

    # if using a theme, replace by `hugo -t <yourtheme>`
    hugo
    # if hugo ; then
    #   echo -e "\033[0;32mHugo generate static pages successfully\033[0m"
    # else
    #   echo -e "\033[0;32mHugo generate static pages fail\033[0m"
    # fi
    set +o errexit #abort if any command fails
}

push_static_pages() {
    # Go To Public folder
    cd public
    # Add changes to git.
    git add -A
    # Commit changes.
    msg="rebuilding site $(date '+%Y-%m-%d %H:%M:%S')"
    if [ $# -eq 1 ]
      then msg="$1"
    fi
    git commit -m "$msg"
    # Push source to coding
    echo -e "\033[0;32mPush pages to coding\033[0m"
    git push origin master
    echo -e "\033[0;32mPush pages to github\033[0m"
    git push github master

    cd ..
}

push_hugo_site() {
    echo -e "\033[0;32mCommit hugo dir content updates to coding...\033[0m"
    # Add changes to git.
    git add -A
    updateTime=$(date '+%Y-%m-%d %H:%M:%S')
    # Commit changes.
    msg="updating hugo dir $updateTime"
    if [ $# -eq 1 ]
      then msg="$1"
    fi
    git commit -m "$msg"
    # Push source and build repos.
    echo -e "\033[0;32mPush hugo site source and article to coding\033[0m"
    git push origin master
    echo -e "\033[0;32mPush hugo site source and article to github\033[0m"
    git push github master
}



main () {
    setting_author
    generate_static_pages
    push_hugo_site
    push_static_pages
    # Come Back
    cd ..
    echo -e "\033[0;32mDone\033[0m"
}

main