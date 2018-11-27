#!/bin/bash/
xterm -e roslaunch youbot_driver_ros_interface youbot_driver.launch &

sleep 2

# display that it reached initial position
echo Initialing to Start Position
xterm -e rosrun youbot_ros_hello_world youbot_ros_hello_world 

sleep 1

xterm -e roslaunch torque_example torque_example.launch &

sleep 1
xterm -e rosservice call /turn_gravity_compensation_on 


# record the trajectory with the name, ask the name for the task

echo Enter the task name

read task

rosbag record /arm_1/arm_controller/position_command -O ~/bagfile/$task /topic __name:=learning_drag &

echo Learning new trajectory 

echo Enter n to stop 

read stop

if [ "$stop" = "n" ]; then
	echo "Killing terminal"
	rosnode kill /learning_drag
fi


# ask if the motion should be repeated?
rosservice call /turn_gravity_compensation_off

rosnode kill /torque_control /trajectory_generator /ik_solver_service


# display the name of the file
rosbag play ~/bagfile/$task.bag

echo Thank you sir!