alias rebuild="sudo nixos-rebuild switch --flake ~/mysystem#ollie" 
alias upgrade="nix flake update --flake ~/mysystem && sudo nixos-rebuild switch --flake ~/mysystem#ollie"
alias cleanup="sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-collect-garbage -d"
alias generations="sudo nix-env -p /nix/var/nix/profiles/system --list-generations"

eval "$(direnv hook bash)"