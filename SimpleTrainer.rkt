#lang racket

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
(define (add-words)
  (display "Adding....")
  (newline)
  (display "Enter your word to memorize: ")
  (define word (to-string (read)))
  (set! words (append words (list word)))
  (display "Added word: ")
  (display (cover-word word))
  (newline))

(define (ask-and-verify-input word)
  (display (cover-word word))
  (display ": ")
  (define input (read))
  (newline)
  (cond [(string=? (to-string input) word) (display "Yes!\n")]
        [(and (number? input) (= input 0)) (display "Abort\n")]
        [else (begin
                (display "try again (0 - to get out)\n")
                (ask-and-verify-input word))]))

(define (ask-random-word)
  (define word (first (shuffle words)))
  (ask-and-verify-input word)
  (display "Continue? (y/n) \n")
  (define input (to-string (read)))
  (if (not (string=? input "n"))
      (ask-random-word)
      (display "Abort\n")))

(define (practice)
  (display "Practicing...")
  (newline)
  (if (> (length words) 0)
      (ask-random-word)
      (display "No words given.. add some words\n")))

(define (ask-options)
  (begin
    (display "0 - Exit\n")
    (display "1 - Add\n")
    (display "2 - Practice\n")
    (read)))

; Entry point 
(define (start)
  (define state (ask-options))
  (begin
    (cond [(= state 1) (add-words)]
          [(= state 2) (practice)])
    (if (> state 0) (start) (display "Bye..."))))

(start)