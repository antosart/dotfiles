(eval-after-load "tex" '(load-user-file "bibretrieve-config.el"))

(eval-after-load "tex"
'(add-to-list 'TeX-command-list '("InView"
           "(lambda ()
               (let ((f \"%o\"))
                 (find-file-other-window f)
                 (doc-view-mode)))"
             TeX-run-function nil t)))

(use-package latex
  :mode
  ("\\.tex\\'" . latex-mode)
  :ensure auctex
  :config
  (setq reftex-plug-into-AUCTeX t) 
  (setq reftex-label-alist
        '(("lemma"   ?l "lem:"  "~\\ref{%s}" nil ("lemma"   "lem."))
          ("proposition"   ?p "prop:"  "~\\ref{%s}" nil ("proposition"   "prop."))
          ("example"   ?x "ex:"  "~\\ref{%s}" nil ("example"   "ex."))
          ("remark"   ?r "rem:"  "~\\ref{%s}" nil ("remark"   "rem."))
          ("definition"   ?d "def:"  "~\\ref{%s}" nil ("definition"   "def."))
          ("conjecture"   ?j "conj:"  "~\\ref{%s}" nil ("conjecture"   "conj."))
          ("corollary"   ?c "cor:"  "~\\ref{%s}" nil ("corollary"   "cor."))
          ("theorem" ?h "thm:" "~\\ref{%s}" t   ("theorem" "thm."))))
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook 'turn-off-auto-fill)
  (add-hook 'LaTeX-mode-hook (lambda () (set-fill-column 60)))

  (add-hook 'LaTeX-mode-hook 'flyspell-mode)

; Per synctex
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

  (add-hook 'LaTeX-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'text-mode-hook 'turn-on-visual-line-mode)

  (add-hook 'LaTeX-mode-hook
        (lambda ()
          (LaTeX-add-environments
            '("lemma" LaTeX-env-label)
            '("prop" LaTeX-env-label)
            '("example" LaTeX-env-label)
            '("remark" LaTeX-env-label)
            '("definition" LaTeX-env-label)
            '("conjecture" LaTeX-env-label)
            '("corollary" LaTeX-env-label)
            '("theorem" LaTeX-env-label))))

  (add-hook 'LaTeX-mode-hook '(lambda () (outline-minor-mode 1)))
  (add-hook 'LaTeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
			    (cons "\\(" "\\)"))))
  (add-hook 'LaTeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'LaTeX-electric-left-right-brace)
			  1)))
  )

(defun my-replace-search-function (string &optional limit noerror)
  (if (search-forward string limit t)
      (if (save-excursion 
	    (save-restriction
	      (save-match-data
		(and (texmathp) ;; I do not why, but texmathp has to be protected
		     (not (looking-back "\\\\[a-zA-Z]*D" 50 t))
		     ))))
	  (point)
	  (my-replace-search-function string limit t))
    (not t)))

(defun my-replace-inside-mathmode (a b &optional arg)
  (interactive "sReplace: \nsWith: ")
  (let (;(a (read-string "Replace: "))
	 ;(b (read-string "With: "))
	 (replace-search-function 'my-replace-search-function)
	 p1 p2)
    (if (region-active-p)
	(progn (setq p1 (region-beginning))
	       (setq p2 (region-end)))
      (setq p1 (point))
      (setq p2 (point-max)))
    (perform-replace a b t nil nil nil nil p1 p2)))

; This adds Make to the tex command list.
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("Make" "make" TeX-run-command nil t)))


