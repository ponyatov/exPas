
log.log: ./exe.exe
	./exe.exe > log.log && tail $(TAIL) log.log

./exe.exe: pas.pas Makefile
	fpc -v0 -o$@ $<

.PHONY: clean
clean:
	rm -rf *.exe *.log *.o
