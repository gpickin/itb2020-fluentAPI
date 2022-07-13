component {

    function up( schema, query ) {
		schema.create( "users", ( table ) => {
			table.string( "id" ).primaryKey();
			table.string( "username" ).unique();
			table.string( "email" ).unique();
			table.string( "password" );
			table.datetime( "createdDate" ).withCurrent();
			table.datetime( "updatedDate" ).withCurrent();
		} );
    }

    function down( schema, query ) {
		schema.drop( "users" );
    }

}
