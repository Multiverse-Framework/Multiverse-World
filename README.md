# Multiverse-World


## isr_testbed:
### Installation:

#### Gazebo objects

Download cob gazebo objects: 
Sudo apt install ros-noetic-cob-gazebo-objects 

#### Repository

Clone the main branch of this git repository

#### Catkin
go into the folder 'Multiverse-World' and use 'catkin_make'

Source devel/setup.bash



### Launch:

With sourced workspace: 'roslaunch isr\_testbed isr\_testbed.launch'

On Gazebo: Press play

upload other hsrb_description

open roslisp_repl

load package (ros-load:load-system "isr\_testbed\_cram" :isr-testbed-cram)

(in-package :isr-testbed)





