(use-package elpy
  :ensure t
  :commands elpy-enable
  :init (with-eval-after-load 'python (elpy-enable))
  :config 
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  ;;(elpy-use-ipython "ipython3")
  (setq elpy-rpc-python-command "python3"))
  ;;(setq python-shell-interpreter-args "--simple-prompt --pprint"))
