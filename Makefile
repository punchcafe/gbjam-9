
music_mod_files = $(wildcard music/ship/*.mod)
music_c_file = $(subst music/ship/,build/music/, $(subst .mod,.c,$(wildcard music/ship/*.mod)))

game.gb : $(music_c_file) game.c
	$(LCC) -o build/game.gb -Wl-yo16 -Wm-yt1 $(wildcard build/*.c) $(GBT_SOURCE_FILES)

game.c : build
	java -jar $(GBVNGINEJAR) gen . -o build/game.c

build :
	mkdir -p build

build/music : build
	mkdir -p build/music

$(music_c_file) : build/music
	$(MOD2GBT) $(subst build/music,music/ship, $(subst .c,.mod,$@)) $(subst build/music/,, $(subst .c,,$@)) 1
	cp output.c $@
	rm output.c
	
clean :
	rm -r build

compile : 
	$(LCC) build/bank_1.c $(wildcard build/*.c) $(GBT_SOURCE_FILES) assets.c $(music_c_file) -o build/game.gb