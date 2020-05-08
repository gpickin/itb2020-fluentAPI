/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component extends="api.handlers.BaseHandler" {

	// DI
	property name="rantService" inject="RantService@v4";
	property name="userService" inject="UserService@v4";


	/**
	 * Returns a list of Rants
	 */
	any function index( event, rc, prc ) {
		prc.response.setData( rantService.listArray() );
		// prc.response.setData(
		// 	rantService.list().map( function( rant ) {
		// 		return rant.getMemento();
		// 	})
		// );
	}

	/**
	 * Returns a single Rant
	 *
	 */
	function show( event, rc, prc ) {
		var validationResults = validateOrFail(
			target = rc,
			constraints = { rantID: { required: true, type: "numeric" } }
		);
		prc.response.setData( rantService.getOrFail( rc.rantID ).getMemento() )
	}

	/**
	 * Deletes a single Rant
	 *
	 */
	function delete( event, rc, prc ) {
		var validationResults = validateOrFail(
			target = rc,
			constraints = { rantID: { required: true, type: "numeric" } }
		);
		rantService.existsOrFail( rc.rantID )
		var result = rantService.delete( rc.rantID );
		prc.response.addMessage( "Rant deleted" );
	}

	/**
	 * Creates a new Rant
	 *
	 */
	function create( event, rc, prc ) {
		var validationResults = validateOrFail(
			target = rc,
			constraints = { userID: { required: true, type: "numeric" }, body: { required: true } }
		);
		userService.existsOrFail( rc.userID );
		var rant = rantService.new();
		rant.setBody( rc.body );
		rant.setUserID( rc.userID );
		// var rant = populateModel( rantService.new() );
		validate(
			target = rant,
			constraints = { body: { required: true }, userID: { required: true, type: "numeric" } }
		);

		var result = rantService.create( rant );
		prc.response.setData( { "rantID": result.getID() } );
		prc.response.addMessage( "Rant created" );
	}

	/**
	 * Updates an Existing Rant
	 *
	 */
	function update( event, rc, prc ) {
		var validationResults = validateOrFail(
			target = rc,
			constraints = {
				rantID: { required: true, type: "numeric" },
				body: { required: true },
				userID: { required: true, type: "numeric" }
			}
		);

		rantService.existsOrFail( rc.rantID );
		userService.existsOrFail( rc.userID );

		var rant = rantService.getOrFail( rc.rantID );
		// rant.setBody( rc.body );
		// rant.setUserID( rc.userID );
		// rant.setID( rc.rantID )

		var rant = populateModel( model = rantService.new() );
		rant.setID( rc.rantID )
		validate(
			target = rant,
			constraints = {
				id: { required: true, type: "numeric" },
				body: { required: true },
				userID: { required: true, type: "numeric" }
			}
		);
		var result = rantService.update( rant );
		prc.response.addMessage( "Rant Updated" );
	}

}