(defun my-comment-unused-macros ()
  (interactive)
  (let ((p1 (if (region-active-p) (region-beginning) (line-beginning-position)))
	(p2 (if (region-active-p) (region-end) (line-end-position)))
	(case-fold-search nil))
    (save-restriction
      (beginning-of-buffer)
      (narrow-to-region p1 p2)
;	(progn 
;	  (goto-char p1)
	  (while (< (point) (point-max))
	    (let ((command
		   (progn 
;		     (insert "H")
		     (if (re-search-forward "\\\\\\(re\\)?newcommand{\\\\\\([a-zA-Z]*\\)}" p2 2)
			 (end-of-line))
		     (match-string 2))))
	      (if command
		  (if (not (save-restriction (widen) (save-excursion (re-search-forward (concat "\\\\" command "[^a-zA-Z]") nil t))))
		      (save-excursion 
			(beginning-of-line)
			(insert "% ")
			))
		))
	      )
	    )
	  )
	)
    
  

(defun my-remove-latex-comments ()
  (interactive)
  (let ((p1 (if (region-active-p) (region-beginning) (line-beginning-position)))
	(p2 (if (region-active-p) (region-end) (line-end-position))))
	(replace-regexp "^%.*$" "" nil nil))
)


(defun replace-dollars (b e)
  (interactive "r")
  (replace-regexp "[$]\\([^$]*\\)[$]" "\\\\(\\1\\\\)" nil b e))

(defun my-insert-parentheses ()
  "Make a pair of (possibly escaped) parentheses and be poised to type
 inside of them."
  (interactive)
  (insert ?\\)
  (insert ?\()
  (save-excursion
    (insert ?\\)
    (insert ?\)))
  )



;; Sostituisco la funzione di default con una funzione che sostituisce
;; dollari con \( \)
(eval-after-load "tex"
'(global-set-key (kbd "C-$") 'my-insert-parentheses))
(eval-after-load "tex"
'(defun TeX-insert-dollar-old (&optional arg)
  "Insert dollar sign.

If current math mode was not entered with a dollar, refuse to
insert one.  Show matching dollar sign if this dollar sign ends
the TeX math mode and `blink-matching-paren' is non-nil.  Ensure
double dollar signs match up correctly by inserting extra dollar
signs when needed.

With raw \\[universal-argument] prefix, insert exactly one dollar
sign.  With optional ARG, insert that many dollar signs."
  (interactive "P")
  (cond
   ((and arg (listp arg))
    ;; C-u always inserts one
    (insert "$"))
   (arg
    ;; Numerical arg inserts that many
    (insert (make-string (prefix-numeric-value arg) ?\$)))
   ((TeX-escaped-p)
    ;; This is escaped with `\', so just insert one.
    (insert "$"))
   ((texmathp)
    ;; We are inside math mode
    (if (and (stringp (car texmathp-why))
	     (string-equal (substring (car texmathp-why) 0 1) "\$"))
	;; Math mode was turned on with $ or $$ - so finish it accordingly.
	(progn
	  (if TeX-math-close-double-dollar
	      (insert (car texmathp-why))
	    (insert ?\\)
	    (insert ?\)))
	  (when (and blink-matching-paren
		     (or (string= (car texmathp-why) "$")
			 (zerop (mod (save-excursion
				       (skip-chars-backward "$")) 2))))
	    (save-excursion
	      (goto-char (cdr texmathp-why))
	      (delete-char 1)
	      (insert ?\\)
	      (insert ?\()
	      (if (pos-visible-in-window-p)
		  (sit-for 1)
		(message "Matches %s"
			 (buffer-substring
			  (point) (progn (end-of-line) (point))))))))
      ;; Math mode was not entered with dollar - we cannot finish it with one.
      (message "Math mode started with `%s' cannot be closed with dollar"
	       (car texmathp-why))
      (insert "$")))
   (t
    ;; Just somewhere in the text.
    (insert "$")))
  (TeX-math-input-method-off))
)

;; (eval-after-load "latex"
;; '(progn
;;    (define-key (current-global-map) (kbd "$") 'my-TeX-insert-dollar))
;; )

(setq TeX-PDF-mode t)

(eval-after-load "tex"
  '(progn
     (add-to-list 'TeX-expand-list
                  '("%(RubberPDF)"
                    (lambda ()
                      (if
                          (not TeX-PDF-mode)
                          ""
                        "--pdf"))))
     (add-to-list 'TeX-command-list
                '("Rubber" "rubber -W all %(RubberPDF) %t" TeX-run-command nil t) t)))

(add-hook 'TeX-mode-hook
          '(lambda ()
            (define-key TeX-mode-map (kbd "<f9>")
              (lambda ()
                (interactive)
                (save-buffer)
                (TeX-command-menu "Rubber")
                (TeX-clean)))
            (define-key TeX-mode-map (kbd "<f12>")
              (lambda ()
                (interactive)
                (TeX-view)
                [return]))))


(add-hook 'plain-TeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
			  (cons "$" "$"))))
