;;; erc-tab.el --- Provide a tab-style interface to erc buffers.

;; Copyright (C) 2003  David Edmondson <dme@dme.org>

;; Author: David Edmondson <dme@dme.org>
;; Keywords: tabs, faces
;; URL: http://www.emacswiki.org/cgi-bin/wiki.pl?ErcTabs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Provides tabs in the header-line to access different erc buffers.
;; This only works if your emacs supports a header line (emacs 21
;; does).  Add to your ~/.emacs:

;; (require 'erc-tab)
;; (erc-tab-mode 1)

;; The ideas and implementation here are taken from emacs-w3m.

;; Todo:
;;
;; * change the colour of the text in a tab to reflect activity and
;;   the type of activity (a combination of erc-track and xchat
;;   behaviour).  DONE: not as complex as erc-track, but useful for
;;   discussion.

(require 'erc)
; anything else?

;;; Code:

(defconst erc-tab-version "$Revision$"
  "ERC tab mode revision")

(defgroup erc-tab nil
  "Provide a tab interface to ERC buffers.")

(defcustom erc-tab-topic-format
  '(" " nick " " channel-modes " " topic)
  "Format of the topic in the header-line in erc-mode.
Only used in Emacs 21. This variable is processed using
`erc-prepare-mode-line-format'."
  :group 'erc-tab
  :type 'sexp)

(defcustom erc-tab-max-width 16
  "Maximum width of any one channel tab."
  :group 'erc-tab
  :type 'number)

; this removes server buffers for me
(defcustom erc-tab-interesting-buffers-regexp "^[^:]*$"
  "Regular expression used to look for interesting buffers.  Buffers whose
names match this expression will have a tab created in erc buffers."
  :group 'erc-tab
  :type 'regexp)

(defface erc-tab-unselected-face
  '((((type x w32 mac) (class color))
     :background "Gray50" :foreground "Gray20"
     :underline "Gray85" :box (:line-width -1 :style released-button))
    (((class color))
     (:background "cyan" :foreground "black" :underline "blue")))
  "*Face to fontify unselected tabs."
  :group 'erc-tab)

; TODO: use `:inherit' from `erc-tab-unselected-face' and then
; change the foreground.
(defface erc-tab-unselected-active-face
  '((((type x w32 mac) (class color))
     :background "Gray50" :foreground "blue"
     :underline "Gray85" :box (:line-width -1 :style released-button))
    (((class color))
     (:background "cyan" :foreground "yellow" :underline "blue")))
  "*Face to fontify unselected tabs."
  :group 'erc-tab)

(defface erc-tab-selected-face
  '((((type x w32 mac) (class color))
     :background "Gray85" :foreground "black"
     :underline "Gray85" :box (:line-width -1 :style released-button))
    (((class color))
     (:background "blue" :foreground "black" :underline "blue"))
    (t (:underline t)))
  "*Face to fontify selected tab."
  :group 'erc-tab)

(defface erc-tab-topic-face
  '((((type x w32 mac) (class color))
     :foreground "Grey85"
     :underline "Gray85" :box (:line-width -1 :style released-button))
    (((class color))
     (:background "cyan" :foreground "black" :underline "blue"))
    (t (:underline t)))
  "*Face to fontify the tab gutter, which contains the topic."
  :group 'erc-tab)

;;;

(defun erc-tab-buffer-list ()
  "Return all erc buffers."
  (mapcar
   'buffer-name
   (erc-buffer-list)))

