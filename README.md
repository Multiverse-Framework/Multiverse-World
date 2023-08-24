# Multiverse-World


## isr_testbed:
### Installation:

#### Gazebo objects

- Download cob gazebo objects
  - Sudo apt install ros-noetic-cob-gazebo-objects 

#### Workspace
- Create a workspace and src directory
  - mkdir workspace_name/src
  - cd workspace_name/src

- Be sure to have the hsr descirption of code iai sourced or clone the repository into this workspace
  - git clone https://github.com/code-iai/hsr_description.git

- clone the main branch of this git repository
  - git clone https://github.com/K3cks/Multiverse-World
 
- clone cram repository and checkout devel branch
  - git clone https://github.com/cram2/cram.git && cd cram
  - git checkout devel

- go into workspace directory, build and then source workspace
  - cd ..
  - catkin build
  - source /devel/setup.bash

### Launch:

With sourced workspace: 'roslaunch isr\_testbed isr\_testbed.launch'

- On Gazebo: Press play

- upload other hsrb_description
  - roslaunch isr\_testbed upload\_hsrb.launch 

- roslisp_repl in new terminal

- Load and get in package, start ros
  - load package (ros-load:load-system "isr\_testbed\_cram" :isr-testbed-cram)
  - (in-package :isr-testbed)
  - (start-ros)

- Finally you can start the demo
  - (with-hsr-process-modules (isr-demo))





