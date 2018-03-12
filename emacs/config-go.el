(use-package company-go
  :ensure t)

(use-package go-mode
  :ensure t
  :ensure-system-package (godef . "go get github.com/rogpeppe/godef")
  :ensure-system-package (gocode . "go get -u github.com/nsf/gocode")
  :mode "\\.go\\'"
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "M-.") 'godef-jump)))
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook (lambda ()
                            (setq tab-width 4 standard-indent 4 indent-tabs-mode nil)))
                                        ; makes sure tabs are not used.
  (add-hook 'go-mode-hook 'go-guru-hl-identifier-mode))

(use-package go-guru
  :ensure t
  :ensure-system-package (guru . "go get golang.org/x/tools/cmd/guru"))

(use-package go-eldoc
  :ensure t
  :ensure-system-package (godoc . "go get golang.org/x/tools/cmd/godoc"))

(use-package go-dlv
  :ensure t)

(use-package company-go
  :ensure t
  :defer t
  :after (company)
  :config
  (add-to-list 'company-backends 'company-go))