(defun erc-tab-all-visible-buffer-names ()
  "Return all visible channel or query buffer names."
  (mapcar
   'buffer-name
   (erc-buffer-filter
    (lambda () (get-buffer-window (current-buffer) 'visible)))))

(defun erc-tab-all-interesting-buffer-names ()
  "Return all interesting erc buffer names."
  (mapcar
   'buffer-name
   (erc-buffer-filter
    (lambda ()
      (string-match erc-tab-interesting-buffers-regexp
		    (buffer-name (current-buffer)))))))

(defun erc-tab-make-keymap (buffer)
  (let ((map (make-sparse-keymap))
	(fn `(lambda (e) (interactive "e")
	       (select-window (car (event-start e)))
	       (switch-to-buffer ,buffer))))
    (define-key map [header-line down-mouse-1] 'ignore)
    (define-key map [header-line drag-mouse-1] fn)
    (define-key map [header-line mouse-1] fn)
    map))

(defun erc-tab-update ()
  "Update all tabs, as necessary."
  ; buffers which are visible don't belong in erc-tab-modified-buffers
  (mapcar (lambda (b)
	    (setq erc-tab-modified-buffers
		  (remove b erc-tab-modified-buffers)))
	  (erc-tab-all-visible-buffer-names))
  
  (mapcar 'erc-tab-update-buffer (erc-tab-buffer-list)))

(defun erc-tab-update-buffer (buffer)
  "Update the tabs in erc buffer `buffer'."
  (save-excursion
    (set-buffer buffer)
    (setq header-line-format
	  (append
	   (mapcar
	    (lambda (b)
	      (propertize
	       (concat " " (truncate-string-to-width
			    b (- erc-tab-max-width 2)) " ")
	       'face (cond
		      ((eq b buffer)
		       'erc-tab-selected-face)
		      ((member b erc-tab-modified-buffers)
		       'erc-tab-unselected-active-face)
		      (t
		       'erc-tab-unselected-face))
	       'local-map (erc-tab-make-keymap b)))
	    (erc-sort-strings (erc-tab-all-interesting-buffer-names)))
	   (list
	    (let* ((topic-text
		    (mapconcat 'identity
			       (erc-prepare-mode-line-format
				erc-tab-topic-format) ""))
		   (help-text
		    (with-temp-buffer
		      (insert topic-text)
		      (fill-region (point-min) (point-max))
		      (buffer-string))))
	      (propertize topic-text
			  'help-echo help-text
			  'face 'erc-tab-topic-face)))))))

(defun erc-prepare-mode-line-format (ignore)())

(defvar erc-tab-modified-buffers nil)

(defun erc-tab-buffer-updated ()
  "Hook for `erc-insert-post-hook'."
  (let ((this-channel (erc-default-target)))
    (if (and (not (get-buffer-window (current-buffer) 'visible))
	     (not (memq this-channel erc-tab-modified-buffers)))
	(setq erc-tab-modified-buffers
	      (cons this-channel erc-tab-modified-buffers)))))

(defun erc-tab-JOIN (proc parsed)
  (erc-tab-update)
  nil)

; TODO: only really needs to update the buffer that changed.
(defun erc-tab-TOPIC (proc parsed)
  (erc-tab-update)
  nil)

(defun erc-tab-remove ()
  "Unset the header line for all erc buffers."
  (save-excursion
    (mapcar
     (lambda (b) (set-buffer b) (setq header-line-format nil))
     (erc-tab-buffer-list))))

;;; Module;

(setq erc-tab-server-hooks '("JOIN" "TOPIC"))

;;;###autoload (autoload 'erc-tab-mode "erc-tab" nil t)
(define-erc-module tab nil
  "This mode provides a tab interface to ERC buffers."

  ; enable:
  ((if (featurep 'xemacs)
       (defadvice switch-to-buffer (after erc-update (&rest args) activate)
         (erc-tab-update))
     (add-hook 'window-configuration-change-hook
               'erc-tab-update))
   (mapcar
    (lambda (message)
      (add-hook (intern (concat "erc-server-" message "-hook"))
		(intern (concat "erc-tab-" message))
		t))
    erc-tab-server-hooks)

   (add-hook 'erc-kill-server-hook 'erc-tab-update t)
   (add-hook 'erc-kill-channel-hook 'erc-tab-update t)
   (add-hook 'erc-kill-buffer-hook 'erc-tab-update t)

   (add-hook 'erc-insert-post-hook 'erc-tab-buffer-updated)

   ; stop the normal header-line updates
   (remove-hook 'erc-update-mode-line-hooks 'erc-update-header-line)

   (erc-tab-update))

  ; disable:
  ; re-enable normal header-line updates
  ((add-hook 'erc-update-mode-line-hooks 'erc-update-header-line)

   (remove-hook 'erc-insert-post-hook 'erc-tab-buffer-updated)

   (remove-hook 'erc-kill-buffer-hook 'erc-tab-update)
   (remove-hook 'erc-kill-channel-hook 'erc-tab-update)
   (remove-hook 'erc-kill-server-hook 'erc-tab-update)

   (mapcar
    (lambda (message)
      (remove-hook (intern (concat "erc-server-" message "-hook"))
		   (intern (concat "erc-tab-" message))))
    (reverse erc-tab-server-hooks))

   (if (featurep 'xemacs)
       (ad-disable-advice 'switch-to-buffer 'after 'erc-update)
     (remove-hook 'window-configuration-change-hook
                  'erc-tab-update))
   (erc-tab-remove)))

(provide 'erc-tab)
