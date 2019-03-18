#!/bin/bash

root_dir=$(cd $(dirname $(readlink -f "${BASH_SOURCE[0]}")) && pwd )

source ${root_dir}/venv/bin/activate
celery -A test1 worker -Q celery,queue1,queue2 -l info
