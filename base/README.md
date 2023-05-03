# 🌟 RoCMyDocker Base Image

A basic Ubuntu 22.04 image with RoCM support, serving as the foundation for all *RoCMyDocker* images.

## 🏃 How to Run

To run the Docker container, use the following command:

```sh
docker run -it --rm --ipc=host --shm-size 8G \
                    --device=/dev/kfd --device=/dev/dri --group-add=video \
                    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
                    zi0p4tch088/rocmydocker-base:5.4.2
```

Once inside the container, you can run `rocminfo` to check whether the GPU is visible or not.

## 🌐 Environment Variables

The `UID` and `GID` environment variables control the user ID and group ID for the "user" in the container. By default, they are set as follows:

```dockerfile
ENV UID=1000
ENV GID=1000
```

Make sure to update these values to match your host user and group IDs to avoid any permission issues. 

Root privileges are dropped when the entrypoint script is executed.

## 📁 Volume Mounting Example

To run the container with a specific user ID and group ID (e.g., 1001:1001) and mount a volume, use the following command:

```sh
docker run -it --rm --ipc=host --shm-size 8G \
                    --device=/dev/kfd --device=/dev/dri --group-add=video \
                    --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
                    -e UID=1001 -e GID=1001 \
                    -v "$HOME/workdir:/workdir" \
                    zi0p4tch088/rocmydocker-base:5.4.2
```

💡 Note: Ensure that the `workdir` folder has the ownership 1001:1001 on your host system to avoid any permission issues.

## 🌡️ Monitor Temperatures and VRAM

To monitor the temperature and VRAM usage of your AMD Radeon GPU, open another terminal and execute the following command:

```sh
docker exec -it CONTAINER_NAME /bin/bash -c "watch rocm-smi"
```

To obtain the `CONTAINER_NAME`, run `docker ps` and look for the name of the running container in the last column.

This will give you real-time information about your GPU's temperature and VRAM usage during the training process.
