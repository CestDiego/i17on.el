;;; i17on.el --- Major mode i17on mode

;; Copyright (C) 2016 Diego Berrocal

;; Author: Diego Berrocal <cestdiego@gmail.com>
;; Created: 24 October 2016

;; Keywords: i17on
;; Homepage: http://www.github.com/CestDiego/i17on.el/
;; Version: 1.0.0
;; Package-Requires: ((emacs "24"))

;; This file is not part of GNU Emacs.

;;; License:
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;

;;; Commentary:

;; Major mode for i17on
;; See: https://github.com/Yuffster/i17on

;; Example syntax

;; @list{{
;; foo:Hello this is foo
;; |-bar:
;; And this is bar.
;; |-!bizz:
;; Definitely not bizz.
;; |-This would be default: but there's a colon in it.
;; |-
;; default: text yay.
;; }}

;; Conditions are preceded by |-  and end in :. conditions are one word

;;; Code:

(require 'rx)


;;; Font-Lock and Syntax
(defvar i17on-font-lock-keywords
  `(
    ;;Keywords
    (,(rx (group "|-"))
     (1 font-lock-negation-char-face))

    (,(rx (seq (or "|-" line-start) (* space) (group (? "!") (+ (or word "-" "_"))) (* space) ":" ))
     (1 font-lock-keyword-face))

    (,(rx (seq "{"
               (* (not (any "!" "-" "_" word)))
               (group (? "!") (+ (or word "-" "_")))
               (* space)
               ":" ))
     (1 font-lock-keyword-face))

    (,(rx (seq (group "@" (+ (or word "-" "_"))) (* space) "{") )
     (1 font-lock-function-name-face))
    ))

;;;###autoload
(define-derived-mode i17on-mode prog-mode
 "i17on"
  "Major mode for editing i17on files.

\\{i17on-mode-map}"

  (set (make-local-variable 'comment-start) "// ")
  (set (make-local-variable 'comment-start-skip) "//+\\s-*")
  ;; (set (make-local-variable 'indent-line-function) #'i17on/indent-line)

  (set (make-local-variable 'font-lock-defaults)
       `(,i17on-font-lock-keywords nil nil nil nil)))

(add-to-list 'auto-mode-alist `("\\.i17on\\'" . 'i17on-mode))
(add-to-list 'auto-mode-alist `("\\.i17on\\.md\\'" . 'i17on-mode))


(provide 'i17on)
