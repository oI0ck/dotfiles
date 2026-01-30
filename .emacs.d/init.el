(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/local-themes")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/local-packages"))
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

(setq inhibit-startup-screen t
      make-backup-files nil
      default-directory "~/"
      create-lockfiles nil
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      completion-cycle-threshold 3
      gc-cons-threshold 100000000
      erc-nick "nickiminjaj"
      erc-user-full-name "cocateh"
      ring-bell-function 'ignore
      projectile-indexing-method 'alien
      inferior-lisp-program "sbcl"
      custom-file "~/.emacs.d/custom.el"
      eglot-ignored-server-capabilities '(:inlayHintProvider))

(setq-default comment-style 'extra-line
              display-fill-column-indicator-column 81
              indent-tabs-mode nil
              c-basic-offset 4
              truncate-lines t)

(set-language-environment "UTF-8")

;; Basic stuff loading
;; Order of loading these should be preserved, they depend on eachother
(load "~/.emacs.d/local-settings/bootstrap.el")

(require 'theme-switcher)
(require 'jai-mode)
(require 'eglot)
(require 'dired)

(load "~/.emacs.d/local-settings/keys.el")
(load "~/.emacs.d/local-settings/modes.el")
(load "~/.emacs.d/local-settings/hooks.el")
(load "~/.emacs.d/local-settings/window-settings.el")

(cond ((eq system-type 'darwin) (load "~/.emacs.d/local-settings/mac.el"))
      ((eq system-type 'windows-nt) (load "~/.emacs.d/local-settings/windows.el"))
      ((eq system-type 'gnu/linux) (load "~/.emacs.d/local-settings/linux.el")))

;; Per-system configuration
(if (file-exists-p "~/.emacs.d/per-system.el")
    (load "~/.emacs.d/per-system.el"))

;; SLIME configuration
(if (and (not (eq system-type 'windows-nt))
         (file-exists-p "~/.local/share/quicklisp/slime-helper.el"))
      (load "~/.local/share/quicklisp/slime-helper.el"))

;; Custom file
(load "~/.emacs.d/custom.el")
