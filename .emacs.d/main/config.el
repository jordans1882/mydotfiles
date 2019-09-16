;; Disable spash screen
(setq inhibit-splash-screen t)

;; Set fold path
(add-to-list 'load-path "~/.emacs.d/load-folder/")

;; Toggle menubar
(global-set-key [f9] 'toggle-menu-bar-mode-from-frame)

;; Remove tool-bar by default
(tool-bar-mode -1)

;; Vim style folding
;; (autoload 'folding-mode          "folding" "Folding mode" t)
;; (autoload 'turn-off-folding-mode "folding" "Folding mode" t)
;; (autoload 'turn-on-folding-mode  "folding" "Folding mode" t)

;; Load path to origami
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/origami-20180101.753/origami.el"))

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/icicles-el-files/icicles.el"))
;; (require 'icicles)

;; Resize windows keybindings (none of this seems to work... :()
(global-set-key (kbd "M-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-C-<up>") 'shrink-window)
(global-set-key (kbd "M-C-<down>") 'enlarge-window)

(global-set-key (kbd "M-p") 'ace-window)

;; (load-theme 'atom-one-dark t)

(use-package airline-themes)
;;(load-theme 'airline-dark t)
;; (load-theme 'airline-one-dark t)

(use-package auto-complete)
(ac-config-default)

(use-package elfeed)
(global-set-key (kbd "C-x w") 'elfeed)
(use-package elfeed-org)
(use-package elfeed-goodies)
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org"))
(elfeed-goodies/setup)

(use-package ein)

(use-package ess)
;; (use-package 'ess-site)
;; (use-package 'ess-smart-underscore)

;;(global-set-key (kbd "C-c <C-return>") 'ess-eval-region-or-line-and-step)

;; (setq evil-want-integration nil)
(setq evil-want-integration t)
(use-package evil)
(evil-mode 1)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(define-key evil-normal-state-map [<C-return>] 'ess-eval-region-or-line-and-step)

(evilem-default-keybindings "SPC")

(global-set-key (kbd "C-c C-g") 'evil-escape)

(use-package evil-tabs)
(global-evil-tabs-mode t)

(use-package evil-collection)
(evil-collection-init)

;; (setq folding-default-keys-function
;;      'folding-bind-backward-compatible-keys)

(if (load "folding" 'nomessage 'noerror)
    (folding-mode-add-find-file-hook))

(use-package evil-collection)
(when (require `evil-collection nil t)
  (evil-collection-init))

(use-package haskell-mode)
;;(haskell-program-name ghci)

(use-package helm)
(global-set-key (kbd "M-x") 'helm-M-x)

;; (use-package flymake)
;; (add-hook 'after-init-hook #'global-flycheck-mode)

(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package lorem-ipsum)
(lorem-ipsum-use-default-bindings)

(use-package origami)
;;origami https://github.com/gregsexton/origami.el
;; (global-origami-mode 1)

;; (defun nin-origami-toggle-node ()
;;   (interactive)
;;   (if (equal major-mode 'org-mode)
;;       (org-cycle)
;;     (save-excursion ;; leave point where it is
;;       (goto-char (point-at-eol))             ;; then go to the end of line
;;       (origami-toggle-node (current-buffer) (point)))))                 ;; and try to fold

;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (setq-local origami-fold-style 'triple-braces)
;;             (origami-mode)
;;             (origami-close-all-nodes (current-buffer))))
;; (evil-define-key 'normal prog-mode-map (kbd "TAB") 'nin-origami-toggle-node)
;;
;; (define-key evil-normal-state-map "za" 'origami-forward-toggle-node)
;; (define-key evil-normal-state-map "zR" 'origami-close-all-nodes)
;; (define-key evil-normal-state-map "zM" 'origami-open-all-nodes)
;; (define-key evil-normal-state-map "zr" 'origami-close-node-recursively)
;; (define-key evil-normal-state-map "zm" 'origami-open-node-recursively)
;; (define-key evil-normal-state-map "zo" 'origami-show-node)
;; (define-key evil-normal-state-map "zc" 'origami-close-node)
;; (define-key evil-normal-state-map "zj" 'origami-forward-fold)
;; (define-key evil-normal-state-map "zk" 'origami-previous-fold)
;; (define-key evil-visual-state-map "zf"
;;   '(lambda ()
;;      "create fold and add comment to it"
;;      (interactive)
;;      (setq start (region-beginning))
;;      (setq end (region-end))
;;      (deactivate-mark)
;;      (and (< end start)
;;           (setq start (prog1 end (setq end start))))
;;      (goto-char start)
;;      (beginning-of-line)
;;      (indent-according-to-mode)
;;      (insert comment-start)
;;      (setq start (point))
;;      (insert "Folding" " {{{")
;;      (newline-and-indent)
;;      (goto-char end)
;;      (end-of-line)
;;      (and (not (bolp))
;;           (eq 0 (forward-line))
;;           (eobp)
;;           (insert ?\n))
;;      (indent-according-to-mode)
;;      (if (equal comment-end "")
;;          (insert comment-start " }}}")
;;        (insert comment-end "}}}"))
;;      (newline-and-indent)
;;      (goto-char start)
;;      ))

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))

(setq org-agenda-files (list "~/schedule.org"))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((python . t)
    (shell . t)
    (haskell . t)
    (octave . t)
    (R . t)))

;; (setq org-capture-templates
;;       '(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" )
;; 	 "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
;; 	("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
;; 	 "* %? %^L %^g \n%T" :prepend t)
;; 	("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
;; 	 "* %?\n%T" :prepend t)
;; 	("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
;; 	 "* TODO %?\n%u" :prepend t)
;; 	("n" "Note" entry (file+headline "~/Dropbox/orgfiles/i.org" "Note space")
;; 	 "* %?\n%u" :prepend t)
;; 	("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
;; 	 "* %?\nEntered on %U\n  %i\n  %a")
;; 	("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
;; 	 "* %?\n%i\n")))

;; (require 'org-gcal)

(require 'org-noter)

(require 'org-ref)
;; org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
;; org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")
(setq org-ref-default-bibliography '("~/bibtex/my_library.bib"))

(use-package powerline)
(powerline-default-theme)
;;(powerline-center-evil-theme)

(use-package projectile)
(projectile-mode 1)
(setq projectile-project-search-path '("~/projects/" "~/work/" "~/.emacs.d/main/"))

(use-package helm-projectile)
(helm-projectile-on)

(use-package pyvenv)
(setenv "WORKON_HOME" "/home/jordan/.conda/envs")
(pyvenv-mode 1)

(use-package ranger)
(ranger-override-dired-mode t)

(require 'bind-key)
(bind-key "C-c C-c" 'ess-eval-region-or-line-and-step)

(require 'which-key)
(which-key-mode)

;; General Setup

;; Create user keymap (personal leader)
(defvar my-leader-map (make-sparse-keymap)
  "Keymap for \"leader key\" shortcuts.")

;; binding "," to the keymap
(define-key evil-normal-state-map "," my-leader-map)

;; binding ",a" for applications
(define-key my-leader-map "ae" 'eshell)

;; binding ",e" for emacs
(defun edit-config ()
  (interactive)
  (find-file "~/.emacs.d/main/config.org"))

(defun reload-config ()
  (interactive)
  (load-file "~/.emacs.d/main/init.el"))

(define-key my-leader-map "ee" 'edit-config)
(define-key my-leader-map "er" 'reload-config)

;; binding ",h" for helm menu
(define-key my-leader-map "hb" 'helm-buffers-list)
(define-key my-leader-map "hm" 'helm-M-x)
(define-key my-leader-map "hf" 'helm-find-files)

;; binding ",f" for files
(define-key my-leader-map "ff" 'helm-find-files)

;; binding ",b" for buffers
(define-key my-leader-map "bf" 'helm-buffers-list)
(define-key my-leader-map "bl" 'next-buffer)
(define-key my-leader-map "bh" 'previous-buffer)
(define-key my-leader-map "bn" 'evil-buffer-new)

;; binding ",p" for projects
(define-key my-leader-map "po" 'projectile-switch-project)
(define-key my-leader-map "pf" 'projectile-find-file)
(define-key my-leader-map "pr" 'projectile-ripgrep)

;; binding ",w" for windows
(define-key my-leader-map "wd" 'evil-window-delete)
(define-key my-leader-map "wl" 'evil-window-next)
(define-key my-leader-map "wh" 'evil-window-previous)
(define-key my-leader-map "wl" 'evil-window-next)
(define-key my-leader-map "wn" 'evil-window-new)
(define-key my-leader-map "wj" 'evil-window-down)
(define-key my-leader-map "wk" 'evil-window-up)
(define-key my-leader-map "w|" 'evil-window-vsplit)
(define-key my-leader-map "w-" 'evil-window-split)
(define-key my-leader-map "wJ" 'evil-window-decrease-height)
(define-key my-leader-map "wK" 'evil-window-increase-height)
(define-key my-leader-map "wH" 'evil-window-decrease-width)
(define-key my-leader-map "wL" 'evil-window-increase-width)

;; binding ",t" for tabs
;;(define-key my-leader-map "tn" (lambda () (interactive) ('tabnew)))

(define-key my-leader-map "td" 'elscreen-kill)
(define-key my-leader-map "tl" 'elscreen-next)
(define-key my-leader-map "th" 'elscreen-previous)
(define-key my-leader-map "tn" 'elscreen-create)
(define-key my-leader-map "tr" 'elscreen-screen-nickname)
(define-key my-leader-map "tt" 'elscreen-toggle)
(define-key my-leader-map "ts" 'elscreen-swap)

;; q for quit... :)
(define-key evil-normal-state-map (kbd "Q") 'evil-record-macro)
(define-key evil-normal-state-map (kbd "q") 'save-buffers-kill-terminal)

(set-default-font "UbuntuMono Nerd Font Mono-24")
(set-face-attribute 'default nil :font "UbuntuMono Nerd Font Mono-24" )
(set-frame-font "UbuntuMono Nerd Font Mono-24" nil t)

(define-key my-leader-map "xi" 'text-scale-increase)
(define-key my-leader-map "xd" 'text-scale-decrease)

;; (defvar my-keys-minor-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "C-i") 'some-function)
;;     map)
;;   "my-keys-minor-mode keymap.")
;;
;; (define-minor-mode my-keys-minor-mode
;;   "A minor mode so that my key settings override annoying major modes."
;;   :init-value t
;;   :lighter " my-keys")
;;
;; (my-keys-minor-mode 1)

;; {{{ Define evil-mode mappings for vim-style folding
;; (define-key evil-normal-state-map "zz" 'folding-toggle-show-hide)
;; (define-key evil-normal-state-map "zR" 'folding-whole-buffer)
;; (define-key evil-normal-state-map "zM" 'folding-open-buffer)
;; (define-key evil-normal-state-map "zr" 'folding-hide-current-subtree)
;;(defe-key evil-normal-state-map "zm" 'folding-show-current-subtree)
;;(defi-key evil-normal-state-map "zo" 'folding-show-current-entry)
;;(definkey evil-normal-state-map "zc" 'folding-hide-current-entry)
;;(defineey evil-normal-state-map "zj" 'folding-next-visible-heading)
;;(define-y evil-normal-state-map "zk" 'folding-previous-visible-heading)
;;;; (definkey evil-normal-state-map "zf" 'folding-fold-region)
;;(define-keevil-normal-state-map "zf"
;;  '(lambda
;;     "createold, exit from shifting and add comment to it"
;;     (interacve)
;;     (folding-ld-region (region-beginning) (region-end))
;;     (folding-sft-out)
;;     (folding-tole-show-hide)
;;     (evil-appendine 1)
;;     (insert " FolngComment")
;;     (evil-normal-ste)
;;     (evil-backward-RD-begin)
;;))
;;
;;(defun bss/foing-t--org ()
;;  "selective folding toge by tab: skip org-mode"
;;  (interactive)
;;  (if (ual major-mode 'o-mode)
;;      (org-cycle)
;;    (foing-toggle-show-hid
;;    ))
;;(define-key evil-norl-state-p (kbd "<tab>") 'bss/folding-not-in-org)
;;
;;(add-hook 'python-mode-hook ama () (folding-mode)))
;; }}} Define evil-mode mappings for vim-style folding

;;  (org-babel-load-file "~/.emacs.d/main/priv_config.org")
