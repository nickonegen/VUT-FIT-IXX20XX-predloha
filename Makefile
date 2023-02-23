###############################################################################
#
# IXX-Projekt Makefile
# (edit this file to fit the project)
#
# Usage:
#   - `make` or `make all` or `make release` to build the project
#   - `make debug` to build the project with debug flags
#   - `make clean` to remove built binaries
#   - `make format` to format the source code
#   - `make lint` to lint the source code
#   - `make zip` to create a zip archive of the project
#   - `make help` to show Makefile usage
#
###############################################################################

TARGET                 = ixx-projekt
ZIPNAME                = xlogin00.zip

CC                     = gcc
CPP                    = g++
LATEX			   = pdftex
CFLAGS                 = -std=c99
CPPFLAGS               = -std=c++20
EXTRA_CXFLAGS          = -Wall -Wextra -Werror -pedantic \
				-fdata-sections -ffunction-sections
RELEASE_CXFLAGS        = -DNDEBUG -O2 -flto -march=native
DEBUG_CXFLAGS          = -g -Og -fsanitize=undefined
# ...                  = ...
LINT_FLAGS             = --format-style=file --fix \
				-checks="bugprone-*,google-*,performance-*,readability-*"
RM 			        = rm -f

SRCS                   = $(wildcard *.cpp)

###############################################################################

.PHONY: all release debug help clean zip lint format

all: release

release: EXTRA_CXFLAGS += ${RELEASE_CXFLAGS}
release: ${TARGET}

debug: EXTRA_CXFLAGS += ${DEBUG_CXFLAGS}
debug: ${TARGET}

${TARGET}: ${SRCS}
	${CPP} ${CPPFLAGS} ${EXTRA_CXFLAGS} ${SRCS} -o ${TARGET}
	@echo "projcpp compiled!"
	@echo "Run with: ./projcpp -s omething"

help:
	@echo "IXX-Project (Template Makefile)"
	@echo "@author Something Interesting <xlogin00@vutbr.cz>"
	@echo ""
	@echo "Usage: make [TARGET]"
	@echo "TARGETs:"
	@echo "  all     compile and link the project (default)"
	@echo "  debug   compile and link the project with debug flags"
	@echo "  clean   clean objects and executables"
	@echo "  format  run formatter"
	@echo "  lint    run linter"
	@echo "  zip     create a .zip archive with the source files"
	@echo "  help    print this message"

clean:
	${RM} ${TARGET}

zip:
	zip -q -r ${ZIPNAME}.zip *.cpp *.hpp Makefile

format:
	clang-format -i *.cpp *.hpp

lint:
	clang-tidy ${SRCS} ${LINT_FLAGS} -- ${CFLAGS}
