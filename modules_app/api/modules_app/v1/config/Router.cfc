component {

	function configure(){
		route( "/", "echo.index" );
		route( "/:handler/:action" ).end();
	}

}
