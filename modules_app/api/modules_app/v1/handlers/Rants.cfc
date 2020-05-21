/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component extends="coldbox.system.RestHandler" {

	// DI
	property name="rantService" inject="RantService@v1";
	property name="userService" inject="UserService@v1";


	/**
	 * Returns a list of Rants
	 */
	any function list( event, rc, prc ){
		var rants = rantService.list();
		prc.response.setData( rants );
	}

	/**
	 * Returns a single Rant
	 *
	 */
	function view( event, rc, prc ){
		if ( !structKeyExists( rc, "rantID" ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "rantID is required" );
			return;
		}
		if ( !isNumeric( rc.rantID ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "rantID must be numeric" );
			return;
		}
		var rant = rantService.getRant( rc.rantID );

		if ( rant.len() ) {
			prc.response.setData( queryGetRow( rant, 1 ) );
		} else {
			prc.response.setError( true );
			prc.response.setStatusCode( 404 );
			prc.response.addMessage( "Error loading Rant - Rant not found" );
		}
	}

	/**
	 * Deletes a single Rant
	 *
	 */
	function delete( event, rc, prc ){
		if ( !structKeyExists( rc, "rantID" ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "rantID is required" );
		} else if ( !isNumeric( rc.rantID ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "rantID must be numeric" );
		} else {
			var result = rantService.delete( rc.rantID );
			if ( result.recordcount > 0 ) {
				prc.response.addMessage( "Rant deleted" );
			} else {
				prc.response.setError( true );
				prc.response.setStatusCode( 404 );
				prc.response.addMessage( "Rant not found" );
			}
		}
	}

	/**
	 * Creates a new Rant
	 *
	 */
	function create( event, rc, prc ){
		if ( !structKeyExists( rc, "body" ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "Rant body is required" );
			return
		}
		if ( !rc.body.trim().len() ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "Rant body cannot be empty" );
			return
		}
		if ( !structKeyExists( rc, "userID" ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "userID is required" );
			return;
		}
		if ( !isNumeric( rc.userID ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "userID must be numeric" );
			return;
		}
		var user = userService.get( rc.userID )
		if ( !user.len() ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 404 );
			prc.response.addMessage( "User not found" );
			return;
		}
		var result = rantService.create( body = rc.body, userID = rc.userID );
		if ( result.recordcount ) {
			prc.response.setData( { "rantID" : result.generatedKey } );
			prc.response.addMessage( "Rant created" );
			return;
		} else {
			prc.response.setError( true );
			prc.response.setStatusCode( 500 );
			prc.response.addMessage( "Error creating Rant" );
			return;
		}
	}

	/**
	 * Updates an Existing Rant
	 *
	 */
	function save( event, rc, prc ){
		if ( !structKeyExists( rc, "body" ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "Rant body is required" );
			return
		}
		if ( !rc.body.trim().len() ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "Rant body cannot be empty" );
			return
		}
		if ( !structKeyExists( rc, "rantID" ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "rantID is required" );
			return
		}
		if ( !isNumeric( rc.rantID ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "rantID must be numeric" );
			return
		}
		var rant = rantService.getRant( rc.rantID )
		if ( !rant.len() ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 404 );
			prc.response.addMessage( "Rant not found" );
			return;
		}
		if ( !structKeyExists( rc, "userID" ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "userID is required" );
			return;
		}
		if ( !isNumeric( rc.userID ) ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 412 );
			prc.response.addMessage( "userID must be numeric" );
			return;
		}
		var user = userService.get( rc.userID )
		if ( !user.len() ) {
			prc.response.setError( true );
			prc.response.setStatusCode( 404 );
			prc.response.addMessage( "User not found" );
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
			prc.response.setError( true );
			prc.response.setStatusCode( 500 );
			prc.response.addMessage( "Error updating Rant" );
			return;
		}
	}

}
