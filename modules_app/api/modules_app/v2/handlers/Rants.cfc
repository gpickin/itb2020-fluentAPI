/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 * Since we inherit from the RestHandler we get lots of goodies like automatic HTTP method protection,
 * missing routes, invalid routes, and much more.
 *
 * @see https://coldbox.ortusbooks.com/digging-deeper/rest-handler
 * @see https://coldbox.ortusbooks.com/digging-deeper/rest-handler#rest-handler-security
 */
component extends="coldbox.system.RestHandler" {

	// DI
	property name="rantService" inject="RantService@v2";
	property name="userService" inject="UserService@v2";

	/**
	 * Returns a list of Rants
	 */
	any function list( event, rc, prc ){
		prc.response.setData( rantService.list() );
	}

	/**
	 * Returns a single Rant
	 */
	function view( event, rc, prc ){
		var validationResults = validate(
			target      = rc,
			constraints = { rantID : { required : true, type : "uuid" } }
		);
		if ( validationResults.hasErrors() ) {
			prc.response.setErrorMessage( validationResults.getAllErrors(), 412 );
			return;
		}
		var rant = rantService.get( rc.rantID );

		if ( !rant.isEmpty() ) {
			prc.response.setData( rant )
		} else {
			prc.response.setErrorMessage( "Error loading Rant - Rant not found", 404 );
		}
	}

	/**
	 * Deletes a single Rant
	 */
	function delete( event, rc, prc ){
		var validationResults = validate(
			target      = rc,
			constraints = { rantID : { required : true, type : "uuid" } }
		);
		if ( validationResults.hasErrors() ) {
			prc.response.setErrorMessage( validationResults.getAllErrors(), 412 );
			return;
		}

		var result = rantService.delete( rc.rantID );
		if ( result.recordcount > 0 ) {
			prc.response.addMessage( "Rant deleted" );
		} else {
			prc.response.setErrorMessage( "Rant not found", 404 );
		}
	}

	/**
	 * Creates a new Rant
	 */
	function create( event, rc, prc ){
		var validationResults = validate(
			target      = rc,
			constraints = {
				userID : { required : true, type : "uuid" },
				body   : { required : true }
			}
		);
		if ( validationResults.hasErrors() ) {
			prc.response.setErrorMessage( validationResults.getAllErrors(), 412 );
			return;
		}
		if ( !userService.exists( rc.userID ) ) {
			prc.response.setErrorMessage( "User not found", 404 );
			return;
		}
		var result = rantService.create( body = rc.body, userID = rc.userID );
		if ( result.recordcount ) {
			prc.response.setData( { "rantID" : result.generatedKey } );
			prc.response.addMessage( "Rant created" );
			return;
		} else {
			prc.response.setErrorMessage( "Error creating Rant", 500 );
			return;
		}
	}

	/**
	 * Updates an Existing Rant
	 */
	function save( event, rc, prc ){
		var validationResults = validate(
			target      = rc,
			constraints = {
				rantID : { required : true, type : "uuid" },
				body   : { required : true },
				userID : { required : true, type : "uuid" }
			}
		);
		if ( validationResults.hasErrors() ) {
			prc.response.setErrorMessage( validationResults.getAllErrors(), 412 );
			return;
		}

		if ( !rantService.exists( rc.rantID ) ) {
			prc.response.setErrorMessage( "Rant not found", 404 );
			return;
		}
		if ( !userService.exists( rc.userID ) ) {
			prc.response.setErrorMessage( "User not found", 404 );
			return;
		}
		var result = rantService.update(
			body   = rc.body,
			userID = rc.userID,
			rantID = rc.rantID
		);
		if ( result.recordcount ) {
			prc.response.addMessage( "Rant Updated" );
		} else {
			prc.response.setErrorMessage( "Error updating Rant", 500 );
			return;
		}
	}

}
