
BOOST    ?= /home/work/tools/boost_1_71_0/install
SYLVAN	 := "./inc/sylvan"

CXX 	 := g++
CXXFLAGS := -m64 -march=native -DVERILOG
LDFLAGS  := -m64

TARGET	 := verify

SRC_EXT	 := cpp
INC_EXT  := hpp

BLD_DIR	 := ./build
SRC_DIR	 := ./src
BIN_DIR	 := ./bin
INC_DIR  := ./inc
LIB_DIR	 := ./lib
OBJ_DIR	 := $(BLD_DIR)/objects

LIBRARIES:= -L$(LIB_DIR) -lsylvan  -L$(BOOST)/lib -lboost_program_options

# SOURCES  := $(wildcard $(SRC_DIR)/*.cpp)
SOURCES  := $(shell find $(SRC_PATH) -name '*.$(SRC_EXT)' | sort -k 1nr | cut -f2-)
OBJECTS  := $(SOURCES:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.o)
INCLUDE	 := -I $(INC_DIR) -I $(BOOST) -I $(SYLVAN)

all: build $(BIN_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $< $(LIBRARIES)

$(BIN_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) $(LDFLAGS) -o $(BIN_DIR)/$(TARGET) $(OBJECTS) $(LIBRARIES)

.PHONY: all build clean debug release

build:
	@mkdir -p $(BIN_DIR)
	@mkdir -p $(OBJ_DIR)

debug: CXXFLAGS += -DDEBUG -g
debug: all

release: CXXFLAGS += -O3 -std=c++11
release: all

clean:
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(BIN_DIR)/*
