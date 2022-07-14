/**
 * I am the User Service
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
			{
				userId : arguments.userId
			}
		);
	}

}
