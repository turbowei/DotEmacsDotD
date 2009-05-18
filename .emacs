;;; .emacs

(load "~/.emacs.d/dired+.el")
(toggle-dired-find-file-reuse-dir 1)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;;(require 'dired)
;; (defun dired-follow-file ()
;; ;  "In dired, visit the file or directory on this line.
;; ;If a directory is on the current line, replace the current
;; ;dired buffer with one containing the contents of the directory.
;; ;Otherwise, invoke `dired-find-file' on the file."
;;   (interactive)
;;   (let ((filenamegg (dired-get-filename)))
;;     ;; if the file is a directory, replace the buffer with the
;;     ;;  directories contents
;;     (if (file-directory-p filename)
;;         (find-alternate-file filename)
;;       ;; otherwise simply perform a normal `dired-find-file'
;; 	  (dired-find-file))))

;; (define-key dired-mode-map [(return)] 'dired-follow-file)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/icicles")
(add-to-list 'load-path "~/.emacs.d/apel")
(add-to-list 'load-path "~/.emacs.d/predictive")

(add-to-list 'load-path "~/.emacs.d/ecb")

;; Load CEDET
;; See cedet/common/cedet.info for configuration details.
(load-file "~/.emacs.d/cedet/common/cedet.el")
(require 'semantic-load)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
(global-srecode-minor-mode 1)

(require 'ecb)

; Highlight-parentheses
;; (add-to-list 'load-path "~/.emacs.d/elpa/highlight-parentheses-1.0.1")
(require 'highlight-parentheses)
(highlight-parentheses-mode t)

; newsticker
;; (add-to-list 'load-path "~/.emacs.d/elpa/newsticker-1.10")
;; (require 'newsticker)

; dired-isearch
;; (add-to-list 'load-path "~/.emacs.d/elpa/dired-isearch-0.3/")
(require 'dired-isearch)

;; (require 'xcscope)

(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)
(global-set-key (kbd "C-c i") 'indent-region)

;; my eclipse CTRL+ALT+G replacement
(defun grep-selected (start end)
 (interactive "r")
 (grep (concat "grep -nH -e "
			   (buffer-substring start end)
			   " * .*")))
(global-set-key (kbd "C-c g") 'grep-selected)

(require 'tabbar)
(tabbar-mode t)

(setq tabbar-buffer-groups-function
	  (lambda (b) (list "All Buffers")))
(setq tabbar-buffer-list-function
	  (lambda ()
		(remove-if
		 (lambda(buffer)
		   (find (aref (buffer-name buffer) 0) " *"))
		 (buffer-list))))

(global-set-key (kbd "C-<tab>") 'tabbar-forward)
(global-set-key (kbd "C-S-<tab>") 'tabbar-backward)


(require 'erc)
(require 'erc-tab)

(require 'mew)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
 '(browse-url-firefox-program "firefox")
 '(c-basic-offset 8)
 '(c-default-style (quote ((c-mode . "java") (c++-mode . "java") (java-mode . "java"))))
 '(c-electric-pound-behavior (quote (alignleft)))
 '(c-tab-always-indent nil)
 '(canlock-password "a4fcf8628282e0b9a817b3f0366f71878c8bca3f")
 '(case-fold-search nil)
 '(column-number-mode t)
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(display-time-day-and-date t)
 '(ecb-excluded-directories-regexps nil)
 '(ecb-layout-name "left3")
 '(ecb-layout-window-sizes (quote (("left3" (0.26180257510729615 . 0.26785714285714285) (0.26180257510729615 . 0.3392857142857143) (0.26180257510729615 . 0.375)) ("left10" (0.32857142857142857 . 0.717391304347826) (0.14285714285714285 . 0.2608695652173913) (0.18571428571428572 . 0.2608695652173913)))))
 '(ecb-options-version "2.33")
 '(ecb-select-edit-window-on-redraw nil)
 '(erc-autojoin-channels-alist (quote (("irc.freenode.net" "#emacs") ("irc.gamesurge.net" "#elitistjerks"))))
 '(erc-autojoin-mode t)
 '(erc-away-nickname "hubar_AWAY")
 '(erc-current-nick-highlight-type (quote nick))
 '(erc-enable-logging t)
 '(erc-keywords (quote ("\\bhubar\\b")))
 '(erc-log-mode t)
 '(erc-modules (quote (autojoin button completion identd irccontrols match menu netsplit noncommands notify readonly replace ring scrolltobottom services smiley spelling track truncate autoaway autojoin button fill irccontrols match menu netsplit noncommands readonly ring scrolltobottom smiley stamp spelling track)))
 '(erc-nick (quote ("hubar")))
 '(erc-nick-uniquifier "_")
 '(erc-nickserv-identify-mode (quote autodetect))
 '(erc-prompt-for-password nil)
 '(erc-server "irc.freenode.net")
 '(erc-services-mode t)
 '(erc-tab-mode t)
 '(erc-track-exclude-types (quote ("JOIN" "PART" "QUIT" "NICK" "MODE")))
 '(erc-track-faces-priority-list (quote (erc-current-nick-face erc-keyword-face)))
 '(erc-track-priority-faces-only (quote all))
 '(erc-track-use-faces t)
 '(eshell-term-name "xterm")
 '(font-lock-mode t t (font-lock))
 '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
 '(global-semantic-highlight-edits-mode nil nil (semantic-util-modes))
 '(global-semantic-highlight-func-mode nil nil (semantic-util-modes))
 '(global-semantic-idle-completions-mode t nil (semantic-idle))
 '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
 '(global-semantic-idle-summary-mode t nil (semantic-idle))
 '(global-semantic-mru-bookmark-mode t nil (semantic-util-modes))
 '(global-semantic-show-parser-state-mode nil nil (semantic-util-modes))
 '(global-semantic-show-unmatched-syntax-mode nil nil (semantic-util-modes))
 '(global-semantic-stickyfunc-mode t nil (semantic-util-modes))
 '(global-senator-minor-mode t nil (senator))
 '(make-backup-files t)
 '(semanticdb-global-mode t nil (semanticdb))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 20) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (set-background-color "black"))))
 '(tab-width 8)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tramp-terminal-type "xterm")
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(use-file-dialog nil)
 '(version-control t)
 '(which-function-mode t))

;; -adobe-courier-medium-r-normal--12-120-75-75-m-70-iso8859-1
;; (setq my-font "-Adobe-Courier-Medium-R-Normal--12-120-75-75-M-70-ISO8859-1")
(setq my-font "-unknown-Liberation Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")

;; (setq my-font "-B&H-LucidaTypewriter-normal-normal-normal-*-12-*-*-*-m-*-iso10646-1")
;;(setq my-font "-xos4-terminus-medium-r-normal--14-*-72-72-c-80-iso8859-1")

(set-frame-font my-font)
(add-hook 'after-make-frame-functions
	  (lambda (cur-frame)
	    (modify-frame-parameters cur-frame
				     (list (cons 'font my-font)))))

(defun c-reformat-buffer()
  (interactive)
  (save-buffer)
  (setq sh-indent-command (concat

;; --blank-lines-after-procedures
;; --blank-lines-before-block-comments
;; --brace-indent 0
;; --braces-after-if-line
;; --braces-after-struct-decl-line
;; --break-after-boolean-operator
;; --case-brace-indentation 0
;; --case-indentation 0
;; --continue-at-parentheses
;; --dont-break-procedure-type
;; --dont-cuddle-do-while
;; --dont-cuddle-else
;; --dont-space-special-semicolon
;; --format-all-comments
;; --honour-newlines
;; --indent-level 8
;; --leave-optional-blank-lines
;; --line-length 80
;; --no-space-after-function-call-names
;; --no-space-after-parentheses
;; --no-tabs
;; --space-after-cast
;; --space-after-for
;; --space-after-if
;; --space-after-while
;; --struct-brace-indentation 0
						   "indent -st -bad --blank-lines-after-procedures "
						   "-bli0 -i8 -l78 -ncs -npcs -ut -ppi2 -npsl -fca -cdb "
						   "-lc78 -fc1 -cli0 -bap -sob -bbo -bls -nhnl "
						   "-ncdw -nce -sc --continue-at-parentheses "
						   buffer-file-name
						   )
		)
  (mark-whole-buffer)
  (universal-argument)
  (shell-command-on-region
   (point-min)
   (point-max)
   sh-indent-command
   (buffer-name)
   )
  (save-buffer)
  )


(defun my-c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'case-label 0)
  ;; other customizations can go here
  (font-lock-mode t)
;;;   (parens-require-spaces t)
  (lambda()
	(define-key c-mode-map (kbd "<f7>") 'c-reformat-buffer)
	)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(global-font-lock-mode t)

(server-start)

(add-hook 'server-switch-hook
		  (lambda nil
			(let ((server-buf (current-buffer)))
			  (bury-buffer)
			  (switch-to-buffer-other-frame server-buf))))

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))


(put 'upcase-region 'disabled nil)
(setq tramp-backup-directory-alist backup-directory-alist)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(define-ibuffer-sorter filename-or-dired
  "Sort the buffers by their pathname."
  (:description "filenames plus dired")
  (string-lessp
   (with-current-buffer (car a)
	 (or buffer-file-name
		 (if (eq major-mode 'dired-mode)
			 (expand-file-name dired-directory))
		 ;; so that all non pathnames are at the end
		 "~"))
   (with-current-buffer (car b)
	 (or buffer-file-name
		 (if (eq major-mode 'dired-mode)
			 (expand-file-name dired-directory))
		 ;; so that all non pathnames are at the end
		 "~"))))
(define-key ibuffer-mode-map (kbd "S-p")
  'ibuffer-do-sort-by-filename-or-dired)

(require 'breadcrumb)
;;  Another set of bindings similar to MS Visual Studio bookmark setting.
(global-set-key (kbd "C-c s")	'bc-set)
(global-set-key (kbd "C-c p")	'bc-previous)
(global-set-key (kbd "C-c n")	'bc-next)
(global-set-key (kbd "C-c l")	'bc-list)



(require 'ido)
(ido-mode t)

(require 'recentf)
;; (defun ido-choose-from-recentf ()
;;   "Use ido to select a recently opened file from the `recentf-list'."
;;   (interactive)
;;   (let ((home (expand-file-name (getenv "HOME"))))
;; 	(find-file
;; 	 (ido-completing-read "Recentf open: "
;; 						  (mapcar (lambda (path)
;; 									(replace-regexp-in-string home "~" path))
;; 								  recentf-list)
;; 						  nil t))))

;; (global-set-key [(control meta f)] 'ido-choose-from-recentf)

(require 'flymake)

(require 'pastie)

(require 'erc_nick_color)

(defun switch-to-irc ()
  "Switch to an IRC buffer, or run `erc-select'.  When called repeatedly, cycle through the buffers."
  (interactive)
  (let ((buffers (and (fboundp 'erc-buffer-list)
					  (erc-buffer-list))))
	(when (eq (current-buffer) (car buffers))
	  (bury-buffer)
	  (setq buffers (cdr buffers)))
	(if buffers
		(switch-to-buffer (car buffers))
	  (call-interactively 'erc-select))))
 
(global-set-key (kbd "C-c e") 'switch-to-irc)


(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring)

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(require 'ppindent)

;; http://www.emacswiki.org/cgi-bin/wiki/EshellControlFromOtherBuffer
(require 'eshell)

(defun my-eshell-execute-current-line ()
  "Insert text of current line in eshell and execute."
  (interactive)
  ;; (require 'eshell)
  (let ((command (buffer-substring
				  (save-excursion
					(beginning-of-line)
					(point))
				  (save-excursion
					(end-of-line)
					(point)))))
	(let ((buf (current-buffer)))
	  (unless (get-buffer eshell-buffer-name)
		(eshell))
	  (display-buffer eshell-buffer-name t)
	  (switch-to-buffer-other-window eshell-buffer-name)
	  (end-of-buffer)
	  (eshell-kill-input)
	  (insert command)
	  (eshell-send-input)
	  (end-of-buffer)
	  (switch-to-buffer-other-window buf))))

(global-set-key [f7] 'my-eshell-execute-current-line)

;; http://www.emacswiki.org/cgi-bin/wiki/EshellCompletion

(setq eshell-cmpl-compare-entry-function
	  (function
	   (lambda (left right)
		 (let ((exts completion-ignored-extensions) found)
		   (while exts
			 (if (string-match (concat "\\" (car exts) "$") right)
				 (setq found t exts nil))
			 (setq exts (cdr exts)))
		   (if found
			   nil
			 (file-newer-than-file-p left right))))))

(defadvice pcomplete (around avoid-remote-connections activate)
  (let ((file-name-handler-alist (copy-alist file-name-handler-alist)))
	(setq file-name-handler-alist
		  (delete (rassoc 'tramp-completion-file-name-handler
						  file-name-handler-alist) file-name-handler-alist))
	ad-do-it))

;; http://www.emacswiki.org/cgi-bin/wiki/EshellColor

;; (require 'ansi-color)
;; (require 'eshell)

;; (defun eshell-handle-ansi-color ()
;;   (ansi-color-apply-on-region eshell-last-output-start
;; 							  eshell-last-output-end))
;; (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)


;; (require 'dabbrev)
;; (global-set-key (kbd "C-<tab>") 'dabbrev-expand)
;; (define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; (require 'company-mode)
;; (require 'company-bundled-completions)
;; (company-install-bundled-completions-rules)
;; (company-mode t)
;; (global-set-key (kbd "C-<tab>") 'company-expand-common)

(require 'smart-tab)
(global-set-key (kbd "<tab>") 'smart-tab)
(setq smart-tab-using-hippie-expand nil)

;; (require 'predictive)
;; (defun dabbrev--wrapper (prefix maxnum)
;;   "Wrapper around `dabbrev--find-all-completions',
;;      to use as a `completion-function'."
;;   (dabbrev--reset-global-variables)
;;   (let ((completions (dabbrev--find-all-expansions prefix nil)))
;; 	(when maxnum
;; 	  (setq completions
;; 			(butlast completions (- (length completions) maxnum))))
;; 	completions))

;; (setq completion-function 'dabbrev--wrapper)

(defun my-text-mode-hook ()
  ;; my customizations for text-mode
  (longlines-mode 1))
;; (predictive-mode 1))

(add-hook 'text-mode-hook 'my-text-mode-hook)

;;; .emacs ends here

;; (setq load-home-init-file t) ; don't load init file from ~/.xemacs/init.el

(setq inhibit-splash-screen t)
(eshell)

(defun my-mark-current-word ()
  "Put point at beginning of current word, set mark at end."
  (interactive)
  (let* ((opoint (point))
		 (word (current-word))
		 (word-length (length word)))
	(if (save-excursion
		  ;; Avoid signaling error when moving beyond buffer.
		  (if (> (point-min)  (- (point) word-length))
			  (beginning-of-buffer)
			(forward-char (- (length word))))
		  (search-forward word (+ opoint (length word))
						  'noerror))
		(progn (push-mark (match-end 0) nil t)
			   (goto-char (match-beginning 0)))
	  (error "No word at point" word))))

; by Nikolaj Schumacher, 2008-10-20. Licensed under GPL.

(global-set-key (kbd "C-c m") 'my-mark-current-word)

(require 'align)

(defun align-with-spaces (beg end)
  "Align selected using only spaces for whitespace."
  (interactive "r")
  (let ((indent-tabs-mode nil))
	(align beg end)))

(require 'redo)
(global-set-key (kbd "C-c .") 'undo)
(global-set-key (kbd "C-c /") 'redo)

;; open a eshell buffer
;; if there is already one, create a new one
(global-set-key (kbd "C-c t e") (lambda () (interactive) (eshell t)))
(global-set-key (kbd "C-c t a") (lambda () (interactive) (ansi-term "/bin/bash")))


(require 'icicles)

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
;;; Takes a multi-line paragraph and makes it into a single line of text.
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
	(fill-paragraph nil)))

;; (require 'elscreen)
;; (load "elscreen" "ElScreen" t)

;; Org Mode Setting
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)


;;;
;;; Matching parentheses
;;;

(modify-syntax-entry ?{ "({" )
(modify-syntax-entry ?} ")}" )

(defun match-parenthesis (arg)
  "Match the current character according to the syntax table.

Based on the freely available match-paren.el by Kayvan Sylvan.
I merged code from goto-matching-paren-or-insert and match-it.

You can define new \"parentheses\" (matching pairs).
Example: angle brackets. Add the following to your .emacs file:

	(modify-syntax-entry ?< \"(>\" )
	(modify-syntax-entry ?> \")<\" )

You can set hot keys to perform matching with one keystroke.
Example: f6 and Control-C 6.

	(global-set-key \"\\C-c6\" 'match-parenthesis)
	(global-set-key [f6] 'match-parenthesis)

Simon Hawkin <cema@cs.umd.edu> 03/14/1998"
  (interactive "p")
  (let
      ((syntax (char-syntax (following-char))))
  (cond
   ((= syntax ?\()
    (forward-sexp 1) (backward-char))
   ((= syntax ?\))
    (forward-char) (backward-sexp 1))
   (t (message "No match"))
   )
  ))
(global-set-key "\C-c6" 'match-parenthesis)
(global-set-key [f6] 'match-parenthesis)

(require 'color-theme)
(color-theme-initialize)
(color-theme-sitaramv-solaris)
;; (color-theme-subtle-hacker)
;; (color-theme-clarity)
;; (color-theme-arjen)
;; (color-theme-jsc-dark)
;; (color-theme-dark-laptop)

(display-time)
(eldoc-mode)

(require 'rect-mark)
;; (setq viper-mode t)                ; enable Viper at load time
;; (setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
;; (require 'viper)                   ; load Viper
;; (require 'vimpulse)                ; load Vimpulse
;; (setq woman-use-own-frame nil)     ; don't create new frame for manpages
;; (setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)

(setq auto-mode-alist (cons '("\\.fzt$" . c-mode) auto-mode-alist))

;; (require 'google)

;; (defvar google-button-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map "\r" 'push-button)
;;     (define-key map [mouse-1] 'push-button)
;;     (define-key map [mouse-3] 'google-join-buttons-region)
;;     map)
;;   "Keymap used by buttons.")

;; (defun google-region ()
;;   "Turn all non-whitespace groups of characters in the region into hyperlinks
;; to google searches on those groups of characters."
;;   (interactive)
;;   (let ((rb (region-beginning))
;; 	(re (region-end))
;; 	(white "[ \t\r\n]+")
;; 	(non-white "[^ \t\r\n]+"))
;;     (save-excursion
;;       (goto-char rb)
;;       (while (< (point) re)
;; 	(skip-chars-forward " \t\r\n")
;; 	(if (not (equal (point) re))
;; 	    (progn
;; 	      (re-search-forward non-white re 'go-there)
;; 	      (make-text-button
;; 	       (match-beginning 0)
;; 	       (match-end 0)
;; 	       'type (define-button-type 'google-button
;; 		       'keymap google-button-map
;; 		       'action (lambda (x)
;; 				 (let* ((but (button-at (point)))
;; 					(text (buffer-substring-no-properties
;; 					       (button-start but)
;; 					       (button-end but))))
;; 				   (browse-url
;; 				    (concat
;; 				     "http://www.google.com/search?q="
;; 				     text))))))))))))

;; (defun google-join-buttons-region ()
;;   "Turn all non-whitespace groups of characters in the region into hyperlinks
;; to google searches on those groups of charactersgoogle buttons in region into
;; one big google button."
;;   (interactive)
;;   (let* ((rb (region-beginning))
;; 	 (re (region-end))
;; 	 (bb (button-at rb))
;; 	 (be (button-at re))
;; 	 (rb (if bb (button-start bb) rb))
;; 	 (re (if be (button-end bb) re))
;; 	 (white "[ \t\r\n]+")
;; 	 (non-white "[^ \t\r\n]+"))
;;     (save-excursion
;;       (goto-char rb)
;;       (skip-chars-forward " \t\r\n")
;;       (if (not (equal (point) re)) (setq rb (point)))
;;       (goto-char re)
;;       (skip-chars-backward " \t\r\n")
;;       (if (not (equal (point) rb)) (setq re (point)))
;;       (let ((buftext (buffer-substring rb re)))
;; 	;; This clears all buttons from region.
;; 	;; Unfortunately it also clear all other text properties.
;; 	(delete-region rb re)
;; 	(insert buftext)
;; 	(make-text-button
;; 	 rb re
;; 	 'type (define-button-type 'google-button
;; 		 'keymap google-button-map
;; 		 'action (lambda (x)
;; 			   (let* ((but (button-at (point)))
;; 				  (text (buffer-substring-no-properties
;; 					 (button-start but)
;; 					 (button-end but))))
;; 			     (browse-url
;; 			      (concat
;; 			       "http://www.google.com/search?q=\'"
;; 			       text
;; 			       "\'"))))))))))



;; (defvar my-fullscreen-p t "Check if fullscreen is on or off")

;; (defun my-non-fullscreen ()
;;   (interactive)
;;   (if (fboundp 'w32-send-sys-command)
;;       ;; WM_SYSCOMMAND restore #xf120
;;       (w32-send-sys-command 61728)
;;     (progn (set-frame-parameter nil 'width 82)
;; 	   (set-frame-parameter nil 'fullscreen 'fullheight))))

;; (defun my-fullscreen ()
;;   (interactive)
;;   (if (fboundp 'w32-send-sys-command)
;;       ;; WM_SYSCOMMAND maximaze #xf030
;;       (w32-send-sys-command 61488)
;;     (set-frame-parameter nil 'fullscreen 'fullboth)))

;; (defun my-toggle-fullscreen ()
;;   (interactive)
;;   (setq my-fullscreen-p (not my-fullscreen-p))
;;   (if my-fullscreen-p
;;       (my-non-fullscreen)
;;     (my-fullscreen)))

(defun fullscreen ()
  "Fullscreen."
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         ;; if first parameter is '1', can't toggle fullscreen status
                         '(1 "_NET_WM_STATE_FULLSCREEN" 0)))

(defun fullscreen-toggle ()
  "Toggle fullscreen status."
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         ;; if first parameter is '2', can toggle fullscreen status
                         '(2 "_NET_WM_STATE_FULLSCREEN" 0)))


(global-set-key [f2] 'fullscreen-toggle)
(fullscreen-toggle)

(require 'lusty-explorer)
(global-set-key [f3] 'lusty-buffer-explorer)
(global-set-key [f4] 'lusty-file-explorer)

(require 'tbemail)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
