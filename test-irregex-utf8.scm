#!/usr/local/bin/csi -script

(import (rename (chezscheme) (format sprintf)
                (call-with-string-output-port call-with-output-string))
        (rename (srfi :64) (test-equal test))
        (test-utils)
        (irregex)
        (matchable))

;; (use test extras utils irregex)

(test-begin "test-irregex-utf8")

(test-assert (irregex-search "(?u:<..>)" "<漢字>"))
(test-assert (irregex-search "(?u:<.*>)" "<漢字>"))
(test-assert (irregex-search "(?u:<.+>)" "<漢字>"))
(test-assert (not (irregex-search "(?u:<.>)" "<漢字>")))
(test-assert (not (irregex-search "(?u:<...>)" "<漢>")))

(test-assert (irregex-search "(?u:<[^a-z]*>)" "<漢字>"))
(test-assert (not (irregex-search "(?u:<[^a-z]*>)" "<漢m字>")))
(test-assert (irregex-search "(?u:<[^a-z][^a-z]>)" "<漢字>"))
(test-assert (irregex-search "(?u:<あ*>)" "<あ>"))
(test-assert (irregex-search "(?u:<あ*>)" "<ああ>"))
(test-assert (not (irregex-search "(?u:<あ*>)" "<あxあ>")))

(test-assert (irregex-search "(?u:<[あ-ん]*>)" "<あん>"))
(test-assert (irregex-search "(?u:<[あ-ん]*>)" "<ひらがな>"))
(test-assert (not (irregex-search "(?u:<[あ-ん]*>)" "<ひらgがな>")))
(test-assert (not (irregex-search "(?u:<[^あ-ん語]*>)" "<語>")))

(test-assert (irregex-search "(?u:<[^あ-ん]*>)" "<abc>"))
(test-assert (not (irregex-search "(?u:<[^あ-ん]*>)" "<あん>")))
(test-assert (not (irregex-search "(?u:<[^あ-ん]*>)" "<ひらがな>")))
(test-assert (irregex-search "(?u:<[^あ-ん語]*>)" "<abc>"))
(test-assert (not (irregex-search "(?u:<[^あ-ん語]*>)" "<あん>")))
(test-assert (not (irregex-search "(?u:<[^あ-ん語]*>)" "<ひらがな>")))
(test-assert (not (irregex-search "(?u:<[^あ-ん語]*>)" "<語>")))

(test-end "test-irregex-utf8")
