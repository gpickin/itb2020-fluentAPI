component {

	function configure(){
		// API Based Resourceful Routes:
		// https://coldbox.ortusbooks.com/the-basics/routing/routing-dsl/resourceful-routes#api-resourceful-routes
		apiResources( resource = "rants", parameterName = "rantId" );

		// Catch All Invalid Routes
		route( "/:anything", "Echo.onInvalidRoute" );

		// Entry Point
		route( "/", "echo.index" );
	}

}
