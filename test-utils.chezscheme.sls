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

(library (test-utils)
  (export sprintf read-line port-for-each string-intersperse string-split
          call-with-output-string call-with-input-string test)
  (import (rename (chezscheme) (format sprintf)
                  (call-with-string-output-port call-with-output-string))
          (irregex)
          (rename (srfi :64) (test-equal test))
          (matchable))

 (define read-line
   (case-lambda
     (() (get-line (current-input-port)))
     ((p) (get-line p))))

 (define (port-for-each fn thunk)
   (let loop ()
     (let ((x (thunk)))
       (unless (eof-object? x)
         (fn x)
         (loop)))))

 (define (call-with-input-string str proc)
   (let ((p (open-input-string str)))
     (proc p)))

 ;;; The following code was copied from the indicated URL and has the
 ;;; following license.
 
 ;; Copyright 2009 Derick Eddington.  My MIT-style license is in the file named
 ;; LICENSE from the original collection this file is distributed with.

 ;; from https://github.com/stuhlmueller/scheme-tools/blob/master/xitomatl/lists.sls
 (define (intersperse l sep)
   (let loop ((l l) (r '()) (sep sep) (orig l))
     (cond ((pair? l) (loop (cdr l) (cons* sep (car l) r) sep orig))
           ((null? l) (if (null? r) '() (reverse (cdr r))))
           (else (error "not a proper list" orig)))))

 ;; from https://github.com/stuhlmueller/scheme-tools/blob/master/xitomatl/strings.sls
 (define (string-intersperse sl ssep)
   (apply string-append (intersperse sl ssep)))

 (define whitespace 
   (apply string
          '(#\space #\linefeed #\return #\tab #\vtab #\page #\x85 #\xA0 
            #\x1680 #\x180E #\x2000 #\x2001 #\x2002 #\x2003 #\x2004 #\x2005
            #\x2006 #\x2007 #\x2008 #\x2009 #\x200A #\x2028 #\x2029 #\x202F
            #\x205F #\x3000)))

 (define string-split
   (case-lambda
     ((str) 
      (string-split str whitespace #F))
     ((str delim-chars)
      (string-split str delim-chars #F))
     ((str delim-chars keep-empty)
      (unless (and (string? str) (string? delim-chars))
        (assertion-violation 'string-split "not a string" 
                             (if (string? delim-chars) str delim-chars)))
      (let ((strlen (string-length str))
            (dellen (string-length delim-chars)))
        (let loop ((i (- strlen 1))
                   (to strlen)
                   (accum '()))
          (if (< i 0)
              (if (or (< 0 to) keep-empty)
                  (cons (substring str 0 to) accum)
                  accum)
              (let ((c (string-ref str i)))
                (let check ((j 0))
                  (cond ((= j dellen) (loop (- i 1) to accum))
                        ((char=? c (string-ref delim-chars j))
                         (loop (- i 1) i (let ((i+1 (+ i 1)))
                                           (if (or (< i+1 to) keep-empty)
                                               (cons (substring str i+1 to) accum)
                                               accum))))
                        (else (check (+ j 1))))))))))))

 )
