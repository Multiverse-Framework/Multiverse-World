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

    (let ((?navigation-goal *pose-bottle-1*)
    (navigate-to (?navigation-goal))
    
    
    ))

  ;(exe:perform
   ;(desig:a motion
   ;         (type going)
   ;         (pose (cl-tf::make-pose-stamped "map" 0
   ;                                   (cl-tf::make-3d-vector -1.1 2.65 0)
   ;                                   (cl-tf:make-quaternion 0 0 1 0)))))
  
  ; Go to human an receive task
  ;(move-hsr (cl-tf::make-pose-stamped "map" 0
  ;                                    (cl-tf::make-3d-vector -1.1 2.65 0)
  ;                                    (cl-tf:make-quaternion 0 0 1 0)))

  ; Move to destination
  ;(move-hsr (cl-tf::make-pose-stamped "map" 0
  ;                                    (cl-tf::make-3d-vector -2.0 -2.5 0)
  ;                                    (cl-tf:make-quaternion 0 0 1 0)))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;TODO: Grasp object ;;;;;;;;;  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  
  ; Bring object to destination
  ;(move-hsr (cl-tf::make-pose-stamped "map" 0
  ;                                    (cl-tf::make-3d-vector 0.6 0 0)
  ;                                    (cl-tf:make-quaternion 0 0 0 1)))


  )

;(defun move-hsr (targetpose)
;  (exe:perform 
;     (desig:a motion
;              (type going)
;              (pose targetpose)))
                                        ;)

;(defun nav-zero-pos ()
;  (let ((vector (cl-tf2::make-3d-vector 0 0 0))
;        (rotation (cl-tf2::make-quaternion 0 0 0 1)))
;    (exe:perform
;    (desig:a motion
;             (type going)
;             (pose (cl-tf2::make-pose-stamped "map" 0 vector rotation))))))







