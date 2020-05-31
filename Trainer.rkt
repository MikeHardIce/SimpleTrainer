#lang racket

(require (prefix-in simple: "SimpleTrainer.rkt") (prefix-in guess: "GuessingNumbers.rkt"))


(define (output text)
  (display (string-append text "\n")))

(define (input)
  (read))


(define (main)
  (output "1 - Simple Trainer\n")
  (output "2 - Guessing Numbers\n")
  (let ([option (input)])
    (cond [(= option 1) (simple:start output input)]
          [(= option 2) (guess:start output input)]
          [else (output "Bye")])))

(main)