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
			entityName    = "User",
			tableName     = "users",
			parameterName = "userId"
		)
		return this;
	}

}
