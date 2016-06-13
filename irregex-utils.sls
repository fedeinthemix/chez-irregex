;;; Chez-Scheme library for Alex Shinn's Irregex
;;; 
;;; Copyright (c) 2016 Federico Beffa <beffa@fbengineering.ch>
;;; 
;;; Permission to use, copy, modify, and distribute this software for
;;; any purpose with or without fee is hereby granted, provided that the
;;; above copyright notice and this permission notice appear in all
;;; copies.
;;; 
;;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
;;; WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
;;; WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
;;; AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
;;; DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA
;;; OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
;;; TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
;;; PERFORMANCE OF THIS SOFTWARE.

(library (irregex-utils)
  (export
   irregex-quote
   irregex-opt
   sre->string)
  (import 
    (except (rnrs) error find filter remove)
    (only (chezscheme) include get-output-string open-output-string)
    (irregex)
    (only (srfi :1) every))

  ;; definition from irregex
  (define (error msg . args)
    (display msg)
    (for-each (lambda (x) (display " ") (write x)) args)
    (newline)
    (0))
  
  (include "irregex-utils.scm")

)
