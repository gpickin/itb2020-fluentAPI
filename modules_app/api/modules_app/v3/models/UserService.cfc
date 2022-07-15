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
			entityName = "user",
			tableName  = "users",
			moduleName = "v3"
		)
		return this;
	}

}
