(setq tab-always-indent 'complete
      completion-cycle-threshold t)

(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))
(setq vc-follow-symlinks t)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
(setq-default fill-column 72)
(menu-bar-mode -1)
(xterm-mouse-mode 1) ;; Enable mouse
(tool-bar-mode -1)
(global-auto-revert-mode t)

(use-package atom-one-dark-theme
  :config
  (load-theme 'atom-one-dark t))
(set-face-attribute 'default nil :font "Monaco" :height 150)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package recentf
  :ensure nil
  :config
  (add-hook 'after-init-hook 'recentf-mode)
  (setq-default
    recentf-max-saved-items 1024
    recentf-exclude `("/tmp/")))

(use-package counsel
  :after evil
  :init
  (evil-define-key 'normal ivy-mode-map
    (kbd "<leader>fb") 'ivy-switch-buffer
    (kbd "<leader>fm") 'counsel-recentf)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
	'((read-file-name-internal . ivy--regex-fuzzy)
	  (t . ivy--regex-plus))))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package avy
  :ensure t)

(use-package company
  :init
  (setq company-global-modes
	'(emacs-lisp-mode go-mode ledger-mode sh-mode))
  :hook ((after-init . global-company-mode))
  :config
  (setq company-minimum-prefix-length 1))

(use-package projectile
  :init
    (evil-define-key 'normal projectile-mode-map
	(kbd "<leader>p") 'projectile-command-map)
  :config
  (setq projectile-cache-file (expand-file-name ".cache/projectile" user-emacs-directory))
  (projectile-mode 1))

(provide 'init-misc)
