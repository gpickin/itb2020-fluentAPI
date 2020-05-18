/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component extends="coldbox.system.RestHandler" {

	// DI
	property name="rantService" inject="RantService@v6";
	property name="userService" inject="UserService@v6";

	/**
	 * @x-route (GET) /api/v6/rants
	 *
	 * Returns a list of Rants
	 *
	 * @response-200 ~api-v6/Rants/index/responses.json##200
	 */
	any function index( event, rc, prc ) cache=true cacheTimeout=60{
		prc.response.setData(
			rantService.list().map( ( rant ) => rant.getMemento() )
		);
	}

	/**
	 * @x-route (GET) /api/v6/rants/:rantID
	 *
	 * Display a single Rant.
	 *
	 * @x-parameters ~api-v6/Rants/show/parameters.json##parameters
	 * @response-200 ~api-v6/Rants/show/responses.json##200
	 * @response-404 ~_responses/rant.404.json
	 */
	function show( event, rc, prc ) cache=true cacheTimeout=60{
		prc.response.setData(
			rantService.getOrFail( rc.rantID ).getMemento()
		);
	}

	/**
	 * @x-route (DELETE) /api/v6/rants/:rantID
	 *
	 * Delete a single Rant.
	 *
	 * @x-parameters ~api-v6/Rants/delete/parameters.json##parameters
	 * @response-200 ~api-v6/Rants/delete/responses.json##200
	 * @response-404 ~_responses/rant.404.json
	 */
	function delete( event, rc, prc ){
		rantService
			.getOrFail( rc.rantID  )
			.delete();

		prc.response.addMessage( "Rant deleted" );
	}

	/**
	 * @x-route (POST) /api/v1/rants
	 *
	 * Creates a new Rant.
	 *
	 * @requestBody ~api-v6/Rants/create/requestBody.json
	 * @response-200 ~api-v6/Rants/create/responses.json##200
	 * @response-400 ~api-v6/Rants/create/responses.json##400
	 */
	function create( event, rc, prc ){
		var result = rantService
			.new( rc )
			.validateOrFail()
			.save();

		prc.response
			.setData( { "rantID" : result.getID() } )
			.addMessage( "Rant created" );

		getCache( "template" ).clearAllEvents();
	}

	/**
	 * @x-route (PUT) /api/v1/rants/:rantID
	 *
	 * Update an existing Rant.
	 *
	 * @requestBody ~api-v6/Rants/update/requestBody.json
	 * @response-200 ~api-v6/Rants/update/responses.json##200
	 * @response-400 ~api-v6/Rants/update/responses.json##400
	 */
	function update( event, rc, prc ){
		rantService
			.getOrFail( rc.rantID )
			.populate( memento=rc, exclude="id" )
			.validateOrFail()
			.save();

		prc.response.addMessage( "Rant Updated" );

		getCache( "template" ).clearAllEvents();
	}

}