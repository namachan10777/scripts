ALACRITTY_SOURCES := pkgs/alacritty/alacritty.yml
FISH_SOURCES      := $(wildcard pkgs/fish/*)
GIT_SOURCE        := pkgs/git/gitconfig
LATEXMK_SOURCE    := pkgs/latexmk/latexmkrc
LAZYGIT_SOURCE    := pkgs/lazygit/config.yml
NVIM_SOURCES      := $(wildcard pkgs/neovim/*)
SWAY_SOURCE       := pkgs/sway/config
TIG_SOURCE        := pkgs/tig/tigrc

UDEV_SOURCES      := $(wildcard pkgs/udev/*.rules)
IPTABLES_SOURCES  := $(wildcard pkgs/iptables/*.rules)

ALACRITTY_TARGETS := $(XDG_CONFIG_HOME)/alacritty/alacritty.yml
FISH_TARGETS      := $(patsubst pkgs/neovim/%,$(XDG_CONFIG_HOME)/fish/%,$(FISH_SOURCES))
GIT_TARGET        := $(HOME)/.gitconfig
LATEXMK_TARGET    := $(HOME)/.latexmkrc
LAZYGIT_TARGET    := $(XDG_CONFIG_HOME)/jessedufield/config.yml
NVIM_TARGETS      := $(patsubst pkgs/neovim/%,$(XDG_CONFIG_HOME)/nvim/%,$(NVIM_SOURCES))
SWAY_TARGET       := $(XDG_CONFIG_HOME)/sway/config
TIG_TARGET        := $(HOME)/.tigrc

UDEV_TARGETS      := $(patsubst pkgs/udev/%,/etc/udev/rules.d/%,$(UDEV_SOURCES))
IPTABLES_TARGETS  := $(patsubst pkgs/iptables/%,/etc/iptables/%,$(IPTABLES_SOURCES))

.PHONY: install
install: \
	$(FISH_TARGETS) \
	$(ALACRITTY_TARGETS) \
	$(GIT_TARGET) \
	$(LATEXMK_TARGET) \
	$(LAZYGIT_TARGET) \
	$(NVIM_TARGETS) \
	$(SWAY_TARGET) \
	$(TIG_TARGET)

.PHONY: install-system
install-all: $(UDEV_TARGETS) $(IPTABLES_TARGETS)

.PHONY: clean
clean:
	rm -f $(ALACRITTY_TARGETS)
	rm -rf $(FISH_TARGETS)
	rm -f $(LATEXMK_TARGET)
	rm -f $(LAZYGIT_TARGET)
	rm -rf $(NVIM_TARGETS)
	rm -f $(SWAY_TARGET)
	rm -f $(TIG_TARGET)

.PHONY: clean-system
clean-system:
	@echo $(IPTABLES_SOURCES)
	@echo $(IPTABLES_TARGETS)
	rm -f $(UDEV_TARGETS) $(IPTABLES_TARGETS)

$(GIT_TARGET): $(GIT_SOURCE)
	cp -ar $< $@

$(LATEXMK_TARGET): $(LATEXMK_SOURCE)
	cp -ar $< $@

$(TIG_TARGET): $(TIG_SOURCE)
	cp -ar $< $@

$(SWAY_TARGET): $(SWAY_SOURCE)
	mkdir -p $(XDG_CONFIG_HOME)/sway
	cp -ar $< $@

$(LAZYGIT_TARGET): $(LAZYGIT_SOURCE)
	mkdir -p $(XDG_CONFIG_HOME)/jessedufield/lazygit
	cp -ar $< $@

$(XDG_CONFIG_HOME)/nvim/%: pkgs/neovim/%
	mkdir -p $(XDG_CONFIG_HOME)/nvim
	cp -ar $< $@

$(XDG_CONFIG_HOME)/alacritty/%: pkgs/alacritty/%
	mkdir -p $(XDG_CONFIG_HOME)/alacritty
	cp -ar $< $@

$(XDG_CONFIG_HOME)/fish/%: pkgs/fish/%
	mkdir -p $(XDG_CONFIG_HOME)/fish
	cp -ar $< $@

/etc/udev/%: pkgs/udev/%
	cp -r $< $@

/etc/iptables/%: pkgs/iptables/%
	cp -r $< $@