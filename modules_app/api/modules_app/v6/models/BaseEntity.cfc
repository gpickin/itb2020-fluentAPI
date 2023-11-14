/**
 * I am a base entity which exposes some very cool methods to provide fluency and readability
 * while still encapsulating them in a service.
 */
component accessors="true" {

	// Entity metadata + service
	property name="_primaryKey";
	property name="_entityName";
	property name="_serviceName";
	property name="_moduleName";
	property name="_entityService";

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
			"_primaryKey",
			"_entityName",
			"_serviceName",
			"_moduleName",
			"_entityService"
		],
		// A struct of defaults for properties/relationships if they are null
		defaults : {},
		// A struct of mapping functions for properties/relationships that can transform them
		mappers  : {}
	}

	/**
	 * Initialize Entity - stores information needed
	 *
	 * @primaryKey  The name of the primary key field in the entity
	 * @entityName  The name of the entity so we can reference it for calls to related DAO and Service. Set as optional for backwards
	 * @moduleName  The name of the module for the objects
	 * @serviceName The name of the service that manages the entity
	 */
	function init(
		primaryKey  = "id",
		entityName  = "",
		moduleName  = "v6",
		serviceName = "#arguments.entityName#Service@#arguments.moduleName#"
	){
		variables._primaryKey  = arguments.primaryKey;
		variables._entityName  = arguments.entityName;
		variables._moduleName  = arguments.moduleName;
		variables._serviceName = arguments.serviceName;

		return this;
	}

	/**
	 * Once this entity is loaded, load up it's companion service
	 */
	function onDIComplete(){
		variables._entityService = wirebox.getInstance( variables._serviceName );
	}

	/**
	 * Verify if entity is loaded or not
	 */
	boolean function isLoaded(){
		return (
			!structKeyExists( variables, variables._primaryKey ) OR !len( variables[ variables._primaryKey ] ) ? false : true
		);
	}

	/**
	 * Get the primary key value of this object.
	 *
	 * @return The primary key or an empty value if not set.
	 */
	function getId(){
		return isLoaded() ? variables[ variables._primaryKey ] : "";
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
		// Seed the target for population
		arguments[ "target" ] = this;

		// json?
		if ( !isNull( arguments.jsonstring ) ) {
			return variables.populator.populateFromJSON( argumentCollection = arguments );
		}
		// XML
		else if ( !isNull( arguments.xml ) ) {
			return variables.populator.populateFromXML( argumentCollection = arguments );
		}
		// Query
		else if ( !isNull( arguments.qry ) ) {
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
			return variables._entityService.update( this );
		} else {
			return variables._entityService.create( this );
		}
	}

	/**
	 * Delete an entity
	 */
	function delete(){
		return variables._entityService.delete( this.getId() );
	}

}
