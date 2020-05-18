/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component extends="coldbox.system.RestHandler" {

	// DI
	property name="rantService" inject="RantService@v3";
	property name="userService" inject="UserService@v3";


	/**
	 * Returns a list of Rants
	 */
	any function index( event, rc, prc ){
		prc.response.setData( rantService.list() );
	}

	/**
	 * Returns a single Rant
	 *
	 */
	function show( event, rc, prc ){
		validateOrFail(
			target      = rc,
			constraints = {
				rantID : { required : true, type : "numeric" }
			}
		);
		prc.response.setData( rantService.getOrFail( rc.rantID ) );
	}

	/**
	 * Deletes a single Rant
	 *
	 */
	function delete( event, rc, prc ){
		var validationResults = validateOrFail(
			target      = rc,
			constraints = {
				rantID : { required : true, type : "numeric" }
			}
		);
		rantService.existsOrFail( rc.rantID )
		rantService.delete( rc.rantID );
		prc.response.addMessage( "Rant deleted" );
	}

	/**
	 * Creates a new Rant
	 *
	 */
	function create( event, rc, prc ){
		validateOrFail(
			target      = rc,
			constraints = {
				userID : { required : true, type : "numeric" },
				body   : { required : true }
			}
		);
		userService.existsOrFail( rc.userID );
		var result = rantService.create( body = rc.body, userID = rc.userID );
		prc.response.setData( { "rantID" : result.generatedKey } );
		prc.response.addMessage( "Rant created" );
	}

	/**
	 * Updates an Existing Rant
	 *
	 */
	function update( event, rc, prc ){
		validateOrFail(
			target      = rc,
			constraints = {
				rantID : { required : true, type : "numeric" },
				body   : { required : true },
				userID : { required : true, type : "numeric" }
			}
		);

		rantService.existsOrFail( rc.rantID );
		userService.existsOrFail( rc.userID );

		rantService.update(
			body   = rc.body,
			userID = rc.userID,
			rantID = rc.rantID
		);

		prc.response.addMessage( "Rant Updated" );
	}

}
