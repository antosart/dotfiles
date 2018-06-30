(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(add-to-list 'default-frame-alist '(font . "Hack 9" ))
(set-face-attribute 'default t :font "Hack 9" )

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


(use-package sr-speedbar
  :ensure t
  :bind (("s-s" . 'sr-speedbar-toggle)))

(setq-default indent-tabs-mode nil)

(use-package dtrt-indent
  :ensure t
  :commands dtrt-intent-mode)


(use-package projectile
  :ensure t
  :demand t
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :demand t
  :after (helm projectile)
  :config (helm-projectile-on))

(use-package helm-ag
  :ensure t
  :commands (helm-ag helm-projectile-ag)
  :init (setq helm-ag-insert-at-point 'symbol))

(use-package helm-company
  :ensure t
  :after (company)
  :config
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

(use-package yasnippet-snippets
  :ensure t
  :config (yas-global-mode))

(use-package markdown-mode
  :ensure t
  :ensure-system-package markdown
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "markdown"))

(use-package markdown-preview-mode
  :ensure t
  :commands (markdown-preview-mode))

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'")

(use-package vmd-mode
  :ensure t
  :commands (vmd-mode))

(use-package toml-mode
  :ensure t
  :mode "\\.toml\\'")

(require 'midnight)
(setq clean-buffer-list-delay-general 1)
