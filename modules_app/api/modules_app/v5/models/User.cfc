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

	// Validation Constraints
	this.constraints = {
		username : { required : true },
		email    : { required : true },
		password : { required : true }
	};

	/**
	 * Constructor
	 */
	User function init(){
		return super.init( entityName = "User" );
	}

}
