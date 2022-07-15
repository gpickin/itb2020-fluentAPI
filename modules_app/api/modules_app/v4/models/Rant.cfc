/**
 * I am a new Rant Object
 */
component accessors="true" {

	// DI
	property name="userService" inject="UserService@v4";

	// Properties
	property name="id"          type="string";
	property name="body"        type="string";
	property name="createdDate" type="date";
	property name="updatedDate" type="date";
	property name="userId"      type="string";

	// Validation Constraints
	this.constraints = {
		body   : { required : true },
		userId : { required : true, type : "uuid" }
	};

	/**
	 * Constructor
	 */
	Rant function init(){
		var now               = now();
		variables.createdDate = now;
		variables.updatedDate = now;
		return this;
	}

	/**
	 * get the user
	 */
	function getUser(){
		return userService.get( getUserId() );
	}

	/**
	 * isLoaded
	 */
	boolean function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	/**
	 * Marshall my object to data
	 */
	function getMemento(){
		return {
			"rantId"      : getId(),
			"body"        : getBody(),
			"createdDate" : dateFormat( getCreatedDate(), "long" ),
			"updatedDate" : dateFormat( getUpdatedDate(), "long" ),
			"userId"      : getuserId()
		};
	}

}
