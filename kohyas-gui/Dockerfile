FROM zi0p4tch088/rocmydocker-base:5.4.2

VOLUME [ "/workdir" ]

ARG ROCM_VERSION=5.4.2
ARG KOHYASGUI_TAG=v21.5.7

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  python3-tk && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN sed -i "3s/^/ROCM_VERSION=${ROCM_VERSION}\n/" /entrypoint.sh
RUN sed -i "4s/^/KOHYASGUI_TAG=${KOHYASGUI_TAG}/" /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]