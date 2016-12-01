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
    - source: http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz
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
        
