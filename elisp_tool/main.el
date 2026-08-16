;; Elisp Tool: Advanced Text Manipulation and Buffer Management

;;; Variables
(defvar elisp-tool-prefix-map (make-sparse-keymap) "Prefix map for elisp-tool.")
(global-set-key (kbd "C-c e") elisp-tool-prefix-map "Bind C-c e to elisp-tool prefix.")

;;; Advanced Text Manipulation

(defun elisp-tool-wrap-selection (open-char close-char &optional prefix) 
  "Wrap the selected region with OPEN-CHAR and CLOSE-CHAR.
If PREFIX is non-nil, also prepend and append it to the selection.
If no region is active, insert the chars and leave point between them.
This function wraps the currently selected region in a pair of characters.
If no region is selected, it inserts the pair and positions the cursor between them.
When called with a prefix argument, it also inserts the prefix at the start and end of the selection." 
  (interactive "COpen character: \nCClose character: \nP")
  (let ((start (if (region-active-p) (region-beginning) (point)))
        (end (if (region-active-p) (region-end) (point))))
    (if (region-active-p)
        (progn
          (goto-char end)
          (insert close-char)
          (goto-char start)
          (insert open-char)
          (if prefix
              (progn
                (goto-char (point-min))
                ;; Move to the first line of the region
                (let ((region-start (region-beginning)))
                  (goto-char region-start)
                  (if prefix (insert prefix))
                  (forward-line (- (- (region-end) (region-beginning)) 0))
                  (unless (eobp) (insert prefix))))))
      (insert open-char close-char)
      (forward-char -1))))

(defun elisp-tool-transform-selection (transform-function)
  "Transform the selected region using TRANSFORM-FUNCTION.
The function should take a string and return a transformed string." 
  (interactive "aTransform Function: ")
  (let ((region (buffer-substring-no-properties (region-beginning) (region-end))))
    (delete-region (region-beginning) (region-end))
    (insert (funcall transform-function region))))

(defun elisp-tool-replace-match-case (pattern replacement &optional ignore-case)
  "Replace all matches of PATTERN in the buffer with REPLACEMENT.
If IGNORE-CASE is non-nil, the match is case-insensitive." 
  (interactive "sPattern: \nsReplacement: \nP")
  (let ((flags (if ignore-case "i" ""))) 
    (save-excursion
      (goto-char (point-min)) 
      (while (search-forward-regexp pattern nil t) 
        (replace-match replacement nil nil nil 1)))))

;;; Buffer Management

(defun elisp-tool-close-other-buffers (&optional kill-other-buffers)
  "Close all buffers except the current one.
If KILL-OTHER-BUFFERS is non-nil, kill them instead of just closing."
  (interactive "P")
  (let ((current-buffer (current-buffer)))
    (dolist (buf (buffer-list))
      (if (not (eq buf current-buffer))
          (if kill-other-buffers
              (kill-buffer buf)
            (bury-buffer buf))))))

(defun elisp-tool-buffers-by-mode (mode)
  "List buffers containing the given MODE."
  (interactive "bMode: ")
  (let ((mode-buffers '()))
    (dolist (buf (buffer-list))
      (when (derived-mode-p mode)
        (push (buffer-name buf) mode-buffers)))
    (message "Buffers with mode %s: %s" mode (string-join mode-buffers ", "))))

(defun elisp-tool-rename-buffer (new-name)
  "Rename the current buffer to NEW-NAME."
  (interactive "sNew buffer name: ")
  (rename-buffer new-name t))

(defun elisp-tool-open-new-buffer (name &optional mode)
  "Create and switch to a new buffer named NAME.
Optionally set the major MODE."
  (interactive "sNew buffer name: \bsMajor mode: ")
  (let ((new-buffer (get-buffer-create name)))
    (switch-to-buffer new-buffer)
    (when mode
      (funcall mode))))

(provide 'elisp-tool)
;;; elisp-tool.el ends here
