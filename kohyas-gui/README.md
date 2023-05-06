# 🌟 RoCMyDocker Kohya's GUI Image

Kohya's GUI on an Ubuntu 22.04 image with RoCM support.

## 🏃 How to Run

To run the Docker container, use the following command:

```sh
docker run -it --rm --ipc=host -p 7860:7860 --shm-size 8G \
                    --device=/dev/kfd --device=/dev/dri --group-add=video \
                    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
                    -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -v "$HOME/workdir:/workdir" zi0p4tch088/rocmydocker-kohyas-gui:21.5.7 [EXTRA_ARGS]
```

The entrypoint script downloads Kohya's GUI code into the `/workdir` volume. 

Ensure the volume has the appropriate ownership (see the `Environment Variables` section for more info).

The GUI will be reachable at `http://localhost:7860/` once the container is up and running.

## Extra Arguments

See the Python [launch script](https://github.com/bmaltais/kohya_ss/blob/master/kohya_gui.py#L145-L170) for more information.

## Settings

- Training Parameters:
    - Optimizer -> Lion.
    - Advanced Configuration -> Memory Efficient Attention **ON**
    - Advanced Configuration -> Use xformers **OFF**

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
