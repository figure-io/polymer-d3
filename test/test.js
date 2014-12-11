/* global suite, test, assert, expect */
'use strict';

// TESTS //

suite( 'polymer-d3', function tests() {

	// SETUP //

	var el = document.querySelector( '#d3' );

	test( 'should expose D3', function test() {
		var d3 = el.d3;
		assert.ok( el );
		expect( d3 ).to.be.an( 'object' );
		expect( d3.select ).to.be.a( 'function' );
		expect( d3.svg.axis ).to.be.a( 'function' );
		expect( d3.svg.line ).to.be.a( 'function' );
	});

});
