; *********************************************
; *  341 Programming Languages                *
; *  Fall 2020                                *
; *  Author: Elif Akgun                       *
; *********************************************

;calculates collatz sequence of a number
(defun collatz(num file)

	; if <=0 olmaz
	(if (<= num 0)
		(progn
			;(print "0")
			(return-from collatz 0)
		)
	)	

	(write-file file (write-to-string num))	
	(write-file file " ")	

	(if (= 1 num)
		(progn
			;(print "1")
			(return-from collatz 1)
		)
	)

	(if (= 1 (mod num 2))
		(progn
			;(print (+ 1 (* num 3)))
			(collatz (+ 1 (* num 3)) file)
		)
	)

	(if (= 0 (mod num 2))
		(progn
			;(print (/ num 2))
			(collatz (/ num 2) file)
		)
	)	
)

;reads at most 5 integers from the input file
;sends them to collatz func to calculate collatz sequences
(defun read-file(filein fileout)
	(let ((in (open filein :if-does-not-exist nil)))
  		(when in
    		(setq line (read-line in))	
			(setq first_ 0)
			(setq last_ 1)
			(setq counter 0)
			(setq len (length line))
			(setq num "")

			(loop while (and (/= first_ len) (< counter 5)) do
				(setq chr (subseq line first_ last_)) ; current char

				(if (string-equal chr " ")
					(progn
						(setq first_ (+ first_ 1))
						(setq last_ (+ last_ 1))
						(if (/= len first_)
							(setq chr (subseq line first_ last_)))
					)
				)				

				(if (string-not-equal chr " ")
					(progn
						(loop while (and (string-not-equal chr " ") (/= first_ len)) do
							(setq num (add-strs (list num chr)))
							(setq first_ (+ first_ 1))
							(setq last_ (+ last_ 1))
							(if (/= first_ len)
								(setq chr (subseq line first_ last_))) 
						)
						;(print num)	
						(write-file fileout num)
						(write-file fileout ": ")

						(collatz (parse-integer num) fileout)

						(write-file fileout "~%")

						(setq num "")
						(setq counter (+ counter 1))						
					)
				)			
			)
		)
	)
)

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

(with-open-file (stream "collatz_outputs.txt" :direction :output))

(read-file "integer_inputs.txt" "collatz_outputs.txt")