(require 'package)
    (setq package-archives '(("melpa" . "https://melpa.org/packages/")
			     ("elpa" . "https://elpa.gnu.org/packages/")
			     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			     )
	  )
			     ;; ("dnd" . "~/DND/")))

;;    (package-initialize)

(when (not (package-installed-p 'use-package))
	(package-refresh-contents)
	(package-install 'use-package))
(require 'use-package)

;  (require 'use-package-ensure)
  (setq use-package-always-ensure t)

(use-package auto-compile
  :commands auto-compile-mode
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 511 1024 1024))
(setq gc-cons-percentage 0.9)
(run-with-idle-timer 5 t #'garbage-collect)
(setq garbage-collection-messages t)

(defvar my-laptop-p (equal (system-name) "shyfox"))
(defvar my-server-p (and (equal (system-name) "localhost") (equal user-login-name "sg1")))
;; (defvar my-phone-p (not (null (getenv "ANDROID_ROOT")))
;; (global-auto-revert-mode)  ; simplifies syncing

(setq user-full-name "Zach Bombay"
	user-mail-address "zacharybombay@gmail.com"
	calendar-latitude 0.0
	calendar-longitude 0.0
	calendar-location-name "")

(global-hl-line-mode 1)

(setq inhibit-startup-message t)
 (tool-bar-mode 0)
;    (menu-bar-mode 0)
 (scroll-bar-mode -1)
 (tooltip-mode -1)
;    (setq global-linum-mode t)
 (column-number-mode t)
 (add-hook 'before-save-hook 'delete-trailing-whitespace)
;    (set-fringe-mode 10)
 (setq visible-bell t)

(setq-default cursor-type 'box)

(setq display-time-24hr-format nil)
(setq display-time-format "%H:%M / %d-%b-%Y  | ")

(display-time-mode 1)

(load-theme 'modus-vivendi-deuteranopia t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)
(ido-mode 1)

(global-visual-line-mode)

(use-package moody
  :config
  (setq x-underline-at-descent-line t
	    moody-mode-line-height 30)
(moody-replace-mode-line-buffer-identification)
(moody-replace-vc-mode))

(use-package minions
  :ensure t
  :config
  (setq minions-mode-line-lighter ""
	  minions-mode-line-delimiters '("" . ""))
  (minions-mode 1))

(set-face-attribute 'default nil :font "Source Code Pro" :height 105)
(setq zb/default-font-size 12)
(setq zb/current-font-size zb/default-font-size)

(setq frame-title-format (system-name))
;  (setq frame-title-format "%b")
  ;; (setq frame-title-format '((:eval (projectile-project-name))))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

(require 'unicode-fonts)
(unicode-fonts-setup)

(fset 'yes-or-no-p 'y-or-n-p)

(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/emacs_autosave/" t)))
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
(setq backup-by-copying t)

(cond
     ((string-equal system-type "windows-nt")
	(defvar sync_folder "C:/Users/zacha/sync/"))
     (
	(if my-laptop-p (string-equal system-type "gnu/linux")
	 (defvar sync_folder "~/Sync/"))
)
     )
(defvar nix_folder "~/Zero/nix-config/")

(defun zb/visit-emacs-config ()
(interactive)
(find-file (concat nix_folder "nixos/_mixins/base/emacs-config.org")))
(global-set-key (kbd "C-c e") 'zb/visit-emacs-config)

(defun zb/visit-nixos-config ()
(interactive)
(find-file (concat nix_folder "flake.nix")))
(global-set-key (kbd "C-c n") 'zb/visit-nixos-config)

(defun zb/visit-machine-nixos-config ()
(interactive)
(find-file (concat nix_folder "nixos/" (system-name) "/default.nix")))
(global-set-key (kbd "C-c m") 'zb/visit-machine-nixos-config)

(defun zb/kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'zb/kill-current-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq electric-pair-pairs '(
			     (?\{ . ?\})
			     (?\( . ?\))
			     (?\[ . ?\])
			     (?\" . ?\")
			     ))
(setq electric-pair-inhibit-predicate (lambda (c) (char-equal c ?<)))
;; (setq electric-pair-inhibit-predicate
;;     `(lambda (c)
;;        (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c)))))

(electric-pair-mode t)
(show-paren-mode 1)

(use-package rainbow-mode
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(setq org-fontify-done-headline t)
(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"
                             :weight normal
                             :strike-through t))))
 '(org-headline-done
   ((((class color) (min-colors 16) (background dark))
     (:foreground "LightSalmon" :strike-through t)))))

;  (define-key global-map "\C-cl" 'org-store-link)
 ;; (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)

(define-key global-map "\C-c \C-t" 'org-todo)
  (setq org-todo-keywords
	'((sequence "TODO(t)" "ACTIVE(a)" "|" "DONE(d)")
	  ;; (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	  (sequence "|" "CANCELED(c)")))

(setq org-todo-keyword-faces
	'(("TODO" . org-warning) ("ACTIVE" . "yellow")
	  ("CANCELED" . (:foreground "blue" :weight bold))))

(defvar org-tasks (concat sync_folder "org/inbox.org"))
;;  (defvar org-tasks (concat sync_folder "org/gtd.org"))
  (defvar org-journal (concat sync_folder "org/journal.org"))
  (defvar org-shopping (concat sync_folder "org/shopping.org"))
  (defvar org-gtd (concat sync_folder "org/gtd.org"))
  (defvar org-cookbook (concat sync_folder "org/cookbook.org"))
  (defvar org-book-path (concat sync_folder "org/books.org" ))

   (setq org-capture-templates
     '(
       ("t" "Todo" entry (file+headline  org-tasks "Tasks")
    "* TODO %?\n  %i\n  %a")
       ("j" "Journal" entry (file+datetree org-journal)
    "* %?\nEntered on %U\n  %i\n  %a")
       ("s" "Shopping" entry (file+headline org-shopping "Shopping")
    "* TODO %?\n %i")
       ("g" "Groceries" entry (file+headline org-shopping "Groceries")
    "* TODO %?\n %i")
       ("m" "Media" entry (file+headline org-shopping "Media")
    "* TODO %?\n %i")
       ("x" "testing" entry (file+headline org-gtd "Tasks")
  "* TODO %^{prompt}\n  %a")
   ; Org-Chef particular
       ("c" "Cookbook" entry (file org-cookbook)
     "%(org-chef-get-recipe-from-url)"
     :empty-lines 1)
       ("m" "Manual Cookbook" entry (file org-cookbook)
     "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
       ("bm" "Book" entry (file org-book-path)
	 "* %^{TITLE}\n:PROPERTIES:\n:ADDED: %<[%Y-%02m-%02d]>\n:END:%^{AUTHOR}p\n%?" :empty-lines 1)
     ("b" "Book url" entry (file org-book-path)
	     "%(let* ((url (substring-no-properties (current-kill 0)))
		  (details (org-book-path-get-details url)))
	     (when details (apply #'org-book-path-format 1 details)))")
      )
   )

(use-package org-roam
  ;; :ensure t  ; I use emacs-overlay to manage packages
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Sync/personal/RoamNotes")
  (org-roam-completion-everywhere t)
  ;; use built in sqlite in Emacs 29+
  (setq org-roam-database-connector 'sqlite-builtin)
  :bind
  (
   ("C-c r l" . org-roam-buffer-toggle)
   ("C-c r f" . org-roam-node-find)
   ("C-c r i" . org-roam-node-insert)
   :map org-mode-map
   ("C-M-i"    . completion-at-point)
   )

  :config
  (org-roam-setup)
)

(use-package org-chef
  :ensure t)

(use-package org-books
  :ensure t)
(setq org-books-file org-book-path)
;; (setq org-capture-templates
;;    '(("bl" "Book log" item (function org-books-visit-book-log)
;;        "- %U %?" :prepend t)))

(use-package yasnippet
    :ensure t
    :config
      (use-package yasnippet-snippets
	:ensure t)
      (yas-reload-all))
(yas-global-mode t)

(use-package flycheck
  :ensure t)

(use-package company
  :ensure t)
 (setq company-idle-delay 0)
 (setq company-minimum-prefix-length 3) ;)

(defun zb/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun zb/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(global-set-key (kbd "C-x 2") 'zb/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'zb/split-window-right-and-switch)

(defun my/dashboard-banner ()
  """Set a dashboard banner including information on package
     initialization time and garbage collections."""
  (setq dashboard-banner-logo-title
	  (format "Emacs ready in %.2f seconds with %d garbage collections."
		  (float-time (time-subtract after-init-time before-init-time)) gcs-done)))

(use-package dashboard
  :init
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  (add-hook 'dashboard-mode-hook 'my/dashboard-banner)
  :config
  (setq dashboard-startup-banner 'logo)
  (dashboard-setup-startup-hook))

;; Silence compiler warnings as they can be pretty disruptive
(setq comp-async-report-warnings-errors nil)

(use-package lsp-mode
    :ensure t
;    :if my-laptop-p
    :config
    (add-hook 'python-mode-hook #'lsp))

(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package lsp-mode
    :if my-laptop-p
    :ensure t
    :hook
    ((python-mode . lsp)))

  (use-package lsp-ui
    :if my-laptop-p
    :ensure t
    :commands lsp-ui-mode)


(use-package lsp-mode
  :if my-laptop-p
  :ensure t
  :config
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)))
  :hook
  ((python-mode . lsp)))

(use-package blacken
  :ensure t
  :hook
  ((python-mode . lsp)))

(use-package treemacs
  :ensure t)
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(setq-default TeX-engine 'xetex) ;;change the default engine to XeTeX
;; engines - xelatex, pdflatex, default
  (setq-default TeX-PDF-mode t)
;;  (latex-preview-pane-enable)`

(use-package which-key
  :ensure t)
(setq which-key-mode t)

(use-package ini-mode
  :ensure t)
(setq which-key-mode t)
