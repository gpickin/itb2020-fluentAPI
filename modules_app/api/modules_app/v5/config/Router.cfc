component {

	function configure(){
		resources(
			resource      = "rants",
			parameterName = "rantId",
			except        = [ "new", "edit" ]
		);

		route( "/", "echo.index" );
		route( "/:handler/:action" ).end();
	}

}
