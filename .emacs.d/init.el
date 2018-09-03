;;; package --- summary
;;; Commentary:
;;; Code:
(require 'package)
(mapc (lambda(p) (push p package-archives))
      '(("melpa" . "http://melpa.milkbox.net/packages/")
	("org" . "https://orgmode.org/elpa/")))

;; ("marmalade" . "http://marmalade-repo.org/packages/") ;; In case you want to check out marmalade packages

(package-initialize)
(package-refresh-contents)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "f1b5a9c45405b433f766ffe1e4c6b211842b086da9975d110bfcb6851591bfc4" "57f95012730e3a03ebddb7f2925861ade87f53d5bbb255398357731a7b1ac0e0" default)))
 '(package-selected-packages
   (quote
    (org-gcal helm-mode-manager ace-window evil-org evil-surround evil-nerd-commenter powerline-evil magit evil-leader evil-escape evil-ediff org-evil bind-key evil-easymotion tabbar evil-tabs interleave atom-one-dark-theme helm-R helm slime origami ranger elfeed-goodies elfeed-org elfeed folding auto-complete flycheck org ess evil-collection evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(use-package org)
(org-babel-load-file "~/.emacs.d/config.org")
