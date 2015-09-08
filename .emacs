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
;;(global-company-mode)
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
;; Setting For Windows Move
;; http://www.emacswiki.org/emacs/WindMove
;; http://d.hatena.ne.jp/mat_aki/20080421
;; http://qiita.com/tadsan/items/114ffe6bb645551268dd
;;#################################
; windmove(for Mac/Linux)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)
; windmove(for windows)
;(windmove-default-keybindings)
;(global-set-key (quote [kp-8]) (quote windmove-up))
;(global-set-key (quote [kp-2]) (quote windmove-down))
;(global-set-key (quote [kp-6]) (quote windmove-right))
;(global-set-key (quote [kp-4]) (quote windmove-left))


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

(defun my-code-editor-init()
     (setq indent-tabs-mode nil)
     (setq indent-level 4)
     (setq tab-width 4)
     ;; flyspell-prog-modeをオンにする
     (flyspell-prog-mode)
     ;; company-modeをオンにする
     (company-mode)  
)

;; setting for c/c++/python mode
(add-hook 'c-mode-hook 'my-code-editor-init)
(add-hook 'c++-mode-hook 'my-code-editor-init)
(add-hook 'python-mode-hook 'my-code-editor-init)
(add-hook 'emacs-lisp-mode-hook 'my-code-editor-init)


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

