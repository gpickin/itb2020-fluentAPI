/**
 * I am the Base Entity
 */
component accessors="true" {

	// global properties
	property name="pk";
	property name="entityName";
	property name="serviceName";
	property name="moduleName";
	property name="entityService";

	// DI Injection
	property name="wirebox"   inject="wirebox";
	property name="populator" inject="wirebox:populator";
	property name="coldbox"   inject="coldbox";

	// Basic memento settings
	this.memento = {
		// An array of the properties/relationships to include by default
		defaultIncludes : [ "*" ],
		// An array of properties/relationships to exclude by default
		defaultExcludes : [],
		// An array of properties/relationships to NEVER include
		neverInclude    : [
			"password",
			"pk",
			"entityName",
			"serviceName",
			"moduleName",
			"entityService"
		],
		// A struct of defaults for properties/relationships if they are null
		defaults : {},
		// A struct of mapping functions for properties/relationships that can transform them
		mappers  : {}
	}

	/**
	 * Initialize Entity - stores information needed
	 *
	 * @pk          The name of the primary key field in the entity
	 * @entityName  The name of the entity so we can reference it for calls to related DAO and Service. Set as optional for backwards
	 * @serviceName The name of the service that manages the entity
	 * @moduleName  The name of the module for the objects
	 */
	function init(
		pk          = "id",
		entityName  = "",
		serviceName = "",
		moduleName  = ""
	){
		setPk( arguments.pk );

		if ( len( entityName ) ) {
			setEntityName( arguments.entityName );
		}

		if ( arguments.serviceName != "" ) {
			setServiceName( arguments.serviceName );
		} else {
			setServiceName( arguments.entityName & "Service" );
		}

		setModuleName( arguments.moduleName );
		if ( arguments.moduleName != "" ) {
			setServiceName( getServiceName() & "@" & arguments.moduleName );
		}
	}

	function onDIComplete(){
		variables.entityService = wirebox.getInstance( getServiceName() );
	}

	/**
	 * Verify if entity is loaded or not
	 */
	boolean function isLoaded(){
		return ( !structKeyExists( variables, getPk() ) OR !len( variables[ getPk() ] ) ? false : true );
	}

	/**
	 * Populate a model object from the request Collection or a passed in memento structure
	 *
	 * @scope                Use scope injection instead of setters population. Ex: scope=variables.instance.
	 * @trustedSetter        If set to true, the setter method will be called even if it does not exist in the object
	 * @include              A list of keys to include in the population
	 * @exclude              A list of keys to exclude in the population
	 * @ignoreEmpty          Ignore empty values on populations, great for ORM population
	 * @nullEmptyInclude     A list of keys to NULL when empty
	 * @nullEmptyExclude     A list of keys to NOT NULL when empty
	 * @composeRelationships Automatically attempt to compose relationships from memento
	 * @memento              A structure to populate the model, if not passed it defaults to the request collection
	 * @jsonstring           If you pass a json string, we will populate your model with it
	 * @xml                  If you pass an xml string, we will populate your model with it
	 * @qry                  If you pass a query, we will populate your model with it
	 * @rowNumber            The row of the qry parameter to populate your model with
	 */
	function populate(
		struct memento = coldbox
			.getRequestService()
			.getContext()
			.getCollection(),
		scope                        = "",
		boolean trustedSetter        = false,
		include                      = "",
		exclude                      = "",
		boolean ignoreEmpty          = false,
		nullEmptyInclude             = "",
		nullEmptyExclude             = "",
		boolean composeRelationships = false,
		string jsonstring,
		string xml,
		query qry
	){
		arguments[ "model" ] = this;
		arguments.target     = this;

		// json?
		if ( structKeyExists( arguments, "jsonstring" ) ) {
			return variables.populator.populateFromJSON( argumentCollection = arguments );
		}
		// XML
		else if ( structKeyExists( arguments, "xml" ) ) {
			return variables.populator.populateFromXML( argumentCollection = arguments );
		}
		// Query
		else if ( structKeyExists( arguments, "qry" ) ) {
			return variables.populator.populateFromQuery( argumentCollection = arguments );
		}
		// Mementos
		else {
			// populate
			return variables.populator.populateFromStruct( argumentCollection = arguments );
		}
	}

	/**
	 * Validate an object or structure according to the constraints rules and throw an exception if the validation fails.
	 * The validation errors will be contained in the `extendedInfo` of the exception in JSON format
	 */
	function validateOrFail(){
		arguments.target = this;
		return wirebox
			.getInstance( "ValidationManager@cbvalidation" )
			.validateOrFail( argumentCollection = arguments );
	}

	/**
	 * Save an entity
	 */
	function save(){
		if ( isLoaded() ) {
			return variables.entityService.update( this );
		} else {
			return variables.entityService.create( this );
		}
	}

	/**
	 * Delete an entity
	 */
	function delete(){
		return variables.entityService.delete( this.getID() );
	}

}
