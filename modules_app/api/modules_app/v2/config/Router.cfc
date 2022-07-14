component {

	function configure(){
		// CRUD
		post( "/rants/create", "rants.create" )
		delete( "/rants/:rantID/delete", "rants.delete" )
		put( "/rants/:rantID/save", "rants.save" )
		get( "/rants/:rantID", "rants.view" )
		get( "/rants", "rants.list" )

		// Entry Point
		route( "/", "echo.index" );
	}

}
