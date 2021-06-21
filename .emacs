;;; --------------------------------------------------------------------------
;;; Basic settings
;;; --------------------------------------------------------------------------
;;; Comment out any of these if you prefer not to use them
(delete-selection-mode) ; Adds many Windows text editor style shortcuts
(column-number-mode t) ; Display column number alongside line number on status bar
(setq scroll-step 1) ; Scroll one line at a time, rather than half a page
(set-background-color "black")
(set-foreground-color "white")
(set-cursor-color "#2050A0")
(tool-bar-mode -1) ; Do not show a toolbar in GUI emacs
(setq auto-save-default nil) ; Don't autosave
(setq backup-inhibited 't) ; Don't create backups of the edited file
(setq next-line-add-newlines nil) ; Don't automatically add a newline at the end of doc
(global-set-key '[f2] 'save-buffer)
(global-set-key "\C-h" 'delete-backward-char)
(setq default-frame-alist '((width . 120) (height . 54)))

(defun font-exists-p (font) "check if font exists" (if (null (x-list-fonts font)) nil t))
(if (font-exists-p "9x15") (set-frame-font "9x15"))

;;; Redefine ctrl-backspace to not to add the removed text to the kill ring
(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (my-delete-word (- arg)))

(global-set-key (kbd "<C-backspace>") 'my-backward-delete-word)


;;; --------------------------------------------------------------------------
;;; Code coloring settings
;;; --------------------------------------------------------------------------
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(show-paren-mode t)

;;;Color settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(delete-selection-mode nil)
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(lazy-lock-defer-on-the-fly nil)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "white" :background "black"))))
 '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "Green"))))
 '(font-lock-comment-face ((((class color) (background dark)) (:foreground "ForestGreen"))))
 '(font-lock-doc-face ((((class color) (background dark)) (:foreground "#806010"))))
 '(font-lock-constant-face ((((class color) (background dark)) (:foreground "GreenYellow"))))
 '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "Coral"))))
 '(font-lock-keyword-face ((((class color) (background dark)) (:foreground "Yellow"))))
 '(font-lock-string-face ((((class color) (background dark)) (:foreground "Magenta"))))
 '(font-lock-type-face ((((class color) (background dark)) (:foreground "#40A0FF"))))
 '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "thistle"))))
 '(mode-line ((t (:foreground "yellow" :background "Blue"))))
 '(region ((t (:foreground "black" :background "#99CCFF"))))
 '(trailing-whitespace ((((class color) (background dark)) (:background "blue")))))

(add-to-list 'file-coding-system-alist '("\\.h\\'" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.hh\\'" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.m\\'" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.mm\\'" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.cc\\'" . utf-8))


;;; --------------------------------------------------------------------------
;;; Autoindentation settings
;;; --------------------------------------------------------------------------
(defun my-c-mode-common-hook ()
  (setq c-basic-offset 4)
  (setq tab-width 8
	indent-tabs-mode nil)
  (c-set-offset 'substatement-open 0)
  ;(c-set-offset 'statement-cont 0)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'brace-list-intro '+)
  (c-set-offset 'case-label 2)
  (c-set-offset 'access-label -3)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;;; --------------------------------------------------------------------------
;;; Special scrolling functions
;;; --------------------------------------------------------------------------
(defun contents-move (dir checkpoint)
  (let ((oldColumn (current-column)))
    (if (not (pos-visible-in-window-p checkpoint))
        ((lambda ()
           (save-excursion
             (goto-char (window-start))
             (forward-line dir)
             (set-window-start (selected-window) (point))))))
    (forward-line dir)
    (move-to-column oldColumn)))

(defun contents-one-down ()
  (interactive)
  (contents-move -1 (point-min)))

(defun contents-one-up ()
  (interactive)
  (contents-move 1 (point-max)))

(defun generic-page-scroll (lines)
  (let ((oldColumn (current-column)))
    (save-excursion
      (goto-char (window-start))
      (forward-line lines)
      (set-window-start (selected-window) (point)))
    (forward-line lines)
    (move-to-column oldColumn)))

(defun page-scroll-up ()
  (interactive)
  (if (not (pos-visible-in-window-p (point-max)))
      (generic-page-scroll (- (1- (window-height)) next-screen-context-lines))
    (goto-char (point-max))))

(defun page-scroll-down ()
  (interactive)
  (if (not (pos-visible-in-window-p (point-min)))
      (generic-page-scroll (- next-screen-context-lines (1- (window-height))))
    (goto-char (point-min))))

(defun contents-one-down-keep-cursor-pos ()
  (interactive)
  (scroll-down 1))

(defun contents-one-up-keep-cursor-pos ()
  (interactive)
  (scroll-up 1))

;;; Use ctrl-up, ctrl-down, alt-up and alt-down to scroll:
(global-set-key '[(control up)] 'contents-one-down)
(global-set-key '[(control down)] 'contents-one-up)
(global-set-key '[(\M-up)] 'contents-one-down-keep-cursor-pos)
(global-set-key '[(\M-down)] 'contents-one-up-keep-cursor-pos)
;;; Fix page up and page down to work as they should:
(global-set-key '[next] 'page-scroll-up)
(global-set-key '[prior] 'page-scroll-down)
