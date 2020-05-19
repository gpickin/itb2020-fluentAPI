component {

	function configure(){
		post( "/rants/create", "rants.create" )
		route( "/rants/:rantID/delete", "rants.delete" )
		route( "/rants/:rantID/save", "rants.save" )
		get( "/rants/:rantID", "rants.view" )
		route( "/rants", "rants.list" )
		route( "/", "echo.index" );
		route( "/:handler/:action" ).end();
	}

}
