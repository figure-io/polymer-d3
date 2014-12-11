/**
*
*	COMPONENT: polymer-d3
*
*
*	DESCRIPTION:
*		- Registers the polymer-d3 web-component.
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

var d3 = require( 'd3/d3.min.js' );


// POLYMER //

/* global Polymer */
Polymer( 'polymer-d3', {
	/**
	* METHOD: d3
	*	Binds the dependency to the element.
	*/
	'd3': d3
});
