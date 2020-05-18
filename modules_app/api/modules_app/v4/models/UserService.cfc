/**
 * I am the User Service V4
 */
component
	extends="v4.models.BaseService"
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
			moduleName    = "v4"
		)
		return this;
	}

	/**
	 * Let WireBox build new Rant objects for me
	 */
	User function new() provider="User@v4"{
	}

	User function get( required numeric userID ){
		var q = queryExecute(
			"select * from users
			where id = :userID",
			{
				userID : {
					value : "#userID#",
					cfsqltype  : "cf_sql_numeric"
				}
			}
		).reduce( ( result, row ) => populator.populateFromStruct( result, row ), new() );
	}

}
