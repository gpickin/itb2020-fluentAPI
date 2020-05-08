/**
 * My RESTFul Rants Event Handler which inherits from the module `api`
 */
component displayName="Rants" extends="api.handlers.BaseHandler" {

	// DI
	property name="rantService" inject="RantService@v6";
	property name="userService" inject="UserService@v6";


	/**
	 * @route (GET) /api/v6/rants
	 *
	 * Returns a list of Rants
	 *
	 * @response-200 /resources/apidocs/api-v6/Rants/index/responses.json##200
	 */
	any function index( event, rc, prc ) {
		prc.response.setData( rantService.listArray() );
	}

	/**
	 * @route (GET) /api/v6/rants/:rantID
	 *
	 * Display a single Rant.
	 *
	 * @x-parameters /resources/apidocs/api-v6/Rants/show/parameters.json##parameters
	 * @response-200 /resources/apidocs/api-v6/Rants/show/responses.json##200
	 * @response-404 /resources/apidocs/_responses/rant.404.json
	 */
	function show( event, rc, prc ) {
		var validationResults = validateOrFail(
			target = rc,
			constraints = { rantID: { required: true, type: "numeric" } }
		);
		prc.response.setData( rantService.getOrFail( rc.rantID ).getMemento() )
	}

	/**
	 * @route (DELETE) /api/v6/rants/:rantID
	 *
	 * Delete a single Rant.
	 *
	 * @x-parameters /resources/apidocs/api-v6/Rants/delete/parameters.json##parameters
	 * @response-200 /resources/apidocs/api-v6/Rants/delete/responses.json##200
	 * @response-404 /resources/apidocs/_responses/rant.404.json
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
	 * @route (POST) /api/v1/rants
	 *
	 * Creates a new Rant.
	 *
	 * @requestBody /resources/apidocs/api-v6/Rants/create/requestBody.json
	 * @response-200 /resources/apidocs/api-v6/Rants/create/responses.json##200
	 * @response-412 /resources/apidocs/api-v6/Rants/create/responses.json##412
	 */
	function create( event, rc, prc ) {
		var validationResults = validateOrFail(
			target = rc,
			constraints = rantService.getConstraints()
		);
		userService.existsOrFail( rc.userID );
		var result = rantService
			.new( validationResults )
			.validateOrFail( rantService.getConstraints() )
			.save();
		prc.response.setData( { "rantID": result.getID() } );
		prc.response.addMessage( "Rant created" );
	}

	/**
	 * @route (PUT) /api/v1/rants/:rantID
	 *
	 * Update an existing Rant.
	 *
	 * @requestBody /resources/apidocs/api-v6/Rants/update/requestBody.json
	 * @response-200 /resources/apidocs/api-v6/Rants/update/responses.json##200
	 * @response-412 /resources/apidocs/api-v6/Rants/update/responses.json##412
	 */
	function update( event, rc, prc ) {
		var validationResults = validateOrFail(
			target = rc,
			constraints = rantService.addConstraints( {
				rantID: { required: true, type: "numeric" }
			} )
		);
		userService.existsOrFail( rc.userID );
		rantService
			.getOrFail( rc.rantID )
			.populate( validationResults )
			.setID( rc.rantID )
			.validateOrFail(
				constraints = rantService.addConstraints( {
					ID: { required: true, type: "numeric" }
				})
			)
			.save();
		prc.response.addMessage( "Rant Updated" );
	}

}
