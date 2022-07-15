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
			parameterName = "userId",
			moduleName    = "v5"
		)
		return this;
	}

	User function get( required numeric userId ){
		var q = queryExecute(
			"select * from users
			where id = :userId",
			{ userId : { value : "#userId#", cfsqltype : "cf_sql_numeric" } }
		).reduce( ( result, row ) => populator.populateFromStruct( result, row ), new () );
	}

}
