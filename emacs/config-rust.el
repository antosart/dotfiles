(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :config
  (add-hook 'rust-mode-hook (lambda ()
                            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer))))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(use-package racer
  :ensure t
  :ensure-system-package (racer . "cargo install racer")
  :after (company)
  :hook (rust-mode . racer-mode)
  :config
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))

(use-package flycheck-rust
  :ensure t
  :after rust-mode
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
