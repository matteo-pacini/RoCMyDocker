# 🌟 RoCMyDocker Google Colab Image

Jupyter server on an Ubuntu 22.04 image with RoCM support.

## 🏃‍♂️ How to run it

- Run the docker container (see examples below)
- Copy the link containing "127.0.0.1", e.g.:
```
http://127.0.0.1:8081/?token=2ec7a1238a85736595e3aa24a7b6a46ae6765306e5d0c174
```
- Open any Google Colab environment
- Click on "Connect" -> "Connect to a local runtime"
- Copy and paste the link
- Replace `127.0.0.1` with `localhost`
- Connect

## 📚 Examples

**Basic Jupyter Server**

```
docker run -it --rm --ipc=host -p 8081:8081 --shm-size 8G \
                    --device=/dev/kfd --device=/dev/dri --group-add=video \
                    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
                    -v "$HOME/Desktop/stable_diffusion:/workdir" zi0p4tch088/rocmydocker-colab
```

**Jupyter Server + X11 Forwarding + Tensorboard Port**

```
docker run -it --rm --ipc=host -p 8081:8081 -p 6006:6006 --shm-size 8G \
                    --device=/dev/kfd --device=/dev/dri --group-add=video \
                    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
                    -e "DISPLAY=unix$DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -v "$HOME/Desktop/stable_diffusion:/workdir" zi0p4tch088/rocmydocker-colab
```

## 🌡️ Monitor Temperatures and VRAM

To monitor the temperature and VRAM usage of your AMD Radeon GPU, open another terminal and execute the following command:

```sh
docker exec -it CONTAINER_NAME /bin/bash -c "watch rocm-smi"
```

To obtain the `CONTAINER_NAME`, run `docker ps` and look for the name of the running container in the last column.

This command provides real-time information about your GPU's temperature and VRAM usage during the training process.
