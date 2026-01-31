;;; -*- lexical-binding: t -*-
(require 'tramp)
(require 'eglot)
(require 'jai-mode)

(add-hook 'after-init-hook 'recentf-open-files)

(add-hook 'c++-mode-hook '(lambda ()
                            (setq display-fill-column-indicator-column 101)
                            (setq c-basic-offset 4)
                            (setq indent-tabs-mode nil)
                            (dtrt-indent-mode)))

(add-hook 'c-mode-hook '(lambda ()
                          (setq display-fill-column-indicator-column 81)
                          (setq c-basic-offset 4)
                          (setq indent-tabs-mode nil)
                          (dtrt-indent-mode)))

(add-hook 'java-mode-hook '(lambda ()
                             (setq display-fill-column-indicator-column 121)
                             (setq c-basic-offset 4)
                             (setq indent-tabs-mode nil)))

(add-hook 'go-mode-hook '(lambda ()
                           (setq display-fill-column-indicator-column nil)))

(add-hook 'org-mode-hook '(lambda ()
                            (setq cursor-type 'bar)))

(add-hook 'eldoc-mode-hook 'eldoc-box-hover-mode)

(add-hook 'LaTeX-mode-hook '(lambda ()
                              (prettify-symbols-mode 1)))

(add-hook 'jai-mode-hook '(lambda ()
                            (setq display-fill-column-indicator-column nil)))

(add-hook 'lisp-mode-hook '(lambda ()
                             (slime-mode)))

(add-hook 'tuareg-mode-hook '(lambda ()
                               (merlin-mode)))

(add-hook 'jsonnet-mode-hook '(lambda ()
                                (setq jsonnet-indent-level 4)))

(with-eval-after-load 'tramp
  (with-eval-after-load 'compile
    (remove-hook 'compilation-mode-hook #'tramp-compile-disable-ssh-controlmaster-options)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(swift-mode . ("xcrun" "sourcekit-lsp")))
  (add-to-list 'eglot-server-programs
               '(python-mode . ("basedpyright-langserver" "--stdio"))))
