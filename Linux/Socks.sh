#!/bin/bash

###############
# Name: ssh to socks
# Author: Ztj
# Email: ztj1993@gmail.com
# Use: curl -sSL https://dwz.cn/wut41WR0 > /tmp/Socks && bash /tmp/Socks install
###############

### args
alias=${1}
command=${2}

### global variable
script_path=$(readlink -f "$0")
data_dir=~/.ssh_to_socks

### variable default value
socks_bind_address=${socks_bind_address:-127.0.0.1}
socks_bind_port=${socks_bind_port:-1080}
ssh_host=${ssh_host:-proxyserver}
ssh_port=${ssh_port:-22}
ssh_user=${ssh_user:-proxyuser}
ssh_pass=${ssh_pass:-proxypass}

### command function
function get_log_file(){
    echo ${data_dir}/${alias}.log
}
function get_daemon_file(){
    echo ${data_dir}/${alias}.daemon
}
function get_options_file(){
    echo ${data_dir}/${alias}.conf
}
function get_ssh_command(){
    socks_bind=${socks_bind_address}:${socks_bind_port}
    ssh_server=${ssh_user}@${ssh_host}
    echo "ssh -o StrictHostKeyChecking=no -N -D ${socks_bind} ${ssh_server}"
}
function is_started(){
    pgrep -f "$(get_ssh_command)" > /dev/null
    if [[ $? == 0 ]]; then
        echo "yes"
    else
        echo "no"
    fi
}
function options_make(){
    options_file=$(get_options_file)
    mkdir -p $(dirname ${options_file})
    echo "socks_bind_address=${socks_bind_address}" > ${options_file}
    echo "socks_bind_port=${socks_bind_port}" >> ${options_file}
    echo "ssh_host=${ssh_host}" >> ${options_file}
    echo "ssh_port=${ssh_port}" >> ${options_file}
    echo "ssh_user=${ssh_user}" >> ${options_file}
    echo "ssh_pass=${ssh_pass}" >> ${options_file}
    cat ${options_file}
    echo ">>> Info: make options file success"
}
function options_source(){
    if [[ -f $(get_options_file) ]]; then
        source $(get_options_file)
    else
        options_make
    fi
}
function options_socks_bind(){
    if [[ "${1}" = "--help" ]] ; then
        echo ">>> Example: ssh_to_socks ${FUNCNAME} {address} {port}" && return 0
    fi

    echo ">>> Info: set socks bind address and port"
    export socks_bind_address=${1:-${socks_bind_address}}
    export socks_bind_port=${2:-${socks_bind_port}}

    options_make
}
function options_ssh_server(){
    if [[ "${1}" = "--help" ]] ; then
        echo ">>> Example: ssh_to_socks ${FUNCNAME} {host} {port}" && return 0
    fi

    echo ">>> Info: set ssh host and port"
    export ssh_host=${1:-${ssh_host}}
    export ssh_port=${2:-${ssh_port}}

    options_make
}
function options_ssh_auth(){
    if [[ "${1}" = "--help" ]] ; then
        echo ">>> Example: ssh_to_socks ${FUNCNAME} {user} {pass}" && return 0
    fi

    echo ">>> Info: set ssh auth"
    export ssh_user=${1:${ssh_user}}
    export ssh_pass=${2:${ssh_pass}}

    options_make
}
function daemon(){
    # listen
    {
        touch $(get_daemon_file)
        while [[ -f $(get_daemon_file) ]]; do
            [[ "$(is_started)" == "no" ]] && start
            sleep 60
        done
    } &
}
function start(){
    # is started
    if [[ "$(is_started)" == "yes" ]];then
        echo ">>> Error: service has been started." && return 1
    fi

    # ssh to socks
    sshpass -p ${ssh_pass} $(get_ssh_command) &
}
function stop(){
    # kill service
    pkill -f "$(get_ssh_command)"
    rm -rf "$(get_daemon_file)"
}
function install(){
    rm -rf /usr/local/bin/ssh_to_socks
    cp ${script_path} /usr/local/bin/ssh_to_socks
    chmod 755 /usr/local/bin/ssh_to_socks
    apt-get install sshpass
}
function help(){
    echo ">>> Example: ssh_to_socks options_socks_bind {address} {port}"
    echo ">>> Example: ssh_to_socks options_ssh_server {host} {port}"
    echo ">>> Example: ssh_to_socks options_ssh_auth {user} {pass}"
}

### run command
if [[ "$(type -t ${alias})" = "function" ]] ; then
    command=${alias} && alias=default
    options_source
    ${command} ${@:2}
elif [[ "$(type -t ${command})" = "function" ]] ; then
    options_source
    ${command} ${@:3}
else
    echo ">>>>> Error: the var <command> does not exist"
fi
