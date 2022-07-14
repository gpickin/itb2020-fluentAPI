/**
 * I am a new User Object
 */
component accessors="true" {

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
		return this;
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
			"username"    : getUsername(),
			"email"       : getEmail(),
			"createdDate" : dateFormat( getCreatedDate(), "long" ),
			"updatedDate" : dateFormat( getUpdatedDate(), "long" )
		};
	}

}
