;;; -*- lexical-binding: t -*-
(exec-path-from-shell-initialize)

(ignore-errors
  (require 'ansi-color)
  (defun local-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'local-colorize-compilation-buffer))

(set-face-attribute 'default nil :font "Ubuntu Mono:size=12" :weight 'medium)
(load-theme 'wheatgrass t)
