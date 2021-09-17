GBVNGINEJAR := ~/gb/cli.jar
LCC := /Applications/gbdk_mac/bin/lcc
game.gb : game.c
	$(LCC) build/game.c -o build/game.gb

game.c : build
	java -jar $(GBVNGINEJAR) gen . -o build/game.c

build :
	mkdir build

clean :
	rm -r build