# Use an official ROS2 base image
FROM ros:humble

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    build-essential \
    cmake \
    libeigen3-dev \
    libopencv-dev \
    curl \
    python3-colcon-common-extensions \
    libfastrtps-dev \
    libtinyxml2-dev \
    ros-humble-ros-base \
    ros-humble-rclcpp \
    && rm -rf /var/lib/apt/lists/*

# Create a workspace for ROS2 and PX4 ROS2 bridge
WORKDIR /root/ros2_ws/src

# Clone the PX4 ROS2 bridge
RUN git clone https://github.com/PX4/px4_ros_com.git \
    && git clone https://github.com/PX4/px4_msgs.git

# Build the workspace
WORKDIR /root/ros2_ws
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

# Source the ROS2 environment
RUN echo "source /root/ros2_ws/install/setup.bash" >> /root/.bashrc

# Set up environment variables for PX4-ROS2 bridge
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/root/ros2_ws/src/px4_ros_com/templates/fastrtps_profiles/px4-dev-profiles.xml
ENV ROS_DOMAIN_ID=1

# Expose necessary ports for Fast RTPS communication
EXPOSE 8800

# Run the ROS2 environment when the container starts
CMD ["/bin/bash", "-c", "source /root/ros2_ws/install/setup.bash && bash"]
