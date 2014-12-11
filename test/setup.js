/**
*
*	KARMA: setup
*
*
*	DESCRIPTION:
*		- Loads Polymer components for tests and configures Mocha.
*
*
*	NOTES:
*		[1] Karma currently does not allow Polymer to register elements. This script is a workaround.
*		[2] Based on Chris Strom's code from https://github.com/eee-c/eee-polymer-tests/blob/master/templates/PolymerSetup.js.
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

/* global document, Polymer, mocha, beforeEach */
(function() {
	'use strict';

	// VARIABLES //

	var path = '/base/polymer-d3.html',
		head,
		link;


	// HTML IMPORT //

	// Get the document head:
	head = document.getElementsByTagName( 'head' )[ 0 ];

	// Create an element which imports the Polymer element:
	link = document.createElement( 'link' );
	link.rel = 'import';
	link.href = path;
	head.appendChild( link );


	// MOCHA //

	mocha.setup({
		'slow': 1000,
		'timeout': 5000
	});


	// POLYMER //

	beforeEach( function setup( done ) {
		onReady();

		/**
		* FUNCTION: onReady()
		*	Determines if Polymer is initialized before proceeding with tests.
		*
		* @private
		*/
		function onReady() {
			if ( Polymer ) {
				if ( Polymer.whenReady ) {
					Polymer.whenReady( done );
				} else {
					if ( Polymer.whenPolymerReady ) {
						Polymer.whenPolymerReady( done );
					}
				}
				return;
			}
			setTimeout( onReady, 200 );
		} // end FUNCTION onReady()
	});

})();
