(use-package org
  :ensure t
  :after evil
  :commands (org-mode org-agenda org-store-link org-capture)
  :mode (("\\.org$" . org-mode))
  :hook ((org-mode . (lambda () (setq tab-width 4))))
  :init
  (setq org-src-tab-acts-natively t)
  (evil-define-key 'normal 'global
    (kbd "<leader>a") 'org-agenda
    (kbd "<leader>l") 'org-store-link
    (kbd "<leader>c") 'org-capture)
  :config
  (require 'org-tempo)
  (setq org-default-notes-file "~/journals/inbox.org")
  (setq org-capture-templates
	'(("t" "TODO" entry (file+headline org-default-notes-file "Tasks")
	   "* TODO %?\nCaptured on %U\n  %i\n  %a")
	  ("j" "Journal" entry (file+datetree org-default-notes-file)
	   "* %?\nCaptured on %U\n  %i\n  %a")))
  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
  (setq org-agenda-start-on-weekday 0)
  (setq org-adapt-indentation nil)
  (setq org-descriptive-links nil)
  (evil-define-key 'normal org-mode-map
    (kbd "TAB") 'org-cycle
    (kbd "RET") 'org-open-at-point
    (kbd "<leader>os") 'org-schedule
    (kbd "<leader>od") 'org-deadline
    (kbd "<leader>or") 'org-refile
    (kbd "<leader>oil") 'org-insert-link
    (kbd "<leader>oih") 'org-insert-heading
    (kbd "<leader>oci") 'org-clock-in
    (kbd "<leader>oco") 'org-clock-out
    (kbd "<leader>ocr") 'org-clock-report
    (kbd "<leader>sp") 'org-set-property
    (kbd "+") 'org-priority-up
    (kbd "-") 'org-priority-down)
  (setq org-tags-exclude-from-inheritance
	'("PROJECT"))

  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  ;; refile
  (setq org-refile-targets '((nil :maxlevel . 9)
			     (org-agenda-files :maxlevel . 9))
	org-outline-path-complete-in-steps nil
        org-refile-use-outline-path 'file)

  (setq org-stuck-projects
	'("+PROJECT/-SOMEDAY-DONE-MAYBE" ("NEXT") ("@shop")
	  "\\<IGNORE\\>"))

  ;; todo
  (setq org-todo-keywords
	'((sequence "TODO(t)" ; to do later
		    "NEXT" ; doing now or to do soon
		    "WAITING(w)" "SOMEDAY(s)"
		    "|" "DONE(d)" "CANCELED(c)")))
  (setq org-log-done t)

  ;; tags
  (setq org-tag-alist '((:startgroup . nil)
			("@work" . ?w) ("@home" . ?h) ("errants" . ?e)
			(:endgroup . nil)
			("phone" . ?p)
			("FLAGGED" . ?f)
			("URGENT" . ?u)
			("PROJECT" . ?p)))

  ;; org babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)))

  ;; org-habit
  (add-to-list 'org-modules 'org-habit t))

(use-package org-agenda
  :ensure nil
  :after (org)
  :commands (org-agenda)
  :init
  (setq org-agenda-dim-blocked-tasks nil)
  (setq org-agenda-skip-deadline-prewarning-if-scheduled t)
  (setq org-agenda-prefix-format
	'((agenda . "%i %-12:c%?-12t% s %b")
	  (timeline . "  % s")
	  (todo . "%i %-12:c %b")
	  (tags . "%i %-12:c")
	  (search . " %i %-12:c")))

  (setq org-deadline-warning-days 10)
  (setq org-agenda-compact-blocks t)
  (setq org-agenda-custom-commands
	'(("D" "Daily agenda and all TODOs"
	   ((agenda "" ((org-agenda-span 1)))
	    (tags-todo "+PRIORITY=\"A\"")
	    (tags-todo "computer|@office|phone")
	    (tags "PROJECT+CATEGORY=\"elephants\"")
	    (todo "WAITING"))
	   ((org-agenda-compact-blocks t)))
	  ("W" "Weekly Review"
	   ((agenda "" ((org-agenda-ndays-to-span 7)))
	    (stuck "") ; review stuck porjects as designated by org-stuck-projects
	    (todo "NEXT")
	    (todo "WAITING")))
	  ("d" "Upcoming deadlines" agenda ""
	   ((org-agenda-time-grid nil)
	    (org-deadline-warning-days 365)
	    (org-agenda-entry-types '(:deadline))))
	  ("c" "Weekly schedule" agenda ""
	   ((org-agenda-span 7)
	    (org-agenda-repeating-timestamp-show-all t)
	    (org-agenda-entry-types '(:deadline :scheduled))))
	  ("g" . "GTD contexts")
	  ("gh" "Home" tags-todo "home")
	  ("p" . "Priorities")
	  ("pa" "A items" tags-todo "+PRIORITIES=\"A\"")
	  ("pb" "B items" tags-todo "+PRIORITIES=\"B\"")
	  ("pc" "C items" tags-todo "+PRIORITIES=\"C\""))))

(use-package evil-org
  :ensure t
  :after (org evil)
  :hook (org-mode . (lambda () (evil-org-mode)))
  :config
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar todo))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  (evil-define-key 'motion org-agenda-mode-map
    (kbd "q") (lambda ()
		(interactive)
		(org-save-all-org-buffers)
		(org-agenda-quit))))

(provide 'init-org)
