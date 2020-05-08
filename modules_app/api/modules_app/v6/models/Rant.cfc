/**
 * I am a new Rant Object
 */
component extends="v6.models.BaseEntity" accessors="true" {

	// DI
	property name="userService" inject="UserService@v6";

	// Properties
	property name="id" type="string";
	property name="body" type="string";
	property name="createdDate" type="date";
	property name="modifiedDate" type="date";
	property name="userID" type="string";


	/**
	 * Constructor
	 */
	Rant function init() {
		super.init( entityName = "rant", moduleName = "v6" );
		return this;
	}

	this.constraints = {
		userID: { required: true, type: "numeric" },
		body: { required: true }
	};

	/**
	 * getUser
	 */
	function getUser() {
		return userService.get( getUserID() );
	}

	// function getMemento() {
	// 	return {
	// 		"id" = getID(),
	// 		"body" = getBody(),
	// 		"createdDate" = dateFormat( getCreatedDate(), "long" ),
	// 		"modifiedDate" = dateFormat( getModifiedDate(), "long" ),
	// 		"userId" = getUserID()
	// 	};
	// }

}
