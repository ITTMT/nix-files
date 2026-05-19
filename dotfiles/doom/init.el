(doom! :input
       :completion
       company
       ivy

       :ui
       doom
       doom-dashboard
       modeline
       ophints
       vc-gutter
       vi-tilde-fringe
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       snippets

       :emacs
       dired
       electric
       undo
       vc

       :tools
       (lsp +dap)     ; Pre-compiles Language Server and Debug Protocols via Nix

       :lang
       (elixir +lsp)  ; Pulls down absolute rock-solid Elixir/OTP support
       emacs-lisp

       :config
       default)