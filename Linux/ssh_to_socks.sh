#!/bin/bash

###############
# Name: ssh to socks
# Author: Ztj
# Email: ztj1993@gmail.com
###############

alias=${1}
data_dir=~/.ssh_to_socks
config_file=${data_dir}/${alias}.conf
ssh_host=${ssh_host:-proxyserver}
ssh_user=${ssh_user:-root}
ssh_pass=""
socks_address=${socks_address:-127.0.0.1}
socks_port=${socks_port:-1080}

type sshpass > /dev/null 2>&1
[[ $? -ne 0 ]] && echo "Please install sshpass." && exit 1

[[ -f ${config_file} ]] && echo ">>> source ${config_file}" && source ${config_file}
[[ ! -f ${config_file} ]] && write_alias=${alias} && alias=""

[[ -z ${alias} ]] && read -p ">>> Please enter the write alias: " write_alias

[[ -z ${alias} ]] && read -p ">>> Please enter the ssh host (default: ${ssh_host}): " read_ssh_host
[[ -n ${read_ssh_host} ]] && ssh_host=${read_ssh_host}

[[ -z ${alias} ]] && read -p ">>> Please enter the ssh user (default: ${ssh_user}): " read_ssh_user
[[ -n ${read_ssh_user} ]] && ssh_user=${read_ssh_user}

[[ -z ${alias} ]] && read -p ">>> Please enter the ssh password: " read_ssh_pass
[[ -n ${read_ssh_pass} ]] && ssh_pass=${read_ssh_pass}

[[ -z ${alias} ]] && read -p ">>> Please enter the socks address (default: ${socks_address}): " read_socks_address
[[ -n ${read_socks_address} ]] && socks_address=${read_socks_address}

[[ -z ${alias} ]] && read -p ">>> Please enter the socks port (default: ${socks_port}): " read_socks_port
[[ -n ${read_socks_port} ]] && socks_address=${read_socks_port}

[[ -n ${write_alias} ]] && mkdir -p ${data_dir}
[[ -n ${write_alias} ]] && echo "ssh_host=${ssh_host}" > ${config_file}
[[ -n ${write_alias} ]] && echo "ssh_user=${ssh_user}" >> ${config_file}
[[ -n ${write_alias} ]] && echo "ssh_pass=${ssh_pass}" >> ${config_file}
[[ -n ${write_alias} ]] && echo "socks_address=${socks_address}" >> ${config_file}
[[ -n ${write_alias} ]] && echo "socks_port=${socks_port}" >> ${config_file}

[[ -z ${ssh_pass} ]] && read -s -p ">>> Please enter the ssh password: " ssh_pass

command_pass="sshpass -p ${ssh_pass}"
command_ssh="ssh -o StrictHostKeyChecking=no -N"
command_server="${ssh_user}@${ssh_host}"
command_socks="-D ${socks_address}:${socks_port}"

${command_pass} ${command_ssh} ${command_server} ${command_socks}
