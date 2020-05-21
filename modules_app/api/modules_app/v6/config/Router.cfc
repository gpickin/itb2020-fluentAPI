component {

	function configure(){
		// Echo
		route( "/", "echo.index" )

		// Type the ID to numeric
		resources(
			resource      = "rants",
			parameterName = "rantID-numeric",
			except        = [ "new", "edit" ]
		)


		// Catch All Invalid Routes
		route( "/:anything", "Echo.onInvalidRoute" )
	}

}
