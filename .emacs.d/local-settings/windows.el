;;; -*- lexical-binding: t -*-
(setq initial-frame-alist '((top . 40) (left . 10) (width . 120) (height . 50))
      default-frame-alist '((top . 40) (left . 10) (width . 120) (height . 50))
      split-height-threshold nil
      split-width-threshold 0
      default-day-theme 'standard-light
      default-night-theme 'standard-dark)

(load-theme 'wheatgrass t)

(set-face-attribute 'default nil :font "Consolas" :height 110)
