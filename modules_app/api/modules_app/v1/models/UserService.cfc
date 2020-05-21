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

	function get( required numeric userID ){
		return queryExecute(
			"select * from users
			where id = :userID",
			{
				userID : {
					value : "#userID#",
					type  : "cf_sql_numeric"
				}
			}
		);
	}

}
