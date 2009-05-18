;;; compile-bookmarks-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (compile-bookmarks-mode) "compile-bookmarks" "compile-bookmarks.el"
;;;;;;  (18683 30241))
;;; Generated autoloads from compile-bookmarks.el

(defvar compile-bookmarks-mode nil "\
Non-nil if Compile-Bookmarks mode is enabled.
See the command `compile-bookmarks-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `compile-bookmarks-mode'.")

(custom-autoload 'compile-bookmarks-mode "compile-bookmarks" nil)

(autoload 'compile-bookmarks-mode "compile-bookmarks" "\
Minor mode for keeping track of multiple `compile-command's.
This mode enables a bookmark menu for the commands used by `recompile'.
Once you have stored the last compilation with `compile-bm-add' (or the
menu), you will be able to execute that compilation from the menu.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("compile-bookmarks-pkg.el") (18683 30241
;;;;;;  122148))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; compile-bookmarks-autoloads.el ends here
