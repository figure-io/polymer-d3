/**
*
*	KARMA: karma.conf.js
*
*
*	DESCRIPTION:
*		- Karma config file for running tests locally.
*
*
*	NOTES:
*		[1]
*
*
*	TODO:
*		[1]
*
*
*	LICENSE:
*		MIT
*
*	Copyright (c) 2014. Athan Reines.
*
*
*	AUTHOR:
*		Athan Reines. kgryte@gmail.com. 2014.
*
*/

'use strict';

// MODULES //

var path = require( 'path' ),
	browsers = require( './sauce-browsers.json' );


// CONFIG //

var config,
	root,
	dir;

// Serve from the directory above the current directory to allow loading of sibling dependencies:
root = path.resolve( __dirname, '../' );

// Set the location of the test suites:
dir = path.basename( __dirname );
dir = path.join( dir, 'test' );

// Create the web component test configuration...
config = {

	// Root directory from which files should be served:
	'root': root,

	// Location of test suites:
	'suites': [
		dir
	],

	// Browsers on which to test:
	'browsers': [
		'chrome'
	],

	// Whether the local or remote browsers should be targeted:
	'remote': true,

	// Whether the browser should remain open after running tests:
	'persistent': false,

	// Duration before which an idle test times out:
	'testTimeout': 90000,

	// Display test results in expanded form:
	'expanded': false,

	// Output verbosity:
	'verbose': false,

	// Output stream:
	'output': process.stdout,

	// Whether the output stream should be treated as TTY:
	'ttyOutput': undefined,

	// Additional scripts which should be included in the generated tests (see Selenium: https://code.google.com/p/selenium/wiki/DesiredCapabilities and Sauce: https://docs.saucelabs.com/reference/test-configuration/):
	'extraScripts': [],

	// Additional browser options for Selenium or Sauce:
	'browserOptions': {},

	// Sauce labs configuration:
	'sauce': {
		'username': undefined,
		'accessKey': undefined,

		// Tunnel id to reuse for tests:
		'tunnelId': undefined,

		// Advanced tunnel options (https://github.com/bermi/sauce-connect-launcher#advanced-usage):https://github.com/bermi/sauce-connect-launcher#advanced-usage
		'tunnelOptions': {}
	}
}; // end CONFIG


// EXPORTS //

module.exports = config;
