.PHONY: help dotfiles

help:
	@cat help

dotfiles:
	cd scripts && ./dotbotinstall.sh
