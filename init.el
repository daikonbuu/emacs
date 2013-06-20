; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)

(require 'ucs-normalize)

; windmove
(windmove-default-keybindings)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
;;; バックアップファイルを作らない
(setq backup-inhibited t)

;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; バックアップファイルの置き場所を指定する
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/bak"))
            backup-directory-alist))

;; メニューバーにファイルパスを表示する
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 背景を透過に設定
(set-frame-parameter nil 'alpha 85)

;;; 履歴数を大きくする
(setq history-length 10000)

;;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;; Window size & Color
(setq initial-frame-alist '((width . 100) (height . 30)))
(set-background-color "RoyalBlue4")
(set-foreground-color "LightGray")
(set-cursor-color "Gray")

(when (>= emacs-major-version 23)
 (set-face-attribute 'default nil
                     :family "monaco"
                     :height 140)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'mule-unicode-0100-24ff
  '("monaco" . "iso10646-1"))
 (setq face-font-rescale-alist
      '(("^-apple-hiragino.*" . 1.2)
        (".*osaka-bold.*" . 1.2)
        (".*osaka-medium.*" . 1.2)
        (".*courier-bold-.*-mac-roman" . 1.0)
        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
        (".*monaco-bold-.*-mac-roman" . 0.9)
        ("-cdac$" . 1.3))))

;; PATH
(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH"
(concat '"/usr/local/bin:" (getenv "PATH")))



;;; ホイールマウス
(mouse-wheel-mode t)
(setq mouse-wheel-follow-mouse t)

;;シフトでバッッファ移動
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; Carbon Emacs用の設定
(when  (featurep 'carbon-emacs-package)
  ;; フルスクリーン時にメニューバーを表示する
  (setq mac-autohide-menubar-on-maximize nil)
  ;; C-c mでフルスクリーンのトグルを行う
  (add-hook 'window-setup-hook
      (lambda ()
         (progn
    (set-frame-parameter nil 'alpha 95)
    (setq mac-autohide-menubar-on-maximize t)
    ;; (set-frame-parameter nil 'fullscreen 'fullboth)
     )
        ))
  (global-set-key "¥C-cm" 'mac-toggle-max-window)
  ;; Carbon Emacs用の設定終了
  )

;; Control 
(when (fboundp 'mac-add-ignore-shortcut) (mac-add-ignore-shortcut '(control)))
;; タブ
(add-hook 'objc-mode.el '(lambda ()
   (setq tab-width 4)
) t)

(add-hook 'c-mode.el '(lambda ()
   (setq tab-width 4)
) t)

(add-hook 'c++-mode.el '(lambda ()
   (setq tab-width 4)
) t)

(setq default-tab-width 4)

(setq make-backup-files nil)
(setq auto-save-default nil)

 (defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))

(global-set-key "\C-c\C-r" 'window-resizer)
