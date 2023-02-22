###############################################################################
#
# IXX-Projekt 1 Makefile
#
# Usage:
#   * `make` or `make all` to build the project (default)
#   * `make clean` to remove built binaries
#   * `make format` to format the source code
#   * `make zip` to create a zip archive of the project
#   * `make help` to show Makefile usage
#
###############################################################################

TARGET                 = ixx-projekt1
ZIPNAME                = xonege99.zip

CC                     = gcc
CPP                    = g++
LATEX			   = pdftex
CFLAGS                 = -std=c99 -Wall -Wextra -Werror -pedantic
CPPFLAGS               = -std=c++20 -Wall -Wextra -Werror -pedantic
EXTRA_CXFLAGS           = -fdata-sections -ffunction-sections -O3 -g
# ...
RM 			        = rm -f

SRCS                   = $(wildcard *.c)

###############################################################################

.PHONY: all help clean zip format

all:
	${CC} ${CFLAGS} ${EXTRA_CXFLAGS} ${SRCS} -o ${TARGET}
	${CPP} ${CPPFLAGS} ${EXTRA_CXFLAGS} ${SRCS} -o ${TARGET}
	@echo "projc & projcpp compiled!"
	@echo "Run projc with: ./projc -s omething"
	@echo "Run projcpp with: ./projcpp -w hatever"

help:
	@echo "IXX-Project (Template Makefile)"
	@echo "@author Onegen Something <xonege99@vutbr.cz>"
	@echo ""
	@echo "Usage: make [TARGET]"
	@echo "TARGETs:"
	@echo "  all     compile and link the project (default)"
	@echo "  clean   clean objects and executables"
	@echo "  zip     create a .zip archive with the source files"
	@echo "  help    print this message"
	@echo "  format  run formatter"

clean:
	${RM} ${TARGET}
	@echo "Cleaned!"

zip:
	zip -q -r ${ZIPNAME}.zip *.c *.h Makefile
	zip -q -r ${ZIPNAME}.zip *.cpp *.hpp Makefile
	@echo "Created archive ${ZIPNAME}.zip"

format:
	clang-format -i *.c *.h
	clang-format -i *.cpp *.hpp
	@echo "Formatted source files!"
