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

(library (irregex)
  (export 
    irregex
    string->irregex
    sre->irregex
    string->sre
    maybe-string->sre
    irregex?
    irregex-match-data?
    irregex-new-matches
    irregex-reset-matches!
    irregex-search
    irregex-search/matches
    irregex-match
    irregex-search/chunked
    irregex-match/chunked
    irregex-fold/chunked
    make-irregex-chunker
    irregex-match-substring
    irregex-match-subchunk
    irregex-match-start-chunk
    irregex-match-end-chunk
    irregex-match-start-index
    irregex-match-end-index
    irregex-match-num-submatches
    irregex-match-names
    irregex-match-valid-index?
    irregex-fold
    irregex-replace
    irregex-replace/all
    irregex-dfa
    irregex-dfa/search
    irregex-nfa
    irregex-flags
    irregex-lengths
    irregex-names
    irregex-num-submatches
    irregex-extract
    irregex-split
    sre->cset)
  (import 
    (except (rnrs) error find filter remove)
    (rnrs r5rs)
    (rnrs mutable-pairs)
    (rnrs mutable-strings)
    (only (chezscheme) include))

  ;; definition from irregex
  (define (error msg . args)
    (display msg)
    (for-each (lambda (x) (display " ") (write x)) args)
    (newline)
    (0))
  
  (include "irregex.scm")

)
