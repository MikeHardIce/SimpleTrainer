#lang racket
 (provide start)

 ; Guess a random number between 0 and 100
 ; This is an example from "The Book" (Rust lang)

(define (ask-for-number output input)
  (output "Enter a number (0-100)")
  (input))

(define (guessing output input secret)
  (let ([guessed (ask-for-number output input)])
    (cond
      [(= secret guessed) (output "Nice!")]
      [(< secret guessed) (output "Too Big")
                          (guessing output input secret)]
      [(> secret guessed) (output "Too Small")
                          (guessing output input secret)])))
  
(define (start output input)
  (let ([secret (random 0 101)])
    (guessing output input secret)))

    