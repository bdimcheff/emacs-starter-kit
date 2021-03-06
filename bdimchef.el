;; DESCRIPTION: bdimchef settings

(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

;; Snippets
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(setq yas/root-directory "~/.emacs.d/vendor/yasnippet/snippets")
(yas/load-directory yas/root-directory)
(yas/global-mode)

;;fix problem with ruby-electric and snippet expansion
(add-hook 'ruby-mode-hook (lambda () (define-key ruby-mode-map (kbd "TAB") nil)))

;; ruby mode
(add-hook 'ruby-mode-hook 'esk-paredit-nonlisp)
(eval-after-load 'ruby-mode
  '(progn (define-key ruby-mode-map "{" 'paredit-open-curly)
          (define-key ruby-mode-map "}" 'paredit-close-curly)))

;; Commands
;;(require 'unbound)

;; Ack
(add-to-list 'load-path "~/.emacs.d/vendor/ack.el")
(require 'ack)


;; Keyboard
;;(require 'mac-bindings)

;; Minor Modes
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

(require 'linum)
(global-linum-mode 1)

;; (add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))

;; Major Modes
(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)

(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;; Cucumber
(add-to-list 'load-path "~/.emacs.d/vendor/cucumber")
;;(load "cucumber-mode")
(require 'feature-mode)


;; Javascript
(setq espresso-indent-level 4)

;; load bundle snippets
(yas/load-directory "~/.emacs.d/vendor/cucumber/snippets")

(add-to-list 'auto-mode-alist '("\\.feature" . feature-mode))

(require 'erlang-start)

;;(load "haskell-mode/haskell-site-file")

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode))


;; Python
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; Font
;;(set-face-font 'default "-apple-inconsolata-medium-r-normal--20-0-72-72-m-0-iso10646-1")

;; Color Themes
(add-to-list 'load-path (concat dotfiles-dir "/vendor/color-theme"))
(require 'color-theme)
(color-theme-initialize)
(load-file (concat dotfiles-dir "/vendor/color-theme-twilight.el"))

;;(color-theme-charcoal-black)
;;(color-theme-gray30)
(color-theme-twilight)
;;(color-theme-gnome)

;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(prefer-coding-system 'utf-8)


;; line duplication
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )

;; global keys
(global-set-key (kbd "C-c C-d") 'duplicate-line)
(global-set-key "\C-m" 'newline-and-indent)

;; screen layout
(defun toggle-fullscreen () 
  (interactive) 
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) 
                                           nil 
                                         'fullboth)))

;; window positioning
(split-window-horizontally)   ;; want two windows at startup 
(other-window 1)              ;; move to other window

(if (or (eq window-system 'mac) (eq window-system 'ns))
    (load-file (concat dotfiles-dir "bdimchef-mac.el"))
)

(if (eq window-system 'x)
    (load-file (concat dotfiles-dir "bdimchef-x.el"))
)

(provide 'bdimchef)

