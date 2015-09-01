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
(auto-install-update-emacswiki-package-name t)
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

;; set by L.Yang
(put 'upcase-region 'disabled nil)
(global-linum-mode t)

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

