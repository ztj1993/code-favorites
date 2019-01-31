#!/bin/bash

###############
# Name: check hard disk bad blocks and fix
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Return=0: success
# Return=1: failure
# Output: success message OR error message
# Use: curl -sSL https://dwz.cn/M7kt0HNl > /tmp/fix_bad_blocks && bash /tmp/fix_bad_blocks
###############

device=${device:-0}
is_check=${is_check:-0}
is_force_fix=${is_force_fix:-0}
is_only_test=${is_only_test:-0}
log_bad_blocks_list=bad_blocks_list.log
log_bad_blocks=bad_blocks.log
previous=0
left=0
right=0
count=0

[ ${device} == 0 ] && read -p ">>> please enter device: " device
[ ${is_check} == 0 ] && read -p ">>> is check device ${device} [y/n]: " is_check
[ ${is_force_fix} == 0 ] && read -p ">>> is force fix device ${device} [y/n]: " is_force_fix
[ ${is_only_test} == 0 ] && read -p ">>> is it just testing device ${device} [y/n]: " is_only_test

function check(){
    echo ">>> Info: start check ${device} device"
    if [ $(grep -qs ${device} /proc/mounts) ];then
        umount ${device}?
        [ $? -ne 0 ] && echo ">>> Error: unmount device ${device} fail" && exit 1
        sleep 1
    fi
    badblocks -s -v -o ${log_bad_blocks_list} ${device}
    sleep 1
    echo ">>> Info: bad block $(wc -l ${log_bad_blocks_list})"
}

function fix(){
    if [ ${is_only_test} == "y" ]; then
        echo ">>> Warning: need fix ${1} - ${2}"
        count=$((${count} + 1))
        return 0
    fi
    echo ">>> Info: Being fix ${1} - ${2}"
    if [ $(grep -qs ${device} /proc/mounts) ];then
        umount ${device}?
        [ $? -ne 0 ] && echo ">>> Error: unmount device ${device} fail" && exit 1
        sleep 1
    fi
    if [ ${is_force_fix} == "y" ];then
        badblocks -w -f -s ${device} ${2} ${1}
    else
        badblocks -w -s ${device} ${2} ${1}
    fi
    [ $? -ne 0 ] && echo ">>> Error: write fail, please use force" && exit 1
    sleep 1
    count=$((${count} + 1))
}

[ ! -b ${device} ] && echo "device ${device} does not exist" && exit 1
log_bad_blocks_list="bad_blocks_list.$(basename ${device}).log"

is_check=${is_check:-0}
is_force_fix=${is_force_fix:-0}
is_only_test=${is_only_test:-0}

if [ ${is_check} == "y" ];then
    check
else
    touch ${log_bad_blocks_list}
fi

while read line
do
    [ ${previous} == 0 ] && previous=$((${line} - 1))
    [ ${left} == 0 ] && left=${line}

    if [ $((${line} - 1)) == ${previous} ];then
        previous=${line}
        continue
    fi

    right=${previous}

    fix ${left} ${previous}

    previous=${line}
    left=${line}
done < ${log_bad_blocks_list}

[ ${left} != 0 ] && fix ${left} ${previous}

if [ ${is_only_test} == "y" ]; then
    echo ">>> Warning: need fix ${count} section"
else
    echo ">>> Success: fix ${count} section"
fi
