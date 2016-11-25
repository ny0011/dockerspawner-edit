#!/bin/sh
set -e

ret=false
getent passwd $USER >/dev/null 2>&1 && ret=true
if $ret; then
echo "User exists - skipping useradd."
else
echo "Creating user $USER ($USER_ID)"
useradd -u $USER_ID -s $SHELL $USER
fi
sudo -E PATH="${CONDA_DIR}/bin:$PATH" -u $USER jupyterhub-singleuser
--port=8888
--ip=0.0.0.0
--user=$JPY_USER
--cookie-name=$JPY_COOKIE_NAME
--base-url=$JPY_BASE_URL
--hub-prefix=$JPY_HUB_PREFIX
--hub-api-url=$JPY_HUB_API_URL
$@
