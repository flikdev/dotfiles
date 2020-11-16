(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

(require 'use-package)
;; (setq use-package-always-ensure t
;;       use-package-verbose t)

(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  ;; :custom-face
  ;; (vertical-bar   (doom-darken base5 0.4))
  ;; (doom-darken bg 0.4)
  ;; (doom-modeline-bar ((t (:background "#6272a4"))))
  :config
  (load-theme 'doom-dracula t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; (use-package all-the-icons)

(use-package doom-modeline
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-icon nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (set-cursor-color "cyan")
  (line-number-mode 1)
  (column-number-mode 1))
  ;; (doom-modeline-def-modeline 'main
  ;;   '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
  ;;   '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker)))

;;
;; highlight
;;
(use-package display-line-numbers
  :hook
  ((prog-mode yaml-mode systemd-mode) . display-line-numbers-mode)
  :bind ([f6] . display-line-numbers-mode))
;; (global-display-line-numbers-mode 1)
;; (global-set-key [f6] 'display-line-numbers-mode)

(use-package highlight-indent-guides
  :diminish
  :hook
  ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled nil) ;; t
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character)) ; column

(use-package volatile-highlights
  :diminish
  :hook
  (after-init . volatile-highlights-mode)
  :custom-face
  (vhl/default-face ((nil (:foreground "#FF3333" :background "#FFCDCD")))))

;; (use-package rainbow-delimiters
;;   :hook
;;   (prog-mode . rainbow-delimiters-mode))

(use-package paren
  :ensure nil
  :hook
  (after-init . show-paren-mode)
  :custom-face
  (show-paren-match ((nil (:background "#44475a" :foreground "#f1fa8c"))))
  :custom
  (show-paren-style 'mixed)
  (show-paren-when-point-inside-paren t)
  (show-paren-when-point-in-periphery t))

(transient-mark-mode t)
(set-face-attribute 'region nil :background "#666")

(use-package fill-column-indicator
  :hook
  ((markdown-mode
    git-commit-mode) . fci-mode))

(use-package whitespace
  :config
  (setq whitespace-style '(face           ; faceで可視化
                           trailing       ; 行末
                           tabs           ; タブ
                           spaces         ; スペース
                           empty          ; 先頭/末尾の空行
                           space-mark     ; 表示のマッピング
                           tab-mark
                           ))
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (setq whitespace-display-mappings
        '((space-mark ?\x3000 [?\u25a1])
	  (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  :init (global-whitespace-mode t))

(use-package git-gutter
  :config
  (global-git-gutter-mode +1)
  (setq ad-redefinition-action 'accept)  ;; vc_revert
  :bind (("C-c g" . git-gutter:toggle)))

;;
;; language
;;
(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(use-package json-mode
  :mode ("\\.json\\'"))

(use-package dockerfile-mode
  :mode "\\Dockerfile\\'")

(use-package markdown-mode
  :mode ("\\.markdown\\'"
         "\\.md\\'"
         ("README\\.md\\'" . gfm-mode)))

(use-package js2-mode
  :mode ("\\.js\\'" . js2-mode))
;; (add-hook 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
;; (add-hook 'rjsx-mode-hook
;;           (lambda ()
;;             (setq indent-tabs-mode nil) ;;インデントはタブではなくスペース
;;             (setq js-indent-level 2) ;;スペースは２つ、デフォルトは4
;;             (setq js2-strict-missing-semi-warning nil))) ;;行末のセミコロンの警告はオフ

(global-eldoc-mode -1)
(add-hook 'python-mode-hook 'jedi:setup)

(use-package blacken
  :ensure t
  :hook ((python-mode . blacken-mode)
         (python-mode . flymake-mode))
  :config
  (setq jedi:use-shortcuts t))

(add-hook 'go-mode-hook (lambda()
                          (setq indent-tabs-mode nil)
                          (setq c-basic-offset 4)
                          (setq tab-width 4)))
(add-hook 'go-mode-hook 'flycheck-mode)

;;
;; etc
;;
(use-package dashboard
  :custom
  (dashboard-startup-banner 3)
  :config
  (dashboard-setup-startup-hook))
;; (setq dashboard-items '((recents  . 5)
;;                         (bookmarks . 5)
;; 			(projects . 5)
;; 			(agenda . 5)
;; 			(registers . 5)))

(setq ring-bell-function 'ignore)

(define-key global-map (kbd "C-t") 'other-window)

(global-set-key [f12] 'shell)

(setq default-tab-width 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dashboard fill-column-indicator git-gutter rainbow-delimiters volatile-highlights doom-modeline doom-themes yaml-mode use-package rjsx-mode python-mode golint go-mode go-errcheck flymake-go flycheck)))

(setq custom-file (locate-user-emacs-file "custom.el"))
