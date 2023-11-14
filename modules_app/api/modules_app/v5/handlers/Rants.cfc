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
	property name="rantService" inject="RantService@v5";
	property name="userService" inject="UserService@v5";

	this.prehandler_only = "show,delete,update";
	any function preHandler( event, rc, prc, action, eventArguments ){
		param rc.rantId = "";
	}

	/**
	 * Returns a list of Rants
	 */
	any function index( event, rc, prc ){
		prc.response.setData( rantService.list().map( ( rant ) => rant.getMemento() ) );
	}

	/**
	 * Returns a single Rant
	 */
	function show( event, rc, prc ){
		prc.response.setData( rantService.getOrFail( rc.rantId ).getMemento() );
	}

	/**
	 * Deletes a single Rant
	 */
	function delete( event, rc, prc ){
		rantService.getOrFail( rc.rantId ).delete();
		prc.response.addMessage( "Rant deleted" );
	}

	/**
	 * Creates a new Rant
	 */
	function create( event, rc, prc ){
		var rant = rantService
			.new( rc )
			.validateOrFail()
			.save();
		prc.response.setData( rant.getMemento() ).addMessage( "Rant created" );
	}

	/**
	 * Updates an Existing Rant
	 *
	 */
	function update( event, rc, prc ){
		var rant = rantService
			.getOrFail( rc.rantId )
			.populate( memento = rc, exclude = "id" )
			.validateOrFail()
			.save();
		prc.response.setData( rant.getMemento() ).addMessage( "Rant Updated" );
	}

}
