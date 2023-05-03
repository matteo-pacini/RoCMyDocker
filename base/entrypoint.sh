#!/bin/bash

groupadd -g "$GUID" "user"

useradd -u "$UID" -g "$GUID" -G "video" -m "user" -s /bin/bash

echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

exec sudo -u "user" /bin/bash
