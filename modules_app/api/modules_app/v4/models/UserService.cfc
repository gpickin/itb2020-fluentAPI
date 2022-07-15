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
			parameterName = "userId",
			moduleName    = "v4"
		)
		return this;
	}

	/**
	 * Let WireBox build new Rant objects for me
	 */
	User function new() provider="User@v4"{
	}

	User function get( required numeric userId ){
		var q = queryExecute(
			"select * from users
			where id = :userId",
			{ userId : { value : "#userId#", cfsqltype : "cf_sql_numeric" } }
		).reduce( ( result, row ) => populator.populateFromStruct( result, row ), new () );
	}

}
