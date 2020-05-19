component {

	function configure(){
		resources(
			resource      = "rants",
			parameterName = "rantID-numeric",
			except        = [ "new", "edit" ]
		);

		route( "/", "echo.index" );
		route( "/:handler/:action" ).end();
	}

}
