FROM zi0p4tch088/rocmydocker-base:5.4.2

VOLUME [ "/workdir" ]

ARG ROCM_VERSION=5.4.2
ARG AUTOMATIC1111_COMMIT=6fbd85dd0c0dffc06560bff91f4c4b65e441ca5f

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN sed -i "3s/^/ROCM_VERSION=${ROCM_VERSION}\n/" /entrypoint.sh
RUN sed -i "4s/^/AUTOMATIC1111_COMMIT=${AUTOMATIC1111_COMMIT}/" /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
