(use-package company-go
  :ensure t)

(use-package go-mode
  :ensure t
  :ensure-system-package (godef . "go get github.com/rogpeppe/godef")
  :ensure-system-package (gocode . "go get -u github.com/nsf/gocode")
  :ensure-system-package (goimports . "go get -u golang.org/x/tools/cmd/goimports")
  :mode "\\.go\\'"
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "M-.") 'godef-jump)))
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook (lambda ()
                            (setq tab-width 4 indent-tabs-mode 1)
                            (setq gofmt-command "goimports")
                            (require 'go-mode-autoloads)
                            (add-hook 'before-save-hook 'gofmt-before-save)
                            (add-hook 'before-save-hook
                                      (lambda ()
                                        (setq-local comment-auto-fill-only-comments t)
                                        (auto-fill-mode 1)))))
  (add-hook 'go-mode-hook 'go-guru-hl-identifier-mode))

(use-package go-guru
  :ensure t
  :ensure-system-package (guru . "go get golang.org/x/tools/cmd/guru"))

(use-package go-rename
  :ensure t
  :ensure-system-package (guru . "go get golang.org/x/tools/cmd/gorename"))

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

(defun go-test-current-function ()
  (interactive)
  (progn
    (with-current-buffer 
      (get-buffer-create "go-test-result")
      (erase-buffer))
    (start-process-shell-command "go test" "go-test-result" "go" "test" "-run" (shell-quote-argument (go--function-name t)) ".")
    (display-buffer "go-test-result" t)))

