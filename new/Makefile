.PHONY: update
update:
	home-manager switch --flake ./nix#waiq

.PHONY: clean test 
clean:
	nix-collect-garbage -d

.PHONY: all
all: update
