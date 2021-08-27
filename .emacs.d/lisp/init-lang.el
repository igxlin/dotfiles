(use-package ledger-mode
  :mode (("\\.journal$" . ledger-mode))
  :config
  (setq ledger-default-date-format ledger-iso-date-format))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init
  (evil-define-key 'normal markdown-mode-map
    (kbd "<RET>") 'markdown-follow-link-at-point)
  (setq markdown-command "multimarkdown"))

(use-package go-mode
  :ensure t
  :commands (go-mode)
  :mode (("\\.go$" . go-mode))
  :hook ((go-mode . (lambda () (setq tab-width 4)))))

(use-package eglot
  :ensure t
  :commands (eglot)
  :hook
  ((go-mode . eglot-ensure)))

(use-package magit
  :ensure t
  :config
  (setq magit-refresh-status-buffer nil)
  (evil-define-key 'normal 'global
    (kbd "<leader>gs") 'magit))

(provide 'init-lang)
