(server-start)

(defun toggle-fullscreen () 
  (interactive) 
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) 
                                           nil 
                                           'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen) 

;; path setup
(defun bdimchef-add-to-beginning-of-path (arg)
  (when (stringp arg)
    (setq arg (split-string arg ":"))
    (message "PATH=%s" (getenv "PATH"))
    )
  (when (listp arg)
    (dolist (path (prune-directory-list arg))
      (bdimchef-add-to-beginning-of-env "PATH" path)
      ;;(message path)
      (add-to-list 'exec-path path)
      ;;(setq exec-path (append path exec-path))
      )
    (message "PATH=%s" (getenv "PATH"))
    )
  )

(defun bdimchef-add-to-beginning-of-env (key value)
  "Document forthcoming..."
  (let ((env (getenv key)))
    (if (and env (not (equal env "")))
        (if (not (member value (split-string env ":")))
            (message (concat value ":" env))
            (setenv key (concat value ":" env)))
      (setenv key value) )
    ))

(defun bdimchef-add-paths (pathstring)
  (let ((newpaths (split-string pathstring ":")))
    (setq exec-path (append newpaths exec-path))
    (setenv "PATH" (concat pathstring ":" (getenv "PATH")))
 ))

(bdimchef-add-paths "/usr/local/erlware/bin:/opt/local/lib/mysql5/bin:/opt/local/lib/postgresql82/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin")
;;(setq exec-path (append  '("/usr/local/erlware/bin:/opt/local/lib/mysql5/bin:/opt/local/lib/postgresql82/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin") exec-path))
;;(setenv "PATH" (concat "/usr/local/erlware/bin:/opt/local/lib/mysql5/bin:/opt/local/lib/postgresql82/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin" ":" (getenv "PATH"))) 


;; window positioning
(split-window-horizontally)   ;; want two windows at startup 
(other-window 1)              ;; move to other window
(split-window-vertically)
(other-window 1)
(shell)                       ;; start a shell
(rename-buffer "shell-first") ;; rename it
(other-window 1)              ;; move back to first window 

(toggle-fullscreen)