FROM zi0p4tch088/rocmydocker-base:5.4.2

VOLUME [ "/workdir" ]

ARG ROCM_VERSION=5.4.2
ARG AUTOMATIC1111_COMMIT=5ab7f213bec2f816f9c5644becb32eb72c8ffb89

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ffmpeg && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN sed -i "3s/^/ROCM_VERSION=${ROCM_VERSION}\n/" /entrypoint.sh
RUN sed -i "4s/^/AUTOMATIC1111_COMMIT=${AUTOMATIC1111_COMMIT}/" /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
