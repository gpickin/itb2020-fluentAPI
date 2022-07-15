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
		userId : { required : true, type : "numeric" }
	};

	/**
	 * Constructor
	 */
	Rant function init(){
		return this;
	}

	/**
	 * getUser
	 */
	function getUser(){
		return userService.get( getuserId() );
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
			"id"          : getID(),
			"body"        : getBody(),
			"createdDate" : dateFormat( getCreatedDate(), "long" ),
			"updatedDate" : dateFormat( getUpdatedDate(), "long" ),
			"userId"      : getuserId()
		};
	}

}
