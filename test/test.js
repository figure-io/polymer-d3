/* global chai, describe, it, beforeEach */
'use strict';

// TESTS //

describe( 'polymer-d3', function tests() {

	var expect = chai.expect;

	// SETUP //

	var el;

	beforeEach( function beforeEach() {
		el = document.createElement( 'polymer-d3' );
	});

	// TESTS //

	it( 'should expose D3', function test() {
		var d3 = el.d3;
		expect( d3 ).to.be.a( 'function' );
		expect( d3.select ).to.be.a( 'function' );
		expect( d3.svg.axis ).to.be.a( 'function' );
		expect( d3.svg.line ).to.be.a( 'function' );
	});

});
