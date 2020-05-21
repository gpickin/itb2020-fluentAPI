/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component extends="coldbox.system.RestHandler" {

	// DI
	property name="rantService" inject="RantService@v4";
	property name="userService" inject="UserService@v4";

	this.prehandler_only = "show,delete,update";

	any function preHandler( event, rc, prc, action, eventArguments ){
		try{
			validateOrFail(
				target      = rc,
				constraints = { rantID : { required : true, type : "numeric" } }
			);
		} catch( any e ){
			arguments.exception = e;
			this.onValidationException( argumentCollection = arguments );
		}
	}

	/**
	 * Returns a list of Rants
	 */
	any function index( event, rc, prc ){
		prc.response.setData(
			rantService.list().map( ( rant ) => rant.getMemento() )
		);
	}

	/**
	 * Returns a single Rant
	 */
	function show( event, rc, prc ){
		prc.response.setData( rantService.getOrFail( rc.rantID ).getMemento() );
	}

	/**
	 * Deletes a single Rant
	 *
	 */
	function delete( event, rc, prc ){
		rantService.existsOrFail( rc.rantID )
		rantService.delete( rc.rantID );
		prc.response.addMessage( "Rant deleted" );
	}

	/**
	 * Creates a new Rant
	 */
	function create( event, rc, prc ){
		var rant = rantService.new();

		validateOrFail(
			target      = rc,
			constraints = rant.constraints
		);

		userService.existsOrFail( rc.userID );

		rant.setBody( rc.body );
		rant.setUserID( rc.userID );

		rantService.create( rant );

		prc.response.setData( { "rantID" : rant.getID() } );
		prc.response.addMessage( "Rant created" );
	}

	/**
	 * Updates an Existing Rant
	 */
	function update( event, rc, prc ){
		var rant = rantService.getOrFail( rc.rantId );

		validateOrFail(
			target      = rc,
			constraints = rant.constraints
		);

		userService.existsOrFail( rc.userID );

		rant.setBody( rc.body );
		rant.setUserID( rc.userID );

		rantService.update( rant );

		prc.response.addMessage( "Rant Updated" );
	}

}
