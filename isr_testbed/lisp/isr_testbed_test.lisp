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


(defun nav-zero-pos ()
  "Starting pose in IAI office lab"
  (let ((vector (cl-tf2::make-3d-vector 0 0 0))
        (rotation (cl-tf2::make-quaternion 0 0 0 1)))
    (move-hsr (cl-tf2::make-pose-stamped "map" 0 vector rotation))))

(defun get-shelf-pos ()
  (cl-tf2::make-pose-stamped
   "map" 0
   (cl-tf2::make-3d-vector 0.01 0.95 0)
   (cl-tf2::make-quaternion 0 0 1 1)))

(defun get-table-pos ()
  (cl-tf2::make-pose-stamped
   "map" 0
   (cl-tf2::make-3d-vector 0.7 -0.95 0)
   (cl-tf2::make-quaternion 0 0 0 1)))

(defun get-target-pos (obj-name)
  (cond
      ((search "Cereal" obj-name)  (cl-tf2::make-pose-stamped
                                    "map" 0
                                    (cl-tf2::make-3d-vector 2.0 -0.25 0.7)
                                    (cl-tf2::make-quaternion 0 0 0 1)))

      ((search "Milk" obj-name)  (cl-tf2::make-pose-stamped
                                    "map" 0
                                    (cl-tf2::make-3d-vector 2.0  -0.1 0.7)
                                    (cl-tf2::make-quaternion 0 0 0 1)))

      ((or (search "Spoon" obj-name)
           (search "Fork" obj-name))
      (cl-tf2::make-pose-stamped
        "map" 0
        (cl-tf2::make-3d-vector 2.05 0.3 0.75)
        (cl-tf2::make-quaternion 0 0 0 1)))

      ((search "Bowl" obj-name)  (cl-tf2::make-pose-stamped
                                    "map" 0
                                    (cl-tf2::make-3d-vector 2.0 0.15 0.775)
                                    (cl-tf2::make-quaternion 0 0 0 1)))))

(defun get-object-pos (obj-name)
  (cond
      ((search "Cereal" obj-name)  (cl-tf2::make-pose-stamped
                                    "map" 0
                                    (cl-tf2::make-3d-vector 2.0 -0.25 0.81)
                                    (cl-tf2::make-quaternion 0 0 0 1)))

      ((search "Milk" obj-name)  (cl-tf2::make-pose-stamped
                                    "map" 0
                                    (cl-tf2::make-3d-vector 2.0 -0.1 0.8)
                                    (cl-tf2::make-quaternion 0 0 0 1)))

      ((or (search "Spoon" obj-name)
           (search "Fork" obj-name))
       (cl-tf2::make-pose-stamped
        "map" 0
        (cl-tf2::make-3d-vector 2.05 0.3 0.7)
        (cl-tf2::make-quaternion 0 0 0 1)))

      ((search "Bowl" obj-name)  (cl-tf2::make-pose-stamped
                                    "map" 0
                                    (cl-tf2::make-3d-vector 2.0 0.15 0.75)
                                    (cl-tf2::make-quaternion 0 0 0 1)))))


(defun get-target-size (obj-name)
  (cond
      ((search "Cereal" obj-name) (cl-tf2::make-3d-vector 0.14 0.06 0.225))
      ((search "Milk" obj-name) (cl-tf2::make-3d-vector 0.09 0.06 0.2))
      ((or (search "Spoon" obj-name)
           (search "Fork" obj-name))
       (cl-tf2::make-3d-vector 0.19 0.02 0.01))
      ((search "Bowl" obj-name) (cl-tf2::make-3d-vector 0.16 0.16 0.05))))
      
       
(defun get-frontal-placing (obj-name)
  (cond
      ((search "Cereal" obj-name) nil)
      ((search "Milk" obj-name) nil)
      ((or (search "Spoon" obj-name)
           (search "Fork" obj-name))
       T)
      ((search "Bowl" obj-name) T)))

(defun get-neatly-placing (obj-name)
  (cond
      ((search "Cereal" obj-name) T)
      ((search "Milk" obj-name) T)
      ((or (search "Spoon" obj-name)
           (search "Fork" obj-name))
       nil)
      ((search "Bowl" obj-name) nil)))




    
  
(defun pouring-test ()
  (let* ((?source-object-desig
           (desig:an object
                     (type bowl)))
         (?object-desig
           (exe:perform (desig:an action
                                  (type detecting)
                                  (object ?source-object-desig))))
         (?object-size1 (cl-tf2::make-3d-vector 0.16 0.16 0.05))
         (?object-size2 (cl-tf2::make-3d-vector 0.06 0.12 0.22))
         (?new-origin (cl-transforms:make-3d-vector
                       (/ (+ (cl-transforms:x ?object-size1)
                             (cl-transforms:x ?object-size2))
                          -2)
                       0
                       (/ (+ (cl-transforms:z ?object-size1)
                             (cl-transforms:z ?object-size2))
                          2)))
         (?object-transform (man-int::get-object-transform ?object-desig))
         (?temp-transform (cl-tf2::make-pose-stamped
                           "base_footprint" 0
                           ?new-origin
                           (cl-tf2::make-quaternion 0 0 0 1)))
         (?reach-transform (cram-tf:apply-transform
                            (cl-tf:lookup-transform cram-tf:*transformer* "map" "base_footprint")
                            (cram-tf:apply-transform ?object-transform
                                                    (cram-tf:pose-stamped->transform-stamped
                                                     ?temp-transform
                                                     "base_footprint"))))
         (?reach-pose (cram-tf:transform->pose-stamped
                       "map" 0
                       ?reach-transform)))
    ?reach-pose))



;; Idea:
;; Change Reaching to approaching to generalize that kind of motion.
;; Planning also give the "context" to manipulation, so manipulation can differentiate
;; between for example, picking up and pouring

(defun wait-for-human-signal ()
  (cpl:seq
    (exe:perform (desig:a motion
                          (type gripper-motion)
                          (:open-close :open)
                          (effort 0.1)))
    (wait-robot)
    (call-text-to-speech-action "Please give me the object")
    (exe:perform
             (desig:an action
                       (type monitoring-joint-state)
                       (joint-name "wrist_flex_joint")))
    (call-text-to-speech-action "Thank you")
    (exe:perform (desig:a motion
                          (type gripper-motion)
                          (:open-close :close)
                          (effort 0.1)))))

(defun luca-test ()
  (let ((str (string-downcase (symbol-name :test-test-test-tes-tes-tes-tes-te-s-tes))))
    (loop while (search "-" str)
          do
             (setf str (replace str "_" :start1 (search "-" str))))
    str))

  ;; (cram-occasions-events:on-event
  ;;                (make-instance 'cram-plan-occasions-events:object-detached-robot-knowrob
  ;;                  :name name
  ;;                  :pose pose)))


