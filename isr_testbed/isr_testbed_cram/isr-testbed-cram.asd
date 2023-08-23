(defsystem isr-testbed-cram
  :depends-on (roslisp ;cram-language turtlesim-msg turtlesim-srv cl-transforms geometry_msgs-msg)
               roslisp-utilities ; for ros-init-function

	       actionlib
               actionlib_msgs-msg

               cl-transforms
               cl-transforms-stamped
               cl-tf
	       cl-tf2
	       cl-utils
               cram-tf
               cram-math

               cram-process-modules 
               cram-language-designator-support
               cram-language
               cram-executive
               cram-designators
               cram-prolog
               cram-projection
               cram-occasions-events
               cram-utilities
               
               cram-common-designators
               
               cram-common-failures
               
               cram-hsrb-description
               
               navigation_msgs-msg
               move_base_msgs-msg
               
               )
  :components
  ((:module "src"
            :components
            ((:file "package")
            (:file "isr-testbed-test" :depends-on ("package"))
            (:file "process-module" :depends-on ("package"))
            ))))
