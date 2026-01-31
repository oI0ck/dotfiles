;;; -*- lexical-binding: t -*-
(require 'magit)
(setq switch-to-buffer-obey-display-actions t)
(setq magit-display-buffer-function #'display-buffer)

(add-to-list 'display-buffer-alist
             `(,(rx (| "*xref*"
                       "*grep*"
                       "*rg*"
                       "*Occur*"
                       "*Man*"))
               display-buffer-reuse-window
               (inhibit-same-window . nil)))


(add-to-list 'display-buffer-alist
             '("\\*rg\\*"
               (display-buffer-reuse-window
                display-buffer-in-direction)
               (window . root)
               (window-height . 0.15)
               (direction . down)))

(add-to-list 'display-buffer-alist
             '("\\*Compliation\\*" display-buffer-reuse-window))

(add-to-list 'display-buffer-alist
             '("\\*compilation\\*" display-buffer-no-window (allow-no-window . t)))

(add-to-list 'display-buffer-alist
             `((derived-mode . magit-mode)
               (display-buffer-reuse-mode-window
                display-buffer-in-direction)
               (mode magit-mode)
               (window . root)
               (window-width . 0.15)
               (direction . right)))
