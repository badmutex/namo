#!/usr/bin/env bash

set -x

add_ssh_key() {
    local user=$1
    local dotssh=~$user/.ssh
    mkdir -vp $dotssh
    cat <<EOF>$dotssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2LfEdkqN4WMjeeAPy34asxsWJ5DW6+VUG005h1uBq7zIoa1/DYzYgk+QTYqnWvJs6hJqRoVp3Yf0TRH0XuoZYVizxK2YMq7DCYMyk7ELxxCIf9hkKBkyNygH05Ds0SOXcvM2GSImUb7PgwuN3mb38tJaKeRi7v9u4bSlYL00Riy/SutsJFa6A2Hf3Z3ZYIyay2RHyJMQFHINJ/1b3aGB605E2Tx7NhxE03T7OTC7ISlBSbb85AE7WdRMygxX1TzmQTBQ8Etu41Xt/Ed+Wkg6/QvlJk7ej69xIMCJkTlk1dmQXKvFbEn7xfVTPY/FQtg41QITlJ2NFLCUezeMMaEs9 passwordless abdulwahidc@gmail.com
EOF
    chmod 700 $dotssh
    chmod 600 $dotssh/*
    chown -R $user:$user $dotssh
}


# mandos
useradd mandos
echo mandos:mandos | chpasswd
add_ssh_key

# badi
adduser -m badi
add_ssh_key

