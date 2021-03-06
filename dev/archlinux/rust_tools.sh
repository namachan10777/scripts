#!/bin/bash

TOOLS=(\
	# alt cat
	bat \
	# alt grep
	# ripgrep_all \
	ripgrep \
	# find
	fd-find \
	# ls
	lsd \
	# shell
	nu \
	# diff beautifier
	git-delta \
	# time
	hyperfine \
	# csv tools
	xsv csview \
	# network
	bandwhich gping ht dog \
	# binary analysis
	hexyl bingrep \
	# graphical cd
	broot \
	# count source codes
	tokei \
	# color
	pastel \
	# git tools
	onefetch git-interactive-rebase-tool \
	# fzf
	skim \
	# directory usage analyzer
	dutree diskonaut \
	# zoxide
	zoxide \
	# job queue
	pueue \
	# ps
	procs \
	# source to image \
	silicon \
	# update system packages
	topgrade cargo-update \
	# extract filed likes python
	choose
)

cargo install ${TOOLS[@]}
