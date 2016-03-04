;;; prelude-rust.el --- Emacs Prelude: Rust programming support.
;;
;; Author: Doug MacEachern
;; Version: 1.0.0
;; Keywords: convenience rust

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Prelude configuration for Rust

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'prelude-programming)

(prelude-require-packages '(rust-mode
                            rustfmt
                            racer
                            flycheck-rust
                            cargo))

(eval-after-load 'rust-mode
  '(progn
     (add-hook 'rust-mode-hook #'racer-mode)
     (add-hook 'rust-mode-hook #'rustfmt-enable-on-save)
     (add-hook 'racer-mode-hook #'eldoc-mode)
     (add-hook 'racer-mode-hook #'company-mode)
     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

     (defun prelude-rust-mode-defaults ()
       (local-set-key (kbd "TAB") #'company-indent-or-complete-common)

       (setq-local company-tooltip-align-annotations t)

       ;; CamelCase aware editing operations
       (subword-mode +1))

     (setq prelude-rust-mode-hook 'prelude-rust-mode-defaults)

     (add-hook 'rust-mode-hook (lambda ()
                               (run-hooks 'prelude-rust-mode-hook)))))

(provide 'prelude-rust)
;;; prelude-rust.el ends here
