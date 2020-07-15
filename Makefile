docker:
	docker build -t dotfiles .
	docker run -d --rm --name dotfiles -t dotfiles
	- docker exec -it dotfiles bash
	docker stop dotfiles

dotfiles:
	cd scripts && ./dotbotinstall.sh
