; *********************************************
; *  341 Programming Languages                *
; *  Fall 2020                                *
; *  Author: Elif Akgun                       *
; *********************************************

;checks if the number is prime
;if it is prime return 1 else erturns 0
(defun is-prime(num)
	(if (<= num 1)
		(return-from is-prime 0))

	(loop for i from 2 to (- num 1) do
		(if (= 0 (mod num i))
			(return-from is-prime 0))
	)
	1
)

;checks if the number is semiprime
;if it is semiprime returns 1 else returns 0
(defun is-semiprime(num)
	(setq counter 0)

	(if (< num 4)
		(return-from is-semiprime 0))

	(setq bound (+ 1 (floor(sqrt num))))

	(loop for i from 2 to bound do
		(loop while (= 0 (mod num i)) do
			(setq num (/ num i))
			(setq counter (+ counter 1))
		)

		(if (>= counter 2)
			(return))
	)

	(if (> num 1)
		(setq counter (+ counter 1)))

	(if (= counter 2)
		(return-from is-semiprime 1))
	0
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
(defun write-to-file (file item)
	(with-open-file (str file :direction :output
                     		  :if-exists :append
                     		  :if-does-not-exist :create)
  		(format str item)
  		(close str)
  	)
)

;reads file then gets lower and upper boundries
;finds primes and semiprimes between the two integers
(defun primecrawler(filein fileout)
	(let ((in (open filein :if-does-not-exist nil)))
  		(when in
    		(setq line (read-line in))
				
			(setq first_ 0)
			(setq last_ 1)
			(setq counter 0)

			(setq len (length line))

			(setq num1 "")
			(setq num2 "")

			(loop while (and (/= first_ len) (< counter 2)) do
				(setq chr (subseq line first_ last_)) ; current char

				(if (string-equal chr " ")
					(progn
						(setq first_ (+ first_ 1))
						(setq last_ (+ last_ 1))
						(setq chr (subseq line first_ last_)) ; current char
					)
				)

				(if (and (string-not-equal chr " ") (\= first_ 0)) 
					(progn
						(loop while (string-not-equal chr " ") do
							(setq num1 (add-strs (list num1 chr)))
							(setq first_ (+ first_ 1))
							(setq last_ (+ last_ 1))
							(setq chr (subseq line first_ last_)) ; current char
						)
						(setq lower (parse-integer num1))
					)
				)

				(if (and (string-not-equal chr " ") (/= first_ 0)) 
					(progn
						(loop while (and (/= first_ len) (string-not-equal chr " "))  do	
							(setq num2 (add-strs (list num2 chr)))

							(setq first_ (+ first_ 1))
							(setq last_ (+ last_ 1))

							(if (/= first_ len)
								(setq chr (subseq line first_ last_)) ; current char
							)
						)						
						(setq upper (parse-integer num2))
					)
				)
				(setq counter (+ counter 1))			
			)
    		(close in)
    	)
  	)	

	(with-open-file (stream fileout :direction :output))

	;(print lower)
	;(print upper)

	(loop for i from lower to upper do
		(if (= 1 (is-prime i))
			(progn
				(write-to-file fileout (write-to-string i))
				(write-to-file fileout " is Prime~%")
			)
		)
		(if (= 1 (is-semiprime i))
			(progn
				(write-to-file fileout (write-to-string i))
				(write-to-file fileout " is Semi-prime~%")		
			)
		)		
	)
)

(primecrawler "boundries.txt" "primedistribution.txt")

