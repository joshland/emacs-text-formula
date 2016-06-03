emacs:
    pkg.installed:
      - pkgs:
          {% if grains['cpuarch'][:3] == 'arm' %}
          - emacs-nox
          {% elif grains['os_family'] == 'RedHat' %}
          - emacs-nox
          {% elif grains['os_family'] == 'Debian' %}
          - emacs24-nox
          {% endif %}

https://github.com/purcell/color-theme-sanityinc-tomorrow.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/themes/color-theme-sanity-tomorrow

https://github.com/jimeh/twilight-bright-theme.el.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/themes/twilight-bright-theme

https://github.com/yoshiki/yaml-mode.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/yaml-mode

https://github.com/jrblevin/markdown-mode.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/markdown-mode


/usr/share/emacs/site-lisp/site-start.d/themes.el:
  file.managed:
    - user: root
    - group: root
    - mode: "0644"
    - contents: |
        (add-to-list 'custom-theme-load-path "/usr/share/emacs/site-lisp/themes/twilight-bright-theme/")
        (add-to-list 'custom-theme-load-path "/usr/share/emacs/site-lisp/themes/color-theme-sanity-tomorrow/")
        (require 'twilight-bright-theme)
        (require 'color-theme-sanityinc-tomorrow)

        (custom-set-variables
        '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
        '(custom-enabled-themes (quote (twilight-bright)))
        '(custom-safe-themes (quote ("03f28a4e25d3ce7e8826b0a67441826c744cbf47077fb5bc9ddb18afe115005f" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
        '(vc-annotate-background nil)
        '(vc-annotate-color-map (quote ((20 . "#d54e53") (40 . "#e78c45") (60 . "#e7c547") (80 . "#b9ca4a") (100 . "#70c0b1") (120 . "#7aa6da") (140 . "#c397d8") (160 . "#d54e53") (180 . "#e78c45") (200 . "#e7c547") (220 . "#b9ca4a") (240 . "#70c0b1") (260 . "#7aa6da") (280 . "#c397d8") (300 . "#d54e53") (320 . "#e78c45") (340 . "#e7c547") (360 . "#b9ca4a"))))
        '(vc-annotate-very-old-color nil))
      
        (custom-set-faces
        )

/usr/share/emacs/site-lisp/site-start.d/emacs_text.el:
  file.managed:
    - user: root
    - group: root
    - mode: "0644"
    - contents: |
        (mapc 'load
        (directory-files "/usr/share/emacs/site-lisp/yaml-mode/" t "^[^#].*el$"))
	(add-to-list 'load-path "/usr/share/emacs/site-lisp/markdown-mode")
        
        (put 'downcase-region 'disabled nil)
        ;; Only spaces, no tabs
        (setq indent-tabs-mode nil)
        
        ;; Always end a file with a newline
        (setq require-final-newline nil)
              
        ;; Don't know which of these might work
        (setq-default tab-width 2)
        (setq-default python-indent 2)
        (setq-default py-indent-offset 2)
        
        ;; Python Hook
        (add-hook 'python-mode-hook
        (function (lambda ()
        (setq indent-tabs-mode nil
        tab-width 2))))
              
        ;;Begin YAML
        (add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode))
              
        (require 'yaml-mode)
        
        (define-derived-mode saltstack-mode yaml-mode "Saltstack"
        "Minimal Saltstack mode, based on `yaml-mode'."
        (setq tab-width 2
        indent-tabs-mode nil))
        
        (add-to-list 'auto-mode-alist '("\\.sls\\'" . saltstack-mode))
              
              
        (require 'yaml-mode)
        (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
        
        (add-hook 'yaml-mode-hook
        '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
        ;;End YAML
        
