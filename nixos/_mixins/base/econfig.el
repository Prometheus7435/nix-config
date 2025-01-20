;; The default is 800 kilobytes.  Measured in bytes.
  (setq gc-cons-threshold (* 511 1024 1024))
;  (setq gc-cons-percentage 0.9)
;  (run-with-idle-timer 5 t #'garbage-collect)
  (setq garbage-collection-messages nil)

(require 'package)
;  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq package-archives '(
		   ("melpa" . "https://melpa.org/packages/")
     		     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			     )
	  )
(package-initialize)

(setq native-comp-async-report-warnings-errors nil)

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

(setq comp-async-report-warnings-errors nil)

(setq user-full-name "Zach Bombay"
	user-mail-address "zacharybombay@gmail.com")
;	calendar-latitude 0.0
;	calendar-longitude 0.0
;	calendar-location-name "")

(use-package yasnippet
    :ensure t
    :config
      (use-package yasnippet-snippets
	:ensure t)
      (yas-reload-all))
(yas-global-mode t)

(defun zb/visit-emacs-config ()
    (interactive)
;    (find-file "~/Zero/nixos/_mixins/base/emacs-config.org")
  (find-file (concat nix_folder "nixos/_mixins/base/econfig.org")))
;    )
  (global-set-key (kbd "C-c e") 'zb/visit-emacs-config)

(defun zb/kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'zb/kill-current-buffer)

(setq electric-pair-pairs '(
			     (?\{ . ?\})
			     (?\( . ?\))
			     (?\[ . ?\])
			     (?\" . ?\")
			     ))
(setq electric-pair-inhibit-predicate (lambda (c) (char-equal c ?<)))

(electric-pair-mode t)
(show-paren-mode 1)

;;   (cond
;;      ((string-equal system-type "windows-nt")
;; 	(defvar sync_folder "C:/Users/zacha/sync/"))
;;      (
;; 	(if my-laptop-p (string-equal system-type "gnu/linux")
;; 	 (defvar sync_folder "~/Sync/"))
;; )
;;      )
(defvar nix_folder "~/Zero/nix-config/")
(defvar sync_folder "~/Nextcloud/org")

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

(load-theme 'monokai t)
;  (load-theme 'modus-vivendi-deuteranopia t)

(set-face-attribute 'default nil :font "Source Code Pro" :height 105)
(setq zb/default-font-size 12)
(setq zb/current-font-size zb/default-font-size)

(use-package org-fancy-priorities
   :ensure t
   :init
;    (require 'unicode-fonts)
   (unicode-fonts-setup)
   )

(fset 'yes-or-no-p 'y-or-n-p)

(setq package-pinned-packages '((org . "built-in")))

(use-package org-bullets
:ensure t
:hook (org-mode . org-bullets-mode)
 )

(use-package org-fancy-priorities
  :diminish
  :ensure t
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("🅰" "🅱" "🅲" "🅳" "🅴")))

(setq-default TeX-engine 'pdflatex)
    (setq-default TeX-PDF-mode t)
;    (latex-preview-pane-enable)`
