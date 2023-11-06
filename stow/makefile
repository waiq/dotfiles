REQ_BIN:=stow tmux nvim
$(foreach bin,$(REQ_BIN),\
    $(if $(shell command -v $(bin) 2> /dev/null),,$(error Please install `$(bin)`)))

all:
	@stow --verbose --target=$$HOME --restow */

delete: 
	@stow --verbose --target=$$HOME --delete */
