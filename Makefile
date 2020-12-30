.PHONY: docker dotfiles help quality

check_dirs := .git-templates/*

help:
	@cat help

docker:
	docker build -t dotfiles .
	docker run -d --rm --name dotfiles -t dotfiles
	- docker exec -it dotfiles bash
	docker stop dotfiles

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
