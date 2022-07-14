component {

	function configure(){
		// CRUD
		get( "/rants", "rants.list" )
		get( "/rants/:rantID", "rants.view" )
		post( "/rants/create", "rants.create" )
		delete( "/rants/:rantID/delete", "rants.delete" )
		put( "/rants/:rantID/save", "rants.save" )

		// Entry Point
		route( "/", "echo.index" );
	}

}
