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
			entityName = "User",
			tableName  = "users",
			moduleName = "v4"
		)
		return this;
	}

	/**
	 * Let WireBox build new Rant objects for me
	 */
	User function new() provider="User@v4"{
	}

}
