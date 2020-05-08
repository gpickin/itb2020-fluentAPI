/**
 * I am the User Service v6
 */
component extends="v6.models.BaseService" singleton accessors="true" {

	/**
	 * Constructor
	 */
	UserService function init() {
		super.init(
			entityName = "user",
			tableName = "users",
			parameterName = "userID",
			moduleName = "v6"
		)
		return this;
	}

	User function get( required numeric userID ) {
		var q = queryExecute(
			"select * from users
			where id = :userID",
			{ userID: { value: "#userID#", type: "cf_sql_numeric" } },
			{ returntype: "array" }
		);
		if ( q.len() ) {
			return populator.populateFromStruct( new (), q[ 1 ] );
		} else {
			return new ()
		}
	}

}
