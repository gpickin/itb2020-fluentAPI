/**
 * I am a new Rant Object
 */
component extends="v5.models.BaseEntity" accessors="true" {

	// DI
	property name="userService" inject="UserService@v5";

	// Properties
	property name="id"          type="string";
	property name="body"        type="string";
	property name="createdDate" type="date";
	property name="updatedDate" type="date";
	property name="userID"      type="string";

	// Validation Constraints
	this.constraints = {
		body   : { required : true },
		userID : {
			required : true,
			type     : "numeric",
			udf      : ( value, target ) => {
				if ( isNull( arguments.value ) || !isNumeric( arguments.value ) ) return false
				return userService.exists( arguments.value );
			},
			udfMessage : "User ({rejectedValue}) not found"
		}
	};

	/**
	 * Constructor
	 */
	Rant function init(){
		super.init( entityName = "rant", moduleName = "v5" );
		return this;
	}

	/**
	 * getUser
	 */
	function getUser(){
		return userService.get( getUserID() );
	}

}
