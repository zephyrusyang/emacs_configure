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
;; Bellを無効化
(setq visible-bell t)

;; 起動画面を消す
(setq inhibit-startup-message t)

;; 列番号を表示する
(setq column-number-mode t)

;; 括弧を書くときにペアの括弧をハイライト表示（Jumoしない）
(show-paren-mode t)
(setq show-paren-style 'parentheses)

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
;; Setting For Dired-Mode
;;#################################
(setq dired-recursive-copieds 'top)
(setq dired-recursive-deletes 'top)


;;#################################
;; Setting For Debuger-Mode
;;#################################
(setq gdb-many-windows t)

;; Set mirror-mode sticky buffer for gud-mode
(add-hook 'gud-mode-hook 'sticky-buffer-mode)

;;#################################
;; Setting For hippie-expand
;;#################################
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))


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

; windmove(for Mac/Linux)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)

;; Command Binding 
(global-set-key (kbd "C-c a") 'anything)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c d") 'gud-gdb)
(global-set-key (kbd "C-c s") 'shell)
(global-set-key (kbd "C-c g") 'grep-find)
(global-set-key (kbd "C-c f") 'sticky-buffer-mode)
(global-set-key (kbd "C-c l") 'linum-mode)

(put 'narrow-to-page 'disabled nil)


;;#################################
;; 使い方のメモ
;;#################################

;; 複数ファイルの複数行に渡る置換を行う
;; 1.置換したい対象のファイルを選択する
;;   >> M-x find-dired
;;   >> Run find in directory: [you dir]
;;   >> Run find (with args): -type f -name *.c
;; 2.Diredで見つかったファイルがリストアップされますので
;;   Qを押して dired-do-query-replace-regexp を呼び出す
;;   置換え前文字列と置き換え後文字列を入力する（改行符号：C-q C-j）
;; 3.変更を保存：M-x ibuffer呼び出し、*uで変更したけど保存していないBuffer
;;   を選択して、Sで保存、DでそのBufferのKill


