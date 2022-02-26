GBVNGINEJAR := ${GBVNG_JAR}
LCC := ${LCC_BIN}
MOD2GBT := ${MOD2GBT_BIN}
GBT_SOURCE_FILES := ${GBT_SOURCE_FILES}

music_mod_files = $(wildcard music/ship/*.mod)
music_c_file = $(subst music/ship/,build/music/, $(subst .mod,.c,$(wildcard music/ship/*.mod)))

game.gb : game.c $(music_c_file)
	$(LCC) build/game.c $(GBT_SOURCE_FILES) $(music_c_file) -o build/game.gb

game.c : build
	java -jar $(GBVNGINEJAR) gen . -o build/game.c

build :
	mkdir build

build/music : build
	mkdir build/music

$(music_c_file) : build/music
	$(MOD2GBT) $(subst build/music,music/ship, $(subst .c,.mod,$@)) $(subst build/music/,, $(subst .c,,$@)) 1
	cp output.c $@
	rm output.c
	
clean :
	rm -r build

compile : 
	$(LCC) build/game.c $(GBT_SOURCE_FILES) assets.c $(music_c_file) -o build/game.gb