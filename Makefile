.PHONY: home system

system:
	cp system/* /etc/nixos/

home:
	cp -r home/* ~/.config/nixpkgs/
