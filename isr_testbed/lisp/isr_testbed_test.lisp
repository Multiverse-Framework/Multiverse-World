(in-package :su-demos)


(defparameter *objects* '(:CerealBox :milk :spoon :bowl))

(defun isr-demo()

  ; Go to human an receive task
  (move-hsr (cl-tf::make-pose-stamped "map" 0
                                      (cl-tf::make-3d-vector -1.1 2.65 0)
                                      (cl-tf:make-quaternion 0 0 1 0)))

  ; Move to destination
  (move-hsr (cl-tf::make-pose-stamped "map" 0
                                      (cl-tf::make-3d-vector -2.0 -2.5 0)
                                      (cl-tf:make-quaternion 0 0 1 0)))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;TODO: Grasp object ;;;;;;;;;  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  
  ; Bring object to destination
  (move-hsr (cl-tf::make-pose-stamped "map" 0
                                      (cl-tf::make-3d-vector 0.6 0 0)
                                      (cl-tf:make-quaternion 0 0 0 1)))


  )


   
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; Hardcoded stuff for debugging ;;;;;;;;;;;;


(defun park-robot ()
  "Default pose"
  (exe:perform (desig:an action
                         (type taking-pose)
                         (pose-keyword "park"))))

(defun perc-robot ()
  "Default pose"
  (exe:perform (desig:an action
                         (type taking-pose)
                         (pose-keyword "perceive"))))

(defun wait-robot ()
  "Default pose"
  (exe:perform (desig:an action
                         (type taking-pose)
                         (pose-keyword "assistance"))))

