.PHONY: docker dotfiles help quality

check_dirs := .git-templates/*

help:
	@cat help

dotfiles:
	cd scripts && ./dotbotinstall.sh

quality:
	black --check $(check_dirs)
	isort --check-only $(check_dirs)
	flake8 $(check_dirs)
	mypy $(check_dirs)

style:
	black $(check_dirs)
	isort $(check_dirs)
