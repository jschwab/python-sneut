FC=gfortran

all: module

module: public_sneut4.o public_sneut5.o
	f2py -m fsneut --fcompiler=${FC} -c pycall.f90 -I public_sneut4.o -I public_sneut5.o

test: test.o public_sneut4.o public_sneut5.o
	${FC} -o test.x test.o public_sneut4.o public_sneut5.o
	./test.x

%.o : %.f
	${FC} -c -fPIC $<

%.o : %.f90
	${FC} -c $<

clean:
	rm -f *.o *.x
