## Problem

1. Playback produces undefined jerks.

A. Finding the topic needed to be published for playback.
SUspects: JointStates

Either record positions
or
find a way to always start from the same initial state


On topic `/arm_1/arm_controller/position_command`, 
no data is published when `gravity_compensation` is on.

On topic `/arm_1/arm_controller/torques_command`, 
data is published when `gravity_compensation` is on.


### TO reproduce the learning

1. Start the youbot_driver_ros_interface by ETH Zurich

```sh
roslaunch youbot_driver_ros_interface youbot_driver.launch
```

2. Start the `torque_controller

```sh
roslaunch torque_example torque_example.launch
```

3. To achieve consistent initial state. run the circle_trajectory node.

```sh
rosrun torque_example circle_traj
```

4. Turn `gravity_compensation` service on

```sh
rosservice call /turn_gravity_compensation_on
```

5. Move as per the new required trajectory and record the topic to be saved in the bagfile.

```sh
rosbag record /arm_1/arm_controller/position_command
```

6. Playback the trajactories using the rosbag file

```sh
rosbag play name_of_bag_file.bag
``` 

For best results:

1. Record all topics.
2. Turn `gravity_compensation` **off** for playback.







## New best appraoches 

1. Start the youbot_driver_ros_interface by ETH Zurich

```sh
roslaunch youbot_driver_ros_interface youbot_driver.launch
```

2. Start the ros_hello_world node to move the youBot from the 0 value  


```sh
rosrun youbot_ros_hello_world youbot_ros_hello_world
```

3. Start the `torque_controller

```sh
roslaunch torque_example torque_example.launch
```

### For learning new trajectory

1. Turn gravity compensation on for recording.

```sh
rosservice call /turn_gravity_compensation_on
```

2. Move as per the new required trajectory and record the topic to be saved in the bagfile.

```sh
rosbag record /arm_1/arm_controller/position_command
```
3. Move the arm according to the required task.


### For replaying the task

1. Turn gravity compensation off for recording.

```sh
rosservice call /turn_gravity_compensation_off
```

2. Close the `torque_example` node

3. Playback the trajactories using the rosbag file

```sh
rosbag play name_of_bag_file.bag
``` 


# For running The ETH Zurich Code

1. Removed the standard youbot driver ROS interface.
2. Built and Installed youbot_ros_interface by ETC Zurich in catkin_ws.
	
	Commands to run:
```sh
		export YOUBOT_CONFIG_FOLDER_LOCATION=/opt/ros/indigo/share/youbot_driver/config
		sudo setcap cap_net_raw+ep devel/lib/youbot_driver_ros_interface/youbot_driver_ros_interface
		sudo ldconfig devel/lib			# under the root of the catkin_ws
```
