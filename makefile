CC=gcc
FLAGS=-Wall -g
TARGET=a
SRC=main.c

all:$(TARGET)

$(TARGET): $(SRC)
	$(CC) $(FLAGS) -o $(TARGET) $(SRC)

clean:
	rm -f $(TARGET)
