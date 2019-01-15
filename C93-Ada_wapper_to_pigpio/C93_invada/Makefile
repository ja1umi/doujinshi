# To compile Ada source file(s) with "pragma Debug" enabled, issue:
#	make debug=yes
# To compile Ada souce file(s) with "pragma Debug" disabled, issue:
#	make
ifdef debug
	FLAGS = -f -gnata
else
	FLAGS = -f
endif

all: clean
	gnatmake $(FLAGS) invada.adb -largs -lrt -lpthread -lpigpio

invada: timing2.adb
	gnatmake $(FLAGS) invada.adb -largs -lrt -lpthread -lpigpio

clean:
	rm -f invada *.o *.ali

