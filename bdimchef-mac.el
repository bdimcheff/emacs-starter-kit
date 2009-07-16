(server-start)

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


;; (split-window-vertically)
;; (other-window 1)
;; (shell)                       ;; start a shell
;; (rename-buffer "shell-first") ;; rename it
;; (other-window 1)              ;; move back to first window 

;; fonts
(set-default-font "-apple-inconsolata-medium-r-normal--14-140-72-72-m-140-iso10646-1")

(toggle-fullscreen)
