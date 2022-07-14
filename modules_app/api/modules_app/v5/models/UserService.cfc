/**
 * I am the User Service v5
 */
component
	extends="v5.models.BaseService"
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
			moduleName    = "v5"
		)
		return this;
	}

	User function get( required numeric userID ){
		var q = queryExecute(
			"select * from users
			where id = :userID",
			{ userID : { value : "#userID#", cfsqltype : "cf_sql_numeric" } }
		).reduce( ( result, row ) => populator.populateFromStruct( result, row ), new () );
	}

}
