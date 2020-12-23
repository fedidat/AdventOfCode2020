
(defun solve (filename)
	(defvar decks (read-decks filename))
	(write-line (concatenate 'string "Part 1: " (write-to-string (part1 decks))))
	(write-line (concatenate 'string "Part 2: " (write-to-string (part2 decks)))))

(defun read-decks (filename)
	(with-open-file (f filename)
		(loop for i from 0 to 1
			collect
				(loop for line = (read-line f nil) for j from 0
					while (and line (< 0 (length line)))
					if(/= j 0) collect (parse-integer line)))))

(defun part1 (decks)
	(loop with result = (combat (clone-decks decks 0 nil nil))
		for w in (reverse (if (car result) (car result) (cadr result)))
		for i from 1 sum (* w i)))

(defun part2 (decks)
	(loop with result = (combat-rec (clone-decks decks 0 nil nil))
		for w in (reverse (if (car result) (car result) (cadr result)))
		for i from 1 sum (* w i)))

(defun combat (decks)
	(loop while (and (car decks) (cadr decks))
		if (> (caar decks) (caadr decks)) ;player 1 wins
			do (setf (cdr (last (car decks))) (list (caar decks) (caadr decks)))
		else do (setf (cdr (last (cadr decks))) (list (caadr decks) (caar decks)))
		do (setf (car decks) (cdar decks) (cadr decks) (cdadr decks)))
	decks)

(defun combat-rec (decks)
	(loop with encountered = (make-hash-table :test 'equalp)
		for recurse =
			(and
				(car decks)
				(cadr decks)
				(<= (caar decks) (length (cdar decks)))
				(<= (caadr decks) (length (cdadr decks))))
		while (and (car decks) (cadr decks))
		if (gethash (game-to-string decks) encountered) ;infinite recursion defense
			do (return (setf decks (cons (car decks) nil)))
		do (setf (gethash (game-to-string decks) encountered) t)
		if (if recurse
			(car (combat-rec (clone-decks decks 1 (+ (caar decks) 1) (+ (caadr decks) 1))))
			(> (caar decks) (caadr decks))) ;regular game
			do (setf (cdr (last (car decks))) (list (caar decks) (caadr decks)))
		else do (setf (cdr (last (cadr decks))) (list (caadr decks) (caar decks)))
		do (setf (car decks) (cdar decks) (cadr decks) (cdadr decks)))
	decks)

(defun clone-decks (decks skip-first last-a last-b)
	(list
		(copy-list (subseq (car decks) skip-first last-a))
		(copy-list (subseq (cadr decks) skip-first last-b))))

(defun game-to-string (decks)
	(concatenate 'string (format nil "~{~a ~}" (car decks)) ", " (format nil "~{~a ~}" (cadr decks))))

(solve "day22.txt")