;;#################################
;; Load the Libs's of emacs lisps
;;#################################
;; add elisp to load-path
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; load install-elisp
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; load auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; load anything
(require 'anything)
(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

;; (global-company-mode 1)
(add-to-list 'load-path"~/.emacs.d/elpa/company-0.8.12")
(require 'company)
(global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
;;(autoload 'company-mode"company" nil t)
;;(setq company-idle-delay nil)
;;(global-set-key [(control tab)] 'company-complete-common)

;;#################################
;; Common Setting
;;#################################
;; *.~とかのバッグアップファイルを作らない
(setq make-backup-file nil)

;; .#*とかのバッグアップファイルを作らない
(setq auto-save-default nil)

;;#################################
;; Setting For Display
;;#################################

;;バッファをウィンドウに固定するマイナーモード
(defvar sticky-buffer-previous-header-line-format)
(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
  (if sticky-buffer-mode
      (progn
	(set (make-local-variable 'sticky-buffer-previous-header-line-format) header-line-format)
	(set-window-dedicated-p (selected-window) sticky-buffer-mode)
      )
    (set-window-dedicated-p (selected-window) sticky-buffer-mode)
    (set header-line-format sticky-buffer-previous-header-line-format)
  )
)

;; Toggle window decication
(defun toggle-window-dedicated()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
    (if (let (window (get-buffer-window (current-buffer)))
	  (set-window-dedicated-p window (not (window-dedicated-p window)))
        )
       "Window '%s' is dedicated"
       "Window '%s' is normal"
    )
    (current-buffer)
  )
)

;;#################################
;; Setting For Debuger-Mode
;;#################################
(setq gdb-many-windows t)

;; Set mirror-mode sticky buffer for gud-mode
(add-hook 'gud-mode-hook 'sticky-buffer-mode)

;;#################################
;; Setting For Dired-Mode
;;#################################
;; diredを二つのウィンドウで開いている時に、デフォルトの移動orコピー先を
;; もう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copieds 'always)
;; diredバッファでC-sした時にファイル名だけにマッチするように
(setq dired-isearch-filenames t)

;; set color(only for emacs 21)
(global-font-lock-mode t)

;; set linum mode 
(put 'upcase-region 'disabled nil)
;;(global-linum-mode t)

;; Set the indent of c language
(setq c-default-style "linux"
      c-basic-offset 4)

;; company.el's setting, starting with ctrl+tab
(add-hook 'c-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode nil)
	     (setq indent-level 4)
	     (setq tab-width 4)
	     ;; flyspell-prog-modeをオンにする
	     (flyspell-prog-mode)
	     (company-mode)
	     ))
(add-hook 'c++-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode nil)
	     (setq indent-level 4)
	     (setq tab-width 4)
	     (company-mode)
	     ))
(add-hook 'python-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode nil)
	     (setq indent-level 4)
	     (setq python-indent 4)
	     (setq tab-width 4)
	     ))


;;#################################
;; Setting of key bindings
;;#################################
;;(when(eq system-type 'darwin)
;;  (setq mac-command-key-is-meta nil)
;;  (setq mac-option-modifier 'meta)
;;  (setq mac-command-modifier 'super)
;;  (setq mac-pass-control-to-system t))

;;C-c aでanythingコマンドを呼び出す
(define-key mode-specific-map "a" 'anything)
;;C-c cでcompileコマンドを呼び出す
(define-key mode-specific-map "c" 'compile)
;;C-c C-zでshellコマンドを呼び出す
(define-key mode-specific-map "\C-z" 'shell-command)



;; from http://ppgunjack.iteye.com/blog/1179657
;(defadvice gdb-frame-handler-1 (after activate)
;  (if gdb-use-separate-io-buffer
;      (advice_separate_io)
;   (advice_no_separate_io)
;  )
;)
;
;(defun advice_no_separate_io()
;  (if (not (gdb-get-buffer 'gdb-assembler-buffer))
;      (progn
;	(shrink-window-horizontally ( / (window-width) 3))
;
;	(other-window 1)
;	(split-window-horizontally)
;
;	(other-window 1)
;	(gdb-set-window-buff (gdb-stack-buffer-name))
;
;	(other-window 1)
;	(split-window-horizontally)
;
;	(other-window 1)
;	(gdb-set-window-buff (gdb-get-buffer-create 'gdb-assembler-buffer))
;	
;	(shrink-window-horizontally ( / ((* (window-width) 2) 3))
;
;	(other-window 1)
;	(gdb-set-window-buff (gdb-get-buffer-create 'gdb-registers-buffer))
;
;	(other-window 1)
;	(toggle-current-windows-dedication)
;	(gdb-set-window-buff (gdb-get-buffer-create 'gdb-memory-buffer))
;	(toggle-current-windows-dedication)
;
;	(other-window 2)
;      )
;  )
;)
;
;(defun advice_separate_io()
;  (if (not (gdb-get-buffer 'gdb-assembler-buffer))
;      (progn
;	(split-window-horizontally)
;	(enlarge-window-horizontally ( / (window-width) 3))
;	(other-window 1)
;
;	(gdb-set-window-buff (gdb-inferior-name))
;
;	(other-window 1)
;	(split-window-horizontally)
;
;	(other-window 1)
;	(gdb-set-window-buff (gdb-stack-buffer-name))
;
;	(other-window 1)
;
;	(other-window 1)
;	(toggle-current-windows-dedication)
;	(gdb-set-window-buff (gdb-get-buffer-create 'gdb-assembler-buffer))
;	(toggle-current-windows-dedication)
;	
;	(shrink-window-horizontally ( / ((* (window-width) 2) 3))
;
;	(other-window 1)
;	(gdb-set-window-buff (gdb-get-buffer-create 'gdb-registers-buffer))
;
;	(other-window 1)
;	(toggle-current-windows-dedication)
;	(gdb-set-window-buff (gdb-get-buffer-create 'gdb-memory-buffer))
;	(toggle-current-windows-dedication)
;
;	(other-window 2)
;      )
;  )
;)
