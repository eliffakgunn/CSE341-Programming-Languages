; *********************************************
; *  341 Programming Languages                *
; *  Fall 2020                                *
; *  Author: Elif Akgun                       *
; *********************************************

(defstruct huffman
	item
	left 
	right
	freq 
	code
)

;reads the file
(defun open-files(filein fileout)
	(with-open-file (stream fileout :direction :output))

	(let ((in (open filein :if-does-not-exist nil)))
		(when in
			(setq paragraph "")

			(loop for ch = (read-char in nil)
				while ch do
				(setq paragraph (add-strs (list paragraph (string ch))))
			)
			(create-huffman-tree paragraph fileout)
			(close in)
		)
	)		
)  
 
;creates huffman tree
(defun create-huffman-tree (str fileout)
    (setq liste '())
  	(setq len (length str))
    (setq nodes (make-hash-table :size len))

    ;creates nodes and find freqs 
    (map nil #'(lambda (chr)
        (multiple-value-bind (node ret) (gethash chr nodes)
            (if ret
                (setf (huffman-freq node) (+ 1 (huffman-freq node)))

            	(progn ;else
                    (setq node (make-huffman :item chr :freq 1))
                    (setf (gethash chr nodes) node)
                    (setf liste (cons node liste))
                )                 	
            )                    
        ))
        str
    )	   

    (setq sorted_liste (sort liste '< :key 'huffman-freq)) ;sorts by freqs

	;creates tree
	(loop while (cdr sorted_liste) do
		(setq node1 (car sorted_liste))
		(setq node2 (car (cdr sorted_liste)))
		(setq sorted_liste-rest (cdr (cdr sorted_liste)))
    	(setq node3 (list (make-huffman :left node1 :right node2 :freq (+ (huffman-freq node1) (huffman-freq node2)))))
      	(setf sorted_liste (merge 'list node3 sorted_liste-rest '< :key 'huffman-freq))  
	)

  	(create-huffman-code (car sorted_liste) '() 0)	

	(setq total '())

  	;total keeps codes
  	(loop for node being each hash-value of nodes do
		(setq total (append total (list (map 'string #'digit-char (huffman-code node)))))) 

	(sort total #'< :key #'length) ;sorts by codes' length

	(loop for i from 0 to (- (length total) 1) do
		(loop for node being each hash-value of nodes do
			(if (string-equal (nth i total) (map 'string #'digit-char (huffman-code node)))
				(progn
					(write-file fileout (string (huffman-item node)))
					(write-file fileout ": ")
					(write-file fileout (map 'string #'digit-char (huffman-code node)))
					(write-file fileout "~%")
				)
			)
		)
	)
)

;find huffman codes
(defun create-huffman-code(node code len)
 	(if (and (not (huffman-left node)) (not (huffman-right node)))
 		(progn
 			(setf code (reverse code))
 			(setq arr (make-array len :element-type 'bit :initial-contents code))
			(setf (huffman-code node) arr)
		)
 		(progn ;else
 			(create-huffman-code (huffman-left node) (cons 0 code) (+ len 1))
			(create-huffman-code (huffman-right node) (cons 1 code) (+ len 1))
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

;writes to the file
(defun write-file (file item)
	(with-open-file (str file :direction :output
                     		  :if-exists :append
                     		  :if-does-not-exist :create)
  		(format str item)
  		(close str)
  	)
)

(open-files "paragraph.txt" "huffman_codes.txt")