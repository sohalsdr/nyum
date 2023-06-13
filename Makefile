# Builds the site by running build script
build:
	bash build.sh

# Cleans up build directories and temporary directory
clean:
	rm -rf docs/*
	rm -rf temp/

# Builds the site by running build script, uns a Python webserver in the build directory
test:
	bash build.sh
	python -m http.server -d docs/

.PHONY: build clean test
