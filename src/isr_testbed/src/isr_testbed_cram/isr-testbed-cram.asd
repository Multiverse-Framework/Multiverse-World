(defsystem isr-testbed-cram
  :depends-on (roslisp
               std_srvs-srv
               turtlesim-msg
               turtlesim-srv
               geometry_msgs-msg
               cl-transforms
               cram-language
               cram-designators
               cram-prolog
               cram-process-modules
               cram-language-designator-support
               cram-executive)
  :components
  ((:module "src"
            :components
            ((:file "package")
            (:file "isr-testbed-test" :depends-on ("package"))))))
