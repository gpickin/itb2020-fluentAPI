/**
 * I am the User Service V2
 */
component singleton accessors="true" {

	/**
	 * Constructor
	 */
	UserService function init(){
		return this;
	}

	struct function get( required string userId ){
		return queryExecute(
			"select * from users
				where id = :userId",
			{ userId : arguments.userId }
		).reduce( ( result, row ) => row, {} );
	}

	boolean function exists( required string userId ){
		return booleanFormat(
			queryExecute(
				"select id from users
					where id = :userId",
				{ userId : arguments.userId }
			).len()
		)
	}

}
