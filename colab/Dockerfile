FROM zi0p4tch088/rocmydocker-base:5.4.2

ARG ROCM_VERSION=5.4.2

ARG UID=1000
ARG GUID=1000

RUN groupadd -g "$GUID" "user" && \
    useradd -u "$UID" -g "$GUID" -G "video" -m "user" -s /bin/bash && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV PATH="/home/user/.local/bin:$PATH"

USER user

RUN pip install torch torchvision torchaudio --index-url "https://download.pytorch.org/whl/rocm${ROCM_VERSION}" && \
    pip install tensorflow-rocm && \
    pip install jupyterlab jupyter_http_over_ws && \
    jupyter serverextension enable --py jupyter_http_over_ws

RUN pip install matplotlib numpy ipywidgets

# https://github.com/jupyter/notebook/issues/6721#issuecomment-1445187389
RUN pip install --upgrade "pyzmq<25" "jupyter_client<8"

EXPOSE 8081/tcp

ENTRYPOINT ["jupyter","notebook", "--no-browser", "--NotebookApp.allow_origin='https://colab.research.google.com'","--port","8081","--NotebookApp.port_retries=0","--ip","0.0.0.0"]
