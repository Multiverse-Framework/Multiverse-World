(in-package :isr-testbed-cram)

(defun start-ros()(roslisp-utilities:startup-ros))


(defun navigate-to (?navigation-goal)
  (exe:perform (desig:a motion
                        (type going)
                        (pose ?navigation-goal))))
                        
(defparameter *pose-bottle-1*
  (cl-transforms-stamped:make-pose-stamped
   "map" 0.0
   (cl-transforms:make-3d-vector -2 -0.9d0 0.86d0)
   (cl-transforms:make-identity-rotation)))

(defun isr-demo()

  
  (let ((?human-pose (cl-tf::make-pose-stamped "map" 0
                                      (cl-tf::make-3d-vector -1.1 2.65 0)
                                      (cl-tf:make-quaternion 0 0 1 0))))
    (navigate-to ?human-pose))

  
  (let ((?object-pose (cl-tf::make-pose-stamped "map" 0
                                      (cl-tf::make-3d-vector -2.0 -2.5 0)
                                      (cl-tf:make-quaternion 0 0 1 0))))
    (navigate-to ?object-pose))

  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;TODO: Grasp object ;;;;;;;;;  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  
   (let ((?destination-pose (cl-tf::make-pose-stamped "map" 0
                                      (cl-tf::make-3d-vector 0.6 0 0)
                                      (cl-tf:make-quaternion 0 0 0 1))))
    (navigate-to ?destination-pose))
  
  )









