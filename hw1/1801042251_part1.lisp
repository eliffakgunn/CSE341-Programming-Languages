; *********************************************
; *  341 Programming Languages                *
; *  Fall 2020                                *
; *  Author: Elif Akgun                       *
; *********************************************

;reads the file line by line
;there is a nested list in each line
;create a list then send them to flattener func
(defun read-file(filein fileout)
	(setq liste '())
	(setq counter 0)

	(let ((in (open filein :if-does-not-exist nil)))
		(when in
			(loop for line = (read-line in nil)
				while line do 

				(setq len (length line))

				(setq nested_list (create-list line 1 2 '() len))
				
				(write-file fileout "(")
				(flattener nested_list fileout)
				(write-file fileout ")~%")
			)
			(close in)		
		)
	)	
)

;creates list from string
(defun create-list (line first_ last_ liste len)
	(if (= first_ len)
		(return-from create-list liste))

	(setq chr (subseq line first_ last_)) ; current char
	(setq num "")

	(setq f2 0)
	(setq l2 0)

	(if (and (string-not-equal chr "(") (string-not-equal chr ")") (string-not-equal chr " ")) 
		(progn
			(loop while (and (string-not-equal chr "(") (string-not-equal chr ")") (string-not-equal chr " ")) do
				(setq num (add-strs (list num chr)))
				(setq first_ (+ first_ 1))
				(setq last_ (+ last_ 1))
				(setq chr (subseq line first_ last_)) 
			)		

			(setq liste (append liste (list num)))
		)
	)

	(if (string-equal chr " ")				
		(return-from create-list (create-list line (+ 1 first_) (+ 1 last_) liste len)))	

	(if (string-equal chr "(")
		(progn
			(setq yeni (create-list line (+ 1 first_) (+ 1 last_) '() len))
			(setq liste (append liste (list yeni)))
			(return-from create-list (create-list line (+ 1 f2) (+ 1 l2) liste len))))

	(if (string-equal chr ")")
		(progn
			(setf f2 first_)			
			(setf l2 last_)			
			(return-from create-list liste)))	
)

;converts nested list to a single list
(defun flattener(nested_list fileout)
	(if nested_list
		(progn
		    (typecase nested_list
		    	(string 
					(write-file fileout nested_list)
					(write-file fileout " "))

		    	(t	(flattener (car nested_list) fileout)
		    		(flattener (cdr nested_list) fileout))))))

;adds two strings
(defun add-strs (list)
	(if (listp list)
    	(let ((str ""))
    		(dolist (x list)
    			(if (stringp x)
    				(setq str (concatenate 'string str x))))
    		str
    	)
    )
)

;writes numbers to the file
(defun write-file (file item)
	(with-open-file (str file :direction :output
                     		  :if-exists :append
                     		  :if-does-not-exist :create)
  		(format str item)
  		(close str)
  	)
)

(with-open-file (stream "flattened_list.txt" :direction :output))

(read-file "nested_list.txt" "flattened_list.txt")
