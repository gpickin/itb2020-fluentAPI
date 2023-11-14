component extends="coldbox.system.testing.BaseTestCase" appMapping="/root" {

	// Do not unload per test bundle to improve performance.
	this.unloadColdBox = false;

/*********************************** LIFE CYCLE Methods ***********************************/

	/**
	 * executes before all suites+specs in the run() method
	 */
	function beforeAll(){
		super.beforeAll();

		var lengthTest =

        addMatchers( {
            toHaveStatusCode : function( expectation, args = {} ) {
                // handle both positional and named arguments
                param args.statusCode = "";
                if ( structKeyExists( args, 1 ) ) {
                    args.statusCode = args[ 1 ];
                }
                param args.message = "";
                if ( structKeyExists( args, 2 ) ) {
                    args.message = args[ 2 ];
                }

                if ( args.statusCode == "" ) {
                    expectation.message = "No status code provided.";
                    return false;
                }

                try {
                    var statusCode = expectation.actual.getStatusCode();
                }
                catch ( any e ) {
                    expectation.message = "[#expecation.actual#] does not have a getStatusCode method.";
                    debug( expectation.actual.getResponse() );
                    return false;
                }

                if ( statusCode != args.statusCode ) {
                    expectation.message = "#args.message#. Received incorrect status code. Expected [#args.statusCode#]. Received [#statusCode#].";
                    debug( expectation.actual.getResponse() );
                    return false;
                }

                return true;
			},

			toHaveKeyWithCase : function( expectation, args = {} ) {
                // handle both positional and named arguments
                param args.key = "";
                if ( structKeyExists( args, 1 ) ) {
                    args.key = args[ 1 ];
                }
                param args.message = "";
                if ( structKeyExists( args, 2 ) ) {
                    args.message = args[ 2 ];
                }

                if ( args.key == "" ) {
                    expectation.message = "No Key Provided.";
                    return false;
                }

				if( !listFind( expectation.actual.keyList(), args.key ) ){
					if( listFindNoCase( expectation.actual.keyList(), args.key ) ){
						expectation.message = "The key(s) [#args.key#] does exist in the target object, but the Case is incorrect. Found keys are [#structKeyArray( expectation.actual ).toString()#]";
					} else {
						expectation.message = "The key(s) [#args.key#] does not exist in the target object, with or without case sensitivity. Found keys are [#structKeyArray( expectation.actual ).toString()#]";
					}
					debug( expectation.actual );
					return false;
				}

                return true;
			},

			toHaveLengthGT : function( expectation, args = {}, lengthTest=variables.lengthTest ) {
				args[ "operator" ] = "GT";
				return arguments.lengthTest( expectation, args );
			},

			toHaveLengthGTE : function( expectation, args = {}, lengthTest=variables.lengthTest ) {
				args[ "operator" ] = "GTE";
				return arguments.lengthTest( expectation, args );
			},

			toHaveLengthLT : function( expectation, args = {}, lengthTest=variables.lengthTest ) {
				args[ "operator" ] = "LT";
				return arguments.lengthTest( expectation, args );
			},

			toHaveLengthLTE : function( expectation, args = {}, lengthTest=variables.lengthTest ) {
				args[ "operator" ] = "LTE";
				return arguments.lengthTest( expectation, args );
			}
		} );

		getWireBox().autowire( this );
	}

	/**
	 * A length test
	 */
	private function lengthTest( expectation, args = {} ) {
		// handle both positional and named arguments
		param args.value = "";
		if ( structKeyExists( args, 1 ) ) {
			args.value = args[ 1 ];
		}

		param args.message = "";
		if ( structKeyExists( args, 2 ) ) {
			args.message = args[ 2 ];
		}

		param args.operator = "GT";
		if ( structKeyExists( args, 3 ) ) {
			args.value = args[ 3 ];
		}

		if ( !isNumeric( args.value )) {
			expectation.message = "The value you are testing must be a valid number";
			return false;
		}
		try{
			var length = expectation.actual.len();
		} catch ( any e ){
			expectation.message = "The length of the Item could not be found";
			return false;
		}

		if( args.operator == "GT" && length <= args.value ){
			expectation.message = "The length of the item was #length# - that is not GT #args.value#";
			debug( expectation.actual );
			return false;
		} else if( args.operator == "GTE" && length < args.value ){
			expectation.message = "The length of the item was #length# - that is not GTE #args.value#";
			debug( expectation.actual );
			return false;
		} else if( args.operator == "LT" && length >= args.value ){
			expectation.message = "The length of the item was #length# - that is not LT #args.value#";
			debug( expectation.actual );
			return false;
		} else if( args.operator == "LTE" && length > args.value ){
			expectation.message = "The length of the item was #length# - that is not LTE #args.value#";
			debug( expectation.actual );
			return false;
		}

		return true;
	};

	/**
	 * executes after all suites+specs in the run() method
	 */
	function afterAll(){
		super.afterAll();
	}

	/**
	 * Custom test reset
	 */
	function reset(){
		structDelete( application, "wirebox" );
		structDelete( application, "cbController" );
    }

	/**
	 * Rollback all testing, called by TestBox for me
	 *
	 * @spec The spec in test
	 * @suite The suite in test
	 */
	function withRollback( spec, suite ) aroundEach {
		transaction{
			try{
				return arguments.spec.body();
			} catch( any e ){
				rethrow;
			} finally{
				transaction action="rollback";
			}
		}
	}

}
