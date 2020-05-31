#lang racket
(provide start)

; convert user input to a string
(define (to-string input)
  (cond
    [(symbol? input) (symbol->string input)]
    [(number? input) (number->string input)]))

; cover up a word, for example: Hello -> H***o
(define (cover-word word)
  (let* ([shortened-size (- (string-length word) 2)]
        [sec-last-pos (if (> shortened-size 0) shortened-size 0)]
        [last-pos (+ sec-last-pos 1)])
    (string-append (substring word 0 1)
                   (make-string sec-last-pos #\*)
                   (substring word last-pos (string-length word)))))

; global list of all words that were given by the user
(define words '())

; workflow for adding new words to the list
(define (add-words output input)
  (output "Adding....")
  (newline)
  (output "Enter your word to memorize:")
  (define word (to-string (input)))
  (when (> (string-length word) 0)
      (set! words (append words (list word)))
      (output "Added word: ")
      (output (cover-word word))
      (newline)))

(define (ask-and-verify-input word output input)
  (output (cover-word word))
  (output ": ")
  (define user-input (input))
  (newline)
  (cond [(string=? (to-string user-input) word) (output "Yes!\n")]
        [(and (number? user-input) (= user-input 0)) (output "Abort\n")]
        [else (begin
                (output "try again (0 - to get out)\n")
                (ask-and-verify-input word output input))]))

(define (ask-random-word output input)
  (define word (first (shuffle words)))
  (ask-and-verify-input word output input)
  (output "Continue? (y/n) \n")
  (define user-input (to-string (input)))
  (if (not (string=? user-input "n"))
      (ask-random-word output input)
      (output "Abort\n")))

(define (practice output input)
  (output "Practicing...")
  (newline)
  (if (> (length words) 0)
      (ask-random-word output input)
      (output "No words given.. add some words\n")))

(define (ask-options output input)
  (begin
    (output "0 - Exit\n")
    (output "1 - Add\n")
    (output "2 - Practice\n")
    (input)))

; Entry point 
(define (start output input)
  (define state (ask-options output input))
  (begin
    (cond [(= state 1) (add-words output input)]
          [(= state 2) (practice output input)])
    (if (> state 0) (start output input) (output "Bye..."))))

