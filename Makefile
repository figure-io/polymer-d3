
#############
# VARIABLES #

# Component Name:
NAME ?= polymer-d3

# Distributable filename:
OUT ?= $(NAME).html

# Set the node.js environment to test:
NODE_ENV ?= test

# Kernel name:
KERNEL ?= $(shell uname -s)

ifeq ($(KERNEL), Darwin)
	OPEN ?= open
else
	OPEN ?= xdg-open
endif


# NOTES #

NOTES ?= 'TODO|FIXME|WARNING|HACK|NOTE'


# DOCS #

# DOCS ?= ./docs/index.html


# BOWER #

BOWER ?= ./node_modules/.bin/bower


# BROWSERIFY #

BROWSERIFY ?= ./node_modules/.bin/browserify
BROWSERIFY_BUILD_IN ?= ./build/js/polymer.js
BROWSERIFY_BUILD_OUT ?= ./build/js/script.js
BROWSERIFY_TEST_IN ?= ./build/js/polymer.js
BROWSERIFY_TEST_OUT ?= ./build/js/script.js


# VULCANIZE #

VULCANIZE ?= ./node_modules/.bin/vulcanize
VULCANIZE_BUILD_IN ?= ./build/$(NAME).html
VULCANIZE_BUILD_OUT ?= $(OUT)


# ISTANBUL #

ISTANBUL ?= ./node_modules/.bin/istanbul
ISTANBUL_OUT ?= ./reports/coverage
ISTANBUL_REPORT ?= lcov
ISTANBUL_LCOV_INFO_PATH ?= $(ISTANBUL_OUT)/lcov.info
ISTANBUL_HTML_REPORT_PATH ?= $(ISTANBUL_OUT)/lcov-report/index.html


# COVERALLS #

COVERALLS ?= ./node_modules/.bin/coveralls


# WEB COMPONENT TESTER #

WCT ?= ./node_modules/.bin/wct
# TODO: move WCT config file to /etc once issue https://github.com/Polymer/web-component-tester/issues/98 is resolved
WCT_CONF ?= ./wct.conf.js
WCT_SRC ?= ./src
WCT_TMP ?= ./build
WCT_VAR ?= 'window.parent.WCT.share.__coverage__'


# JSHINT #

JSHINT ?= ./node_modules/.bin/jshint
JSHINT_REPORTER ?= ./node_modules/jshint-stylish



# FILES #

# Source files:
SOURCES ?= src/*.js src/**/*.js

# Test files:
TESTS ?= test/*.js test/**/*.js




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
.PHONY: test-wct test-browserify test-tmp

test: test-wct

test-tmp: clean-test
	mkdir $(WCT_TMP)
	cp -a $(WCT_SRC)/. $(WCT_TMP)

test-browserify: node_modules
	$(BROWSERIFY) \
		$(BROWSERIFY_TEST_IN) \
		-o $(BROWSERIFY_TEST_OUT)

test-wct: node_modules test-tmp test-browserify
	$(WCT) \
		--plugin local



# CODE COVERAGE #

.PHONY: test-cov test-instrument
.PHONY: test-istanbul-wct
.PHONY: test-istanbul-instrument

test-cov: test-istanbul-wct

test-instrument: test-istanbul-instrument

test-istanbul-instrument: node_modules
	$(ISTANBUL) instrument \
		$(WCT_SRC) \
		-o $(WCT_TMP) \
		--variable $(WCT_VAR)

test-istanbul-wct: node_modules test-tmp test-instrument test-browserify
	$(WCT) \
		--plugin local



# COVERAGE REPORT #

.PHONY: view-cov view-istanbul-report

view-cov: view-istanbul-report

view-istanbul-report:
	$(OPEN) $(ISTANBUL_HTML_REPORT_PATH)



# REPORTING #

.PHONY: coveralls

coveralls: node_modules test-cov
	cat $(ISTANBUL_LCOV_INFO_PATH) | $(COVERALLS) && rm -rf $(ISTANBUL_OUT)



# LINT #

.PHONY: lint lint-jshint

lint: lint-jshint

lint-jshint: node_modules
	$(JSHINT) \
		--reporter $(JSHINT_REPORTER) \
		./



# INSTALL #

.PHONY: install
.PHONY: install-node install-bower

install: install-node install-bower

install-node:
	npm install

install-bower: node_modules
	$(BOWER) install



# BUILD #

.PHONY: build
.PHONY: build-tmp

build: node_modules build-tmp browserify vulcanize

build-tmp: clean-build
	mkdir build
	cp -a $(WCT_SRC)/. build


# BROWSERIFY #

.PHONY: browserify

browserify: node_modules
	$(BROWSERIFY) \
		$(BROWSERIFY_BUILD_IN) \
		-o $(BROWSERIFY_BUILD_OUT)


# VULCANIZE #

.PHONY: vulcanize

vulcanize: node_modules
	$(VULCANIZE) \
		$(VULCANIZE_BUILD_IN) \
		--inline-css \
		--inline-scripts \
		--strip-comments \
		> $(VULCANIZE_BUILD_OUT)



# CLEAN #

.PHONY: clean
.PHONY: clean-build clean-node clean-bower clean-test

clean: clean-build clean-node clean-bower clean-test

clean-build:
	rm -rf build
	rm -f $(OUT)

clean-test:
	rm -rf $(WCT_TMP)

clean-node:
	rm -rf node_modules

clean-bower:
	rm -rf bower
