FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

# Install build utils
RUN apt install -y meson ninja-build make build-essential
# Install OpenCV
RUN apt install -y libopencv-dev
# Install GStreamer
RUN apt install -y libgstreamer-opencv1.0-0 libgstreamer-plugins-bad1.0-dev libgstreamer1.0-dev

# Really dirty hack
RUN apt install -y patchelf
RUN patchelf --set-soname libopencv_core.so /usr/lib/x86_64-linux-gnu/libopencv_core.so.4.5.1
RUN patchelf --set-soname libopencv_imgproc.so /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.4.5.1
