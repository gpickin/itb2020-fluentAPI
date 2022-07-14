/**
 * I am the User Service V1
 */
component singleton accessors="true" {

	/**
	 * Constructor
	 */
	UserService function init(){
		return this;
	}

	function get( required string userId ){
		return queryExecute(
			"select * from users
			where id = :userId",
			{ userId : arguments.userId }
		);
	}

}
