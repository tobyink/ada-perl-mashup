all: libgreeter.so 

libgreeter.so: greeter.o
	gcc -shared -o libgreeter.so greeter.o

greeter.o: greeter.adb greeter.ads
	gnatmake -z -fPIC greeter.adb

clean:
	rm -rf greeter.ali greeter.o greeter libgreeter.so 

test:
	perl greeter.pl
