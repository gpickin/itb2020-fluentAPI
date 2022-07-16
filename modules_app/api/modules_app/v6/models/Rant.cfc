/**
 * I am a new Rant Object
 */
component extends="v6.models.BaseEntity" accessors="true" {

	// DI
	property name="userService" inject="UserService@v6";

	// Properties
	property name="id"          type="string";
	property name="body"        type="string";
	property name="createdDate" type="date";
	property name="updatedDate" type="date";
	property name="userId"      type="string";

	// Validation Constraints
	this.constraints = {
		body   : { required : true },
		userId : {
			required : true,
			type     : "uuid",
			udf      : ( value, target ) => {
				if ( isNull( arguments.value ) || !isValid( "uuid", arguments.value ) ) return false;
				return userService.exists( arguments.value );
			},
			udfMessage : "User ({rejectedValue}) not found"
		}
	};

	/**
	 * Constructor
	 */
	Rant function init(){
		return super.init( entityName = "rant" );
	}

	/**
	 * Get related user object
	 */
	function getUser(){
		return userService.get( getUserId() );
	}

	/**
	 * Does this rant have a user assigned to it already
	 */
	boolean function hasUser(){
		return !isNull( variables.userId ) && len( variables.userId );
	}

}
