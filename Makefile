
#############
# VARIABLES #

# Set the node.js environment to test:
NODE_ENV ?= test


# NOTES #

NOTES ?= 'TODO|FIXME|WARNING|HACK|NOTE'


# DOCS #

# DOCS ?= ./docs/index.html


# BOWER #

BOWER ?= ./node_modules/.bin/bower


# BROWSERIFY #

BROWSERIFY ?= ./node_modules/.bin/browserify
BROWSERIFY_IN ?= ./build/js/tmp.js
BROWSERIFY_OUT ?= ./build/js/script.js


# VULCANIZE #

VULCANIZE ?= ./node_modules/.bin/vulcanize
VULCANIZE_CONF ?= ./vulcanize.conf.json
VULCANIZE_IN ?= ./build/polymer-d3.html
VULCANIZE_OUT ?= ./polymer-d3.html


# WEB COMPONENT TESTER #

WCT ?= ./node_modules/.bin/wct


# BUILD #

BUILD_OUT ?= polymer-d3.html


# JSHINT #

JSHINT ?= ./node_modules/.bin/jshint
JSHINT_REPORTER ?= ./node_modules/jshint-stylish/stylish.js



# FILES #

# Source files:
SOURCES ?= src/*.js src/**/*.js

# Test files:
TESTS ?= test/*.js




###########
# TARGETS #


# NOTES #

.PHONY: notes

notes:
	grep -Ern $(NOTES) $(SOURCES) $(TESTS)


# DOCS #

# .PHONY: view-docs

# view-docs:
# 	open $(DOCS)


# UNIT TESTS #

.PHONY: test
.PHONY: test-wct

test: test-wct

test-wct: node_modules
	$(WCT)


# LINT #

.PHONY: lint lint-jshint

lint: lint-jshint

lint-jshint: node_modules
	$(JSHINT) \
		--reporter $(JSHINT_REPORTER) \
		./



# INSTALL #

.PHONY: install
.PHONY: install-node install-bower install-vulcanize

install: install-node install-bower install-vulcanize

install-node:
	npm install

install-bower: node_modules
	$(BOWER) install



# BUILD #

.PHONY: build
.PHONY: build-tmp build-cleanup

build: node_modules clean-build build-tmp browserify vulcanize build-cleanup

build-tmp:
	mkdir build
	cp -r ./src/ ./build
	mv $(BROWSERIFY_OUT) $(BROWSERIFY_IN)

build-cleanup:
	rm -rf build


# BROWSERIFY #

.PHONY: browserify

browserify: node_modules
	$(BROWSERIFY) \
		$(BROWSERIFY_IN) \
		-o $(BROWSERIFY_OUT)


# VULCANIZE #

.PHONY: vulcanize

vulcanize: node_modules
	$(VULCANIZE) \
		$(VULCANIZE_IN) \
		--config $(VULCANIZE_CONF) \
		-o $(VULCANIZE_OUT) \
		--inline \
		--no-strip-excludes


# CLEAN #

.PHONY: clean
.PHONY: clean-build clean-node clean-bower

clean: clean-build clean-node clean-bower

clean-build:
	rm -rf build
	rm -f $(BUILD_OUT)

clean-node:
	rm -rf node_modules

clean-bower:
	rm -rf bower
