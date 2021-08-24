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

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook
  ((go-mode . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))
  :config
  (evil-define-key 'normal lsp-mode-map
    (kbd "gd") 'lsp-find-definition
    (kbd "gr") 'lsp-find-references)
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.git\\'"))

(use-package dap-mode
  :defer
  :commands (dap-mode)
  :ensure t
  :hook
  ((lsp-mode . dap-mode))
  ((go-mode . (lambda () (require 'dap-go))))
  :config
  (dap-auto-configure-mode t)
  (setq dap-auto-configure-features '(sessions locals controls tooltip)))

(use-package magit
  :ensure t)

(provide 'init-lang)
