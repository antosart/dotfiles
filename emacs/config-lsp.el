(use-package lsp-mode
  :ensure t
  :hook (
         (go-mode . lsp-deferred)
         (rust-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config (progn
	       (setq gc-cons-threshold 100000000)
	       (setq read-process-output-max (* 1024 1024)) ;; 1mb
	       (setq company-minimum-prefix-length 1
		           company-idle-delay 0.0) ;; default is 0.2
               (setq lsp-prefer-flymake nil))
  )

(use-package lsp-ui :ensure t :commands lsp-ui-mode)
(use-package company-lsp :ensure t :commands company-lsp)
(use-package helm-lsp :ensure t :commands helm-lsp-workspace-symbol)
