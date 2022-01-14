.PHONY: help dotfiles

help:
	@cat help

dotfiles:
	cd scripts && ./dotbotinstall.sh

docker:
	docker build -t benjcunningham/ubuntu-20.04:minimal .
