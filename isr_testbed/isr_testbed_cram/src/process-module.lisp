(in-package :isr)

(defmacro with-hsr-process-modules (&body body)
  "Receives a body of lisp code `body'. Runs the code contained in `body' with all the necessary process modules"
  `(cram-process-modules:with-process-modules-running
       (hsr-navigation
        common-desig:wait-pm
        ;joints:joint-state-pm
        )
     (cpl-impl::named-top-level (:name :top-level),@body)))



;;Process module itself
(cram-process-modules:def-process-module hsr-navigation (motion-designator)
  "Receives motion-designator `motion-designator'. Calls the process module HSR-NAVIGATION with the appropriate designator."
  (destructuring-bind (command argument &rest args)
      (desig:reference motion-designator)
    (declare (ignore args))
    (ecase command
      (cram-common-designators:move-base
       (call-nav-action-ps argument)))));;change package in the future



;;Denotes the PM as avaivailable
(cram-prolog:def-fact-group available-hsr-process-modules (cpm:available-process-module
                                                           cpm:matching-process-module)

(cram-prolog:<- (cpm:available-process-module hsr-navigation))
  
(cram-prolog:<- (cpm:matching-process-module ?desig  hsr-navigation)
    (desig:desig-prop ?desig (:type :going))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun call-nav-action-ps (pose-stamped)
  "Receives stamped pose `pose-stamped'. Calls the navigation client and passes the given pose-stamped to it."  
  (setf pose-stamped (cl-tf:copy-pose-stamped pose-stamped :origin
                                              (cl-tf:copy-3d-vector
                                               (cl-tf:origin pose-stamped)
                                               :z 0.0)))
  (unless (eq roslisp::*node-status* :running)
    (roslisp:start-ros-node "nav-action-lisp-client"))
  (multiple-value-bind (result status)
      (let ((actionlib:*action-server-timeout* 20.0)
            (the-goal (cl-tf:to-msg
                       pose-stamped)))
        ;;publish the pose the robot will navigate to
        (publish-marker-pose pose-stamped :g 1.0)
        (actionlib:call-goal
         (get-nav-action-client)
         (make-nav-action-goal the-goal)))
    (roslisp:ros-info (nav-action-client)
                      "Navigation action finished.")
    ;; (case status
    ;;   (:succeeded (call-text-to-speech-action "Goal reached successfully!"))
    ;;   (otherwise (call-text-to-speech-action "Something went wrong!")))
    (format t "result : ~a" status)
    (values result status)))
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun publish-marker-pose (pose &key (parent "map") id (g 0.0))
  "Receives pose `pose'. Places a visualization marker at `pose'."
  (let ((point (cl-transforms:origin pose))
        (rot (cl-transforms:orientation pose))
        (current-index 0))
    (roslisp:publish (get-marker-publisher)
                     (roslisp:make-message "visualization_msgs/Marker"
                                           (std_msgs-msg:stamp header) 
                                           (roslisp:ros-time)
                                           (std_msgs-msg:frame_id header)
                                           (typecase pose
                                             (cl-tf:pose-stamped (cl-tf:frame-id pose))
                                             (t parent))
                                           ns "goal_locations"
                                           id (or id (incf current-index))
                                           type (roslisp:symbol-code
                                                 'visualization_msgs-msg:<marker> :arrow)
                                           action (roslisp:symbol-code
                                                   'visualization_msgs-msg:<marker> :add)
                                           (x position pose) (cl-transforms:x point)
                                           (y position pose) (cl-transforms:y point)
                                           (z position pose) (cl-transforms:z point)
                                           (x orientation pose) (cl-transforms:x rot)
                                           (y orientation pose) (cl-transforms:y rot)
                                           (z orientation pose) (cl-transforms:z rot)
                                           (w orientation pose) (cl-transforms:w rot)
                                           (x scale) 0.09
                                           (y scale) 0.09
                                           (z scale) 0.09
                                           (r color) 1.0
                                           (g color) g
                                           (b color) 0.0
                                           (a color) 1.0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defparameter *marker-publisher* nil)

(defun init-marker-publisher()
  "Initializes marker-publisher."
  (setf *marker-publisher*
        (roslisp:advertise "~location_marker" "visualization_msgs/Marker")))

(defun get-marker-publisher ()
  "Returns the current marker-publisher. If none exists, one is created."
  (unless *marker-publisher*
    (init-marker-publisher))
  *marker-publisher*)                                           
                                           
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar *nav-client* nil)

(defun init-nav-client ()
  "Initialize the navigation client"
  (unless (eq roslisp::*node-status* :running)
    (roslisp:start-ros-node "nav-action-client"))
  (setf *nav-client* (actionlib:make-action-client
                      "/move_base/move"
                      "move_base_msgs/MoveBaseAction"))                      
  (roslisp:ros-info (nav-action-client)
                    "Waiting for Navigation Action server...")
  (loop until
        (actionlib:wait-for-server *nav-client*))
  (roslisp:ros-info (nav-action-client)
                    "Navigation action client created."))

(roslisp-utilities:register-ros-init-function init-nav-client)

(defun get-nav-action-client ()
  "Returns the navigation action client. If none exists yet, one will be created"
  (when (null *nav-client*)
    (init-nav-client))
  *nav-client*)
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-nav-action-goal (pose-stamped-goal)
  "Receives stamped pose `pose-stamped-goal'. Creates a navigation action goal"
  ;; make sure a node is already up and running, if not, one is initialized here.
  (roslisp:ros-info (navigation-action-client)
                    "Make navigation action goal")
  (unless (eq roslisp::*node-status* :running)
    (roslisp:start-ros-node "navigation-action-lisp-client"))
  (actionlib:make-action-goal (get-nav-action-client)
    target_pose pose-stamped-goal))

