;;; -*- lexical-binding: t -*-
(require 'dired)
(require 'eglot)

;; Disabled
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Global keybinds
(global-set-key (kbd "C-c C-SPC") 'mc/edit-lines)
(global-set-key (kbd "M-P") 'projectile-find-file)
(global-set-key (kbd "M-S") 'rg)
(global-set-key (kbd "C-c '") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)
(global-set-key (kbd "M-<return>") 'eglot-code-actions)
(global-set-key (kbd "M-o") 'ace-window)

;; Eglot
(define-key eglot-mode-map [C-down-mouse-1] 'xref-find-definitions-at-mouse)
(define-key eglot-mode-map (kbd "M-.") 'eglot-find-implementation)

;; dired
(define-key dired-mode-map [mouse-2] 'dired-mouse-find-file)
