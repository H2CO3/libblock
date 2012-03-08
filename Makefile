TARGET = libblock.a
OBJECTS = block.o

#################################################

SYSROOT = /var/mobile/sysroot

CC = gcc
AR = ar


CFLAGS = -isysroot $(SYSROOT) \
         -std=gnu99 \
         -Wall \
         -I. \
         -c
         
ARFLAGS = rcsv

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(AR) $(ARFLAGS) $@ $^

%.o: %.m
	$(CC) $(CFLAGS) $^

%.m: %.h

