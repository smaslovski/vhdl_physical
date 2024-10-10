SRC=types.vhd rc.vhd schmitt.vhd tb.vhd
OPTS=--std=08 --workdir=work
WAVE=waveforms.ghw
SAVE=waveforms.gtkw
GTKW=gtkwave
LOG=out.log

tb: $(SRC)
	mkdir -p work
	for f in $(SRC); do ghdl -a $(OPTS) $$f; done
	ghdl -e $(OPTS) $@

run: tb
	ghdl -r $(OPTS) tb

$(WAVE): tb
	ghdl -r $(OPTS) tb --wave=$@ | tee $(LOG) | tail -n5

wave: $(WAVE)
	if [ -f $(SAVE) ]; then $(GTKW) $(SAVE); else $(GTKW) $<; fi

clean:
	rm -f *.o tb rm $(WAVE) $(LOG)
	rm -rf work

.PHONY: clean
