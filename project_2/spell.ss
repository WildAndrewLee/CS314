
; *********************************************
; *  314 Principles of Programming Languages  *
; *  Fall 2015                                *
; *  Student Version                          *
; *********************************************

;; contains "ctv", "A", and "reduce" definitions
(load "include.ss")

;; contains simple dictionary definition
(load "test-dictionary.ss")

;; -----------------------------------------------------
;; HELPER FUNCTIONS

;; *** CODE FOR ANY HELPER FUNCTION GOES HERE ***

;; -----------------------------------------------------
;; KEY FUNCTION

(define key
  (lambda (w)
    (reduce
      (lambda (a b)
        (+ (* 31 b) a))
      (map ctv w)
      5387)))

(define set_true
  (lambda (indices v)
    (if
      (null? indices)
      v
      (let
        ((temp (array-set! v 1 (car indicies))))
        (set_true (cdr indices) v)))))

(define hash_keys
  (lambda (fn_list w)
    (if
      (null? fn_list)
      '()
      (append ((car fn_list) w) (hash_keys (cdr fn_list))))))

(define all_match
  (lambda (indices v)
    ;; finish this!!

(define gen_vector
  (lambda (max_size fn_list dict)
    (if
      (null? dict)
      (make-array 0 max_size)
      (letrec
        ((keys (hash_keys fn_list (car dict)))
        (v (gen_vector (max keys) fn_list (cdr dict)))
        (set_true keys v))))))

;; -----------------------------------------------------
;; EXAMPLE KEY VALUES
;;   (key '(h e l l o))     = 154238504134
;;   (key '(w a y))         = 160507203
;;   (key '(r a i n b o w)) = 148230379423562

;; -----------------------------------------------------
;; HASH FUNCTION GENERATORS

;; value of parameter "size" should be a prime number
(define gen-hash-division-method
  (lambda (size) ;; range of values: 0..size-1
    (lambda (k)
      (remainder (key k) size))))

;; value of parameter "size" is not critical
;; Note: hash functions may return integer values in "real"
;;       format, e.g., 17.0 for 17

(define gen-hash-multiplication-method
  (lambda (size) ;; range of values: 0..size-1
    (lambda (k)
      (floor (* (remainder (* (key k) A) 1) size)))))


;; -----------------------------------------------------
;; EXAMPLE HASH FUNCTIONS AND HASH FUNCTION LISTS

(define hash-1 (gen-hash-division-method 70111))
(define hash-2 (gen-hash-division-method 89997))
(define hash-3 (gen-hash-multiplication-method 700224))
(define hash-4 (gen-hash-multiplication-method 900))

(define hashfl-1 (list hash-1 hash-2 hash-3 hash-4))
(define hashfl-2 (list hash-1 hash-3))
(define hashfl-3 (list hash-2 hash-3))


;; -----------------------------------------------------
;; EXAMPLE HASH VALUES
;;   to test your hash function implementation
;;
;;  (hash-1 '(h e l l o))     ==> 538
;;  (hash-1 '(w a y))         ==> 635
;;  (hash-1 '(r a i n b o w)) ==> 308
;;
;;  (hash-2 '(h e l l o))     ==> 379
;;  (hash-2 '(w a y))         ==> 642
;;  (hash-2 '(r a i n b o w)) ==> 172
;;
;;  (hash-3 '(h e l l o))     ==> 415.0
;;  (hash-3 '(w a y))         ==> 390.0
;;  (hash-4 '(r a i n b o w)) ==> 646.0
;;
;;  (hash-4 '(h e l l o))     ==> 533.0
;;  (hash-4 '(w a y))         ==> 502.0
;;  (hash-4 '(r a i n b o w)) ==> 646.0


;; -----------------------------------------------------
;; SPELL CHECKER GENERATOR

(define gen-checker
  (lambda (hashfunctionlist dict)
    (let
      ((v (gen_vector 0 hashfunctionlist dict)))
      (lambda (w)
        (if
          (all_match (hash_keys w) v)
          #t
          #f
        )))))

;; -----------------------------------------------------
;; EXAMPLE SPELL CHECKERS

(define checker-1 (gen-checker hashfl-1 dictionary))
(define checker-2 (gen-checker hashfl-2 dictionary))
(define checker-3 (gen-checker hashfl-3 dictionary))

;; EXAMPLE APPLICATIONS OF A SPELL CHECKER
;;
;;  (checker-1 '(a r g g g g)) ==> #f
;;  (checker-2 '(h e l l o)) ==> #t

