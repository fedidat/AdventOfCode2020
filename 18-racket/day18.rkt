#lang racket

(module+ main
  (define input (read-input "day18.txt"))
  (printf "Part 1: ~a~nPart 2: ~a~n" (part1 input) (part2 input)))

(define (read-input filename)
    (with-input-from-file filename
      (lambda ()
        (for/list ([line (in-lines)])
          (read (open-input-string (string-append "(" line ")")))))))

(define (part1 input)
  (apply + (map (curry eval-left #f) input)))

(define (part2 input)
  (apply + (map (curry eval-left #t) input)))

(define (eval-left addp expr)
  (match expr
    [(? number? e) e]                      ;number    -> parse, return
    [(list e) e]                           ;list      -> unpack
    [(list-rest a '* b '+ c r) #:when addp ;a * b + c -> add-priority, eval + before *
     (eval-left addp (list* a '* (+ (eval-left addp b) (eval-left addp c)) r))]
    [(list-rest a '+ b r)                  ;a + b     -> add with same priority
     (eval-left addp (cons (+ (eval-left addp a) (eval-left addp b)) r))]
    [(list-rest a '* b r)                  ;a * b     -> multiply with same priority
     (eval-left addp (cons (* (eval-left addp a) (eval-left addp b)) r))]))