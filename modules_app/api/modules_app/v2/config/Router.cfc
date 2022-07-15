component {

	function configure(){
		// CRUD
		post( "/rants/create", "rants.create" )
		delete( "/rants/:rantId/delete", "rants.delete" )
		put( "/rants/:rantId/save", "rants.save" )
		get( "/rants/:rantId", "rants.view" )
		get( "/rants", "rants.list" )

		// Entry Point
		route( "/", "echo.index" );
	}

}
