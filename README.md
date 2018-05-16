# build-boinc-client-docker
This container will allow you to build a BOINC Client .deb file without installing any build dependencies on your system.

### Usage
```
./build.sh
sudo dpkg -i boinc-client*.deb
```
The build script spins up a container, executes the `Dockerfile` which performs the actual build from source. The script then copies the built `.deb` artifact out onto your local system ready for installation using `dpkg`.
Then the script cleans up itself, it deletes the Docker container and the image.
