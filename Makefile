game.gb : game.c
	$(LCC) -o build/game.gb -Wl-yo16 -Wm-yt1 $(wildcard build/*.c) $(GBT_SOURCE_FILES)

game.c : build
	java -jar $(GBVNGINEJAR) gen . -o build/game.c

build :
	mkdir -p build


clean :
	rm -r build