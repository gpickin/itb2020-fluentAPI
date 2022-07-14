/**
 * I am a new User Object
 */
component extends="v5.models.BaseEntity" accessors="true" {

	// Properties
	property name="id"          type="string";
	property name="username"    type="string";
	property name="email"       type="string";
	property name="password"    type="string";
	property name="createdDate" type="date";
	property name="updatedDate" type="date";


	/**
	 * Constructor
	 */
	User function init(){
		super.init( entityName = "User", moduleName = "v5" );
		return this;
	}

}
