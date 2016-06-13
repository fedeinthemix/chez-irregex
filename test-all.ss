#!/usr/bin/env scheme-script

;; just run this file as "scheme --program test-all.ss" to run the full
;; test suite

(import (rename (chezscheme) (format sprintf)
                (call-with-string-output-port call-with-output-string))
        (rename (srfi :64) (test-equal test))
        (test-utils)
        (irregex)
        (matchable))

(test-begin "test-all")

;; requires use of library internal definitions.
;; (load "test-cset.scm")
(load "test-irregex.scm")
(load "test-irregex-scsh.scm")
(load "test-irregex-pcre.scm")

(test-end "test-all")

;; (test-exit)


