#!/bin/bash



groupadd -g "$GUID" "user"

useradd -u "$UID" -g "$GUID" -G "video" -m "user" -s /bin/bash

echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

exec sudo -u "user" env KOHYASGUI_TAG="$KOHYASGUI_TAG" ROCM_VERSION="$ROCM_VERSION" EXTRA_ARGS="$*" /bin/bash -c '

cd /workdir || exit 1

if [ ! -d "kohya_ss" ]; then
    git clone https://github.com/bmaltais/kohya_ss
    cd kohya_ss || exit 1
    git checkout "$KOHYASGUI_TAG"
    python3 -m venv venv
    source venv/bin/activate
    pip install --upgrade pip wheel
    pip install torch torchvision --index-url https://download.pytorch.org/whl/rocm$ROCM_VERSION
    pip install -r requirements.txt
    pip uninstall -y tensorflow
    pip install tensorflow-rocm lion_pytorch
    deactivate
    cd /workdir || exit 1
fi

cd kohya_ss || exit 1
source venv/bin/activate
python3 kohya_gui.py --listen 0.0.0.0 --server_port 7860 --inbrowser

'
