;; -*- coding: utf-8; lexical-binding: t; -*-

;; Make startup faster by reducing frequency of garbage collection.
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)
;; Make gc pauses faster by decreasing the threhold to 8 MiB (default is
;; 800kB)
(add-hook 'emacs-startup-hook
	  (lambda () (setq gc-cons-threshold (expt 2 23))))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defconst *is-a-mac* (eq system-type 'darwin))

(require 'init-package)
(require 'init-evil)
(require 'init-org)
(require 'init-lang)
(require 'init-misc)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)
