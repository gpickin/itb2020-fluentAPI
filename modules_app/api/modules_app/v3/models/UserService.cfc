/**
 * I am the User Service v3
 */
component
	extends="v3.models.BaseService"
	singleton
	accessors="true"
{

	/**
	 * Constructor
	 */
	UserService function init(){
		super.init(
			entityName    = "user",
			tableName     = "users",
			parameterName = "userID",
			moduleName    = "v3"
		)
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
		).reduce( ( result, row ) => row, {} );
	}

}
