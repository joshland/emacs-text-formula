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

{% if grains['osmajorrelease'] == '6' %}
/usr/share/emacs/site-lisp:
  archive.extracted:
    - archive_format: tar
    - source: salt://emacs_text/files/color-theme-6.6.0.tar.gz
    - if_missing: /usr/share/emacs/site-lisp/color-theme-6.6.0
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

https://github.com/purcell/mmm-mode.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/mmm-mode

https://github.com/glynnforrest/mmm-jinja2.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/mmm-jinja2

https://github.com/glynnforrest/salt-mode.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/salt-mode

https://gitlab.com/python-mode-devs/python-mode.git:
  git.latest:
    - user: root
    - target: /usr/share/emacs/site-lisp/python-mode

/usr/share/emacs/site-lisp/site-start.d/themes.el:
  file.managed:
    - user: root
    - group: root
    - mode: "0644"
    - source: salt://emacs_text/files/themes-{{ grains['osmajorrelease'] }}.el

/usr/share/emacs/site-lisp/site-start.d/emacs_text.el:
  file.managed:
    - user: root
    - group: root
    - mode: "0644"
    - contents: |
        (mapc 'load
        (directory-files "/usr/share/emacs/site-lisp/yaml-mode/" t "^[^#].*el$"))
        (add-to-list 'load-path "/usr/share/emacs/site-lisp/markdown-mode")
        (add-to-list 'load-path "/usr/share/emacs/site-lisp/mmm-mode")
        (add-to-list 'load-path "/usr/share/emacs/site-lisp/mmm-jijna2")
        (add-to-list 'load-path "/usr/share/emacs/site-lisp/salt-mode")
        (push 'load-path "/usr/share/emacs/site-lisp/python-mode")
        
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
              
        (require 'salt-mode)
        (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
        
        (add-hook 'yaml-mode-hook
        '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
        ;;End YAML
        
