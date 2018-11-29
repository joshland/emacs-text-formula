(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/themes/twilight-bright-theme/")
(when (boundp 'custom-theme-load-path)
	(require 'twilight-bright-theme))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/themes/color-theme-sanity-tomorrow/")
(require 'color-theme-sanityinc-tomorrow)

(custom-set-variables
'(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
'(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
'(custom-safe-themes (quote ("03f28a4e25d3ce7e8826b0a67441826c744cbf47077fb5bc9ddb18afe115005f" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
'(vc-annotate-background nil)
'(vc-annotate-color-map (quote ((20 . "#d54e53") (40 . "#e78c45") (60 . "#e7c547") (80 . "#b9ca4a") (100 . "#70c0b1") (120 . "#7aa6da") (140 . "#c397d8") (160 . "#d54e53") (180 . "#e78c45") (200 . "#e7c547") (220 . "#b9ca4a") (240 . "#70c0b1") (260 . "#7aa6da") (280 . "#c397d8") (300 . "#d54e53") (320 . "#e78c45") (340 . "#e7c547") (360 . "#b9ca4a"))))
'(vc-annotate-very-old-color nil))
      
(custom-set-faces
)
