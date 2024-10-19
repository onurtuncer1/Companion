# Companion
A docker container to simulate companion computer

## Build the Docker image

In the directory where you have your Dockerfile, run:

```bash
docker build -t px4-companion-computer .

## Run the Docker container
Once the image is built, you can run it:

''''bash
docker run -it --rm --name companion-computer px4-companion-computer

You may want to connect the container to a simulated PX4 instance using MAVLink. For example, if PX4 is running on your host machine, you can forward ports like this:

'''bash
docker run -it --rm --name companion-computer \
  -p 14550:14550/udp \
  px4-companion-computer
