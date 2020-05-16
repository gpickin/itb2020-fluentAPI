/**
 * I am a new Rant Object
 */
component accessors="true" {

	// DI
	property name="userService" inject="UserService@v4";

	// Properties
	property name="id"           type="string";
	property name="body"         type="string";
	property name="createdDate"  type="date";
	property name="modifiedDate" type="date";
	property name="userID"       type="string";


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
		return userService.get( getUserID() );
	}

	/**
	 * isLoaded
	 */
	boolean function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	function getMemento(){
		return {
			"id"           : getID(),
			"body"         : getBody(),
			"createdDate"  : dateFormat( getCreatedDate(), "long" ),
			"modifiedDate" : dateFormat( getModifiedDate(), "long" ),
			"userId"       : getUserID()
		};
	}

}
