component {

	function configure() {
		resources( resource = "rants", parameterName = "rantID", except = [ "new", "edit" ] );

		route( "/", "echo.index" );
		route( "/:handler/:action" ).end();
	}

}
