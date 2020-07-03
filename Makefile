.PHONY: install

install-system: configuration.nix hardware-configuration.nix
	cp configuration.nix /etc/nixos/
	cp hardware-configuration.nix /etc/nixos/

install-home: home.nix
	cp home.nix ~/.config/nixpkgs/
