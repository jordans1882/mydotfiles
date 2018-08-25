(deftheme airline-one-dark
  "Created 2018-08-24.")

(custom-theme-set-faces
 'airline-one-dark
 '(airline-normal-outer ((t (:foreground "#1c1c1c" :background "#5fd787"))))
 '(airline-normal-inner ((t (:foreground "#b2b2b2" :background "#303030"))))
 '(airline-normal-center ((t (:foreground "#5fd787" :background "#262626"))))
 '(airline-insert-outer ((t (:foreground "#242322" :background "#00afff"))))
 '(airline-insert-inner ((t (:foreground "#75d7d8" :background "#303030"))))
 '(airline-insert-center ((t (:foreground "#00afff" :background "#262626"))))
 '(airline-visual-outer ((t (:foreground "#1c1c1c" :background "#d75fd7"))))
 '(airline-visual-inner ((t (:foreground "#dbc570" :background "#303030"))))
 '(airline-visual-center ((t (:foreground "#d75fd7" :background "#262626"))))
 '(airline-replace-outer ((t (:foreground "#75d7d8" :background "#005154"))))
 '(airline-replace-inner ((t (:foreground "#ff5fd7" :background "#242322"))))
 '(airline-replace-center ((t (:foreground "#e2e2e2" :background "#4a4a4a"))))
 '(airline-emacs-outer ((t (:foreground "#d7d7ff" :background "#5f00af"))))
 '(airline-emacs-inner ((t (:foreground "#ff5fd7" :background "#242322"))))
 '(airline-emacs-center ((t (:foreground "#e2e2e2" :background "#4a4a4a"))))
 '(powerline-inactive1 ((t (:foreground "#b2b2b2" :background "#4a4a4a"))))
 '(powerline-inactive2 ((t (:foreground "#b2b2b2" :background "#4a4a4a"))))
 '(airline-inactive3 ((t (:foreground "#b2b2b2" :background "#4a4a4a"))))
 '(mode-line ((t (:foreground "#e2e2e2" :background "#4a4a4a" :box nil :underline nil :overline nil))))
 '(mode-line-inactive ((t (:foreground "#b2b2b2" :background "#4a4a4a" :box nil :underline nil :overline nil))))
 '(mode-line-buffer-id ((t (:foreground "#e2e2e2" :background "#4f3598" :box nil :underline nil :overline nil))))
 '(minibuffer-prompt ((t (:foreground "#e2e2e2" :background "#4f3598" :box nil)))))

(provide-theme 'airline-one-dark)
