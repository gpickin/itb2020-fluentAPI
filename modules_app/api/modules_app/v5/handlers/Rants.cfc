/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component extends="coldbox.system.RestHandler" {

	// DI
	property name="rantService" inject="RantService@v5";
	property name="userService" inject="UserService@v5";

	this.prehandler_only = "show,delete,update";
	any function preHandler( event, rc, prc, action, eventArguments ){
		try {
			validateOrFail( target = rc, constraints = { rantId : { required : true, type : "numeric" } } );
		} catch ( any e ) {
			arguments.exception = e;
			this.onValidationException( argumentCollection = arguments );
		}
	}

	/**
	 * Returns a list of Rants
	 */
	any function index( event, rc, prc ){
		prc.response.setData( rantService.list().map( ( rant ) => rant.getMemento() ) );
	}

	/**
	 * Returns a single Rant
	 *
	 */
	function show( event, rc, prc ){
		prc.response.setData( rantService.getOrFail( rc.rantId ).getMemento() );
	}

	/**
	 * Deletes a single Rant
	 *
	 */
	function delete( event, rc, prc ){
		rantService.getOrFail( rc.rantId ).delete();

		prc.response.addMessage( "Rant deleted" );
	}

	/**
	 * Creates a new Rant
	 */
	function create( event, rc, prc ){
		var result = rantService
			.new( rc )
			.validateOrFail()
			.save();

		prc.response.setData( { "rantId" : result.getID() } ).addMessage( "Rant created" );
	}

	/**
	 * Updates an Existing Rant
	 *
	 */
	function update( event, rc, prc ){
		rantService
			.getOrFail( rc.rantId )
			.populate( memento = rc, exclude = "id" )
			.validateOrFail()
			.save();

		prc.response.addMessage( "Rant Updated" );
	}

}
