/**
 * I am the User Service v6
 */
component
	extends="v6.models.BaseService"
	singleton
	accessors="true"
{

	/**
	 * Constructor
	 */
	UserService function init(){
		super.init(
			entityName    = "User",
			tableName     = "users",
			parameterName = "userId"
		)
		return this;
	}

}
