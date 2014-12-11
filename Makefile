
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


# KARMA #

KARMA ?= ./node_modules/karma/bin/karma
KARMA_PORT ?= 9876
KARMA_REPORTERS ?= mocha
KARMA_BROWSERS ?= Chrome
KARMA_LOG_LEVEL ?= info


# BUILD #

BUILD ?= ./bin/build
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

.PHONY: test test-watch
.PHONY: test-karma-mocha
.PHONY: test-karma-mocha-watch

test: test-karma-mocha

test-watch: test-karma-mocha-watch

test-karma-mocha: node_modules
	$(KARMA) start \
		--single-run \
		--colors \
		--port $(KARMA_PORT) \
		--browsers $(KARMA_BROWSERS) \
		--reporters $(KARMA_REPORTERS) \
		--log-level $(KARMA_LOG_LEVEL) \
		--no-auto-watch

test-karma-mocha-watch: node_modules
	$(KARMA) start \
		--colors \
		--port $(KARMA_PORT) \
		--browsers $(KARMA_BROWSERS) \
		--reporters $(KARMA_REPORTERS) \
		--log-level $(KARMA_LOG_LEVEL) \
		--auto-watch


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

install-bower:
	$(BOWER) install



# BUILD #

.PHONY: build

build: node_modules
	$(BUILD)


# CLEAN #

.PHONY: clean
.PHONY: clean-build clean-node clean-bower

clean: clean-build clean-node clean-bower

clean-build:
	rm -rf build
	rm $(BUILD_OUT)

clean-node:
	rm -rf node_modules

clean-bower:
	rm -rf bower
