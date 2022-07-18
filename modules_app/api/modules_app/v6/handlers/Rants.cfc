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
	property name="rantService" inject="RantService@v6";
	property name="userService" inject="UserService@v6";

	/**
	 * Param global incoming variables for the endpoint
	 */
	any function preHandler( event, rc, prc, action, eventArguments ){
		param rc.rantId         = "";
		param rc.includes       = "";
		param rc.excludes       = "";
		param rc.ignoreDefaults = false;
	}

	/**
	 * Returns a list of Rants
	 *
	 * @x-route      (GET) /api/v6/rants
	 * @response-200 ~api-v6/Rants/index/responses.json##200
	 */
	any function index( event, rc, prc ) cache=true cacheTimeout=60{
		prc.response.setData(
			rantService
				.list()
				.map( ( rant ) => rant.getMemento(
					includes      : rc.includes,
					excludes      : rc.excludes,
					ignoreDefaults: rc.ignoreDefaults
				) )
		);
	}

	/**
	 * Return a single Rant by id
	 *
	 * @x-route      (GET) /api/v6/rants/:rantId
	 * @x-parameters ~api-v6/Rants/show/parameters.json##parameters
	 * @response-200 ~api-v6/Rants/show/responses.json##200
	 * @response-404 ~_responses/rant.404.json
	 */
	function show( event, rc, prc ) cache=true cacheTimeout=60{
		prc.response.setData(
			rantService
				.getOrFail( rc.rantId )
				.getMemento(
					includes      : rc.includes,
					excludes      : rc.excludes,
					ignoreDefaults: rc.ignoreDefaults
				)
		);
	}

	/**
	 * Delete a single Rant.
	 *
	 * @x-route      (DELETE) /api/v6/rants/:rantId
	 * @x-parameters ~api-v6/Rants/delete/parameters.json##parameters
	 * @response-200 ~api-v6/Rants/delete/responses.json##200
	 * @response-404 ~_responses/rant.404.json
	 */
	function delete( event, rc, prc ){
		rantService.getOrFail( rc.rantId ).delete();
		prc.response.addMessage( "Rant deleted" );
		getCache( "template" ).clearAllEvents();
	}

	/**
	 * Creates a new Rant.
	 *
	 * @x-route      (POST) /api/v1/rants
	 * @requestBody  ~api-v6/Rants/create/requestBody.json
	 * @response-200 ~api-v6/Rants/create/responses.json##200
	 * @response-400 ~api-v6/Rants/create/responses.json##400
	 */
	function create( event, rc, prc ){
		prc.response
			.setData(
				rantService
					.new( rc )
					.validateOrFail()
					.save()
					.getMemento(
						includes      : rc.includes,
						excludes      : rc.excludes,
						ignoreDefaults: rc.ignoreDefaults
					)
			)
			.addMessage( "Rant created" );

		getCache( "template" ).clearAllEvents();
	}

	/**
	 * Update an existing Rant.
	 *
	 * @x-route      (PUT) /api/v1/rants/:rantId
	 * @requestBody  ~api-v6/Rants/update/requestBody.json
	 * @response-200 ~api-v6/Rants/update/responses.json##200
	 * @response-400 ~api-v6/Rants/update/responses.json##400
	 */
	function update( event, rc, prc ){
		prc.response
			.setData(
				rantService
					.getOrFail( rc.rantId )
					.populate( memento = rc, exclude = "id" )
					.validateOrFail()
					.save()
					.getMemento(
						includes      : rc.includes,
						excludes      : rc.excludes,
						ignoreDefaults: rc.ignoreDefaults
					)
			)
			.addMessage( "Rant Updated" );

		getCache( "template" ).clearAllEvents();
	}

}
