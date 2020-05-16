/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component extends="coldbox.system.RestHandler" {

	// DI
	property name="rantService" inject="RantService@v5";
	property name="userService" inject="UserService@v5";


	/**
	 * Returns a list of Rants
	 */
	any function index( event, rc, prc ) {
		prc.response.setData( rantService.listArray() );
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
		rantService.getOrFail( rc.rantID ).delete();
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
		var result = rantService
			.new( validationResults )
			.validateOrFail( { body: { required: true }, userID: { required: true, type: "numeric" } } )
			.save();
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
		userService.existsOrFail( rc.userID );
		rantService
			.getOrFail( rc.rantID )
			.populate( validationResults )
			.setID( rc.rantID )
			.validateOrFail(
				constraints = {
					id: { required: true, type: "numeric" },
					body: { required: true },
					userID: { required: true, type: "numeric" }
				}
			)
			.save();
		prc.response.addMessage( "Rant Updated" );
	}

}
