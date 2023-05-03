#!/bin/bash



groupadd -g "$GUID" "user"

useradd -u "$UID" -g "$GUID" -G "video" -m "user" -s /bin/bash

echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

exec sudo -u "user" env AUTOMATIC1111_COMMIT="$AUTOMATIC1111_COMMIT" ROCM_VERSION="$ROCM_VERSION" EXTRA_ARGS="$*" /bin/bash -c '

cd /workdir || exit 1

if [ ! -d "stable-diffusion-webui" ]; then
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui
    cd stable-diffusion-webui || exit 1
    git checkout "$AUTOMATIC1111_COMMIT"
    python3 -m venv venv
    source venv/bin/activate
    pip install --upgrade pip wheel
    pip install torch torchvision --index-url "https://download.pytorch.org/whl/rocm${ROCM_VERSION}"
    pip install -r requirements.txt
    deactivate
    cd /workdir || exit 1
fi

cd stable-diffusion-webui || exit 1
source venv/bin/activate
python3 launch.py --listen $EXTRA_ARGS

'