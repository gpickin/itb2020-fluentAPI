component {

    function up( schema, query ) {
		schema.create( "rants", ( table ) => {
			table.string( "id" ).primaryKey()
			table.text( "body" )
			table.datetime( "createdDate" ).withCurrent()
			table.datetime( "updatedDate" ).withCurrent()
			table.string( "userId" );
			table.foreignKey( "userId" ).references( "id" ).onTable( "users" );
		} );
    }

    function down( schema, query ) {
		schema.drop( "rants" );
    }

}
