# 🌟 RoCMyDocker Automatic1111 WebUI Image

Automatic1111 WebUI on an Ubuntu 22.04 image with RoCM support.

## 🏃 How to Run

To run the Docker container, use the following command:

```sh
docker run -it --rm --ipc=host -p 7860:7860 --shm-size 8G \
                    --device=/dev/kfd --device=/dev/dri --group-add=video \
                    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
                    -v "$HOME/workdir:/workdir" zi0p4tch088/rocmydocker-automatic1111:6fbd85 [EXTRA_ARGS]
```

The entrypoint script downloads Automatic1111's code into the `/workdir` volume. 

Ensure the volume is mounted with the appropriate ownership (see the `Environment Variables` section for more info).

The WebUI will be reachable at `http://localhost:7860/` once the container is up and running.

## Extra Arguments

RDNA2+ cards do not need extra arguments.

For older cards, you may want to add `--precision full --no-half` to the Docker run command.

See this [article](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Install-and-Run-on-AMD-GPUs/c32f1fa54a63d44cacb4d58d26fa2dc43ea83fd2) for more information.

## Recommended Settings

- Training:
    - [X] Move VAE and CLIP to RAM when training if possible. Saves VRAM.
    - [X] Use cross attention optimizations while training.

## 🌐 Environment Variables

The `UID` and `GID` environment variables control the user ID and group ID for the "user" in the container. By default, they are set as follows:

```dockerfile
ENV UID=1000
ENV GID=1000
```

Update these values to match your host user and group IDs to prevent any permission issues. 

The entrypoint script drops root privileges when executed.

## 🌡️ Monitor Temperatures and VRAM

To monitor the temperature and VRAM usage of your AMD Radeon GPU, open another terminal and execute the following command:

```sh
docker exec -it CONTAINER_NAME /bin/bash -c "watch rocm-smi"
```

To obtain the `CONTAINER_NAME`, run `docker ps` and look for the name of the running container in the last column.

This command provides real-time information about your GPU's temperature and VRAM usage during the training process.

## Known Issues

- First generation / first save will take a bit of time (seems to be RoCM-related)