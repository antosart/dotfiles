(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(add-to-list 'default-frame-alist '(font . "mono 9" ))
(set-face-attribute 'default t :font "mono 9" )

(tool-bar-mode -1)

(global-set-key (kbd "<f8>") 'compare-windows)

(setq doc-view-continuous t)

(global-unset-key (kbd "<prior>"))
(global-unset-key (kbd "<next>"))

(setq ispell-dictionary "en")


(defun adjust-doc-view ()
  (local-set-key (kbd "M-v")
    'doc-view-scroll-down-or-previous-page)
  (local-set-key (kbd "C-v")
    'doc-view-scroll-up-or-next-page)
)
(add-hook 'doc-view-mode-hook 'adjust-doc-view)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(defun my-scroll-up (arg)
  (interactive "P")
  (with-selected-window (other-window-for-scrolling)
    (if (eq 'doc-view-mode major-mode)
        (doc-view-scroll-up-or-next-page arg)
      (scroll-up arg))))
(defun my-scroll-down (arg)
  (interactive "P")
  (with-selected-window (other-window-for-scrolling)
    (if (eq 'doc-view-mode major-mode)
        (doc-view-scroll-down-or-previous-page arg)
      (scroll-down arg))))

(global-set-key (kbd "M-<next>") 'my-scroll-up)
(global-set-key (kbd "M-<prior>") 'my-scroll-down)


(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

(add-hook 'after-init-hook (lambda ()
	  (progn
	    (global-company-mode)
	    (add-to-list 'company-backends 'company-web-html)
	    (add-to-list 'company-backends 'company-web-jade)
	    (add-to-list 'company-backends 'company-web-slim)
	    (global-set-key (kbd "C-c C-SPC") 'company-complete))))

(setq-default indent-tabs-mode nil)
(dtrt-indent-mode)
