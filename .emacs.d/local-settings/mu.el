;;; -*- lexical-binding: t -*-
;;;
;;; In order for this to work, mu with mu4e must be installed and
;;; .mbsyncrc must be configured and put in ~/.emacs.d/

;; This is a more-or-less standard mu4e installation path
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e/")
(require 'mu4e)

(setq send-mail-function 'smtpmail-send-it
      ;; smtpmail-smtp-server "smtp.gmail.com"
      ;; smtpmail-smtp-service 587
      ;; smtpmail-stream-type 'starttls
      mu4e-drafts-folder "/Drafts"
      mu4e-sent-folder "/Sent"
      mu4e-trash-folder "/Trash"
      ;; mu4e-get-mail-command "mbsync --config ~/.emacs.d/.mbsyncrc gmail"
      mu4e-html2text-command "w3e -T text/html"
      mu4e-update-interval 300
      mu4e-headers-auto-update t
      mu4e-view-show-images t
      mu4e-compose-signature-auto-include nil
      mu4e-use-fancy-chars t)
