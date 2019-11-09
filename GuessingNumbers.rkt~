#lang racket
(*
 Guess a random number between 0 and 100
 This is an example from "The Book" (Rust lang)
 *)
(define (ask-for-number)
  (newline)
  (display "Enter a number (0-100)")
  (newline)
  (read))

(define (guessing secret)
  (let* ([guessed (ask-for-number)])
    (cond
      [(= secret guessed) (display "Nice!")]
      [(< secret guessed) (display "Too Big")
                          (guessing secret)]
      [(> secret guessed) (display "Too Small")
                          (guessing secret)])))
  
(define (start)
  (let* ([secret (random 0 101)])
    (guessing secret)))

(start)
    