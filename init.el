;; Unable tool bar
(tool-bar-mode -1)

;; Unable scroll bar
(scroll-bar-mode -1)

;; Show line number
(global-linum-mode 1)

;; Set cursor type to bar
(setq-default cursor-type 'bar)

;; Unable welcome buffer
(setq inhibit-splash-screen 1)

;; Set font size
(set-face-attribute 'default nil :height 130)

;; Short key for open emacs config file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f1>") 'open-init-file)

(global-auto-revert-mode t)



;; Disable backup file
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Hightlight source code in org-mode
(require 'org)
(setq org-src-fontify-natively t)

;; Short key for open recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-memu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Add delete selection mode
(delete-selection-mode t)

;; Open with full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; Show match patterns
(add-hook 'emacs-lisp-mode-hook 'show-parent-mode)

(electric-pair-mode)

;; Make source code fancy in the org file
(require 'org)
(setq org-src-fontify-natively t)

;; Hightlight current line
(global-hl-line-mode t)

;; Set ELPA package source
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

(require 'cl)

;; Add Packages
 (defvar my/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		hungry-delete
		swiper
		counsel
		smartparens
		;; --- Major Mode ---
		js2-mode
		;; --- Minor Mode ---
		nodejs-repl
		exec-path-from-shell
		;; --- Themes ---
		monokai-theme
		;; solarized-theme
		) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;; Enable Monokai theme
;;(load-theme 'monokai 1)

;; Set js2 major mode for *.js file
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; nodejs-repl settings
(require 'nodejs-repl)

(add-hook 'js-mode-hook
          (lambda ()
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
            (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

(global-auto-revert-mode t)

;; Set hungry delete
(require 'hungry-delete)
(global-hungry-delete-mode)

;; Set counsel
(ivy-mode 1)
(setq ivy-use-virtual-buffers 1)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c C-f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
