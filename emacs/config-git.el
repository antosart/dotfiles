(use-package magit
  :commands magit-get-top-dir
  :ensure t
  :init
  ;; Close popup when commiting - this stops the commit window
  ;; hanging around
  ;; From: http://git.io/rPBE0Q
  (defadvice git-commit-commit (after delete-window activate)
    (delete-window))
  (defadvice git-commit-abort (after delete-window activate)
    (delete-window))
  :config
  (setq
     ;; highlight word/letter changes in hunk diffs
   magit-diff-refine-hunk t)
  (setq git-commit-summary-max-length 72))

(global-git-commit-mode)

(setq vc-follow-symlinks t)

(use-package gitignore-mode
  :ensure t)
