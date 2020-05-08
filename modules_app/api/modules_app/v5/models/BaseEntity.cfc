/**
 * I am the Base Entity
 */
component accessors="true" {

	property name="pk";
	property name="entityName";
	property name="serviceName";
	property name="moduleName";

	// DI Injection
	property name="wirebox" inject="wirebox";
	property name="coldbox" inject="coldbox";

	/**
	 * Initialize Entity - stores information needed
	 *
	 * @pk The name of the primary key field in the entity
	 * @entityName The name of the entity so we can reference it for calls to related DAO and Service. Set as optional for backwards
	 */
	function init(
		pk = "id",
		entityName = "",
		serviceName = "",
		moduleName = ""
	) {
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

	/**
	 * Verify if entity is loaded or not
	 */
	boolean function isLoaded() {
		return ( isNull( variables[ getPk() ] ) OR !len( variables[ getPk() ] ) ? false : true );
	}

	/**
	 * Populate a model object from the request Collection or a passed in memento structure
	 * @scope Use scope injection instead of setters population. Ex: scope=variables.instance.
	 * @trustedSetter If set to true, the setter method will be called even if it does not exist in the object
	 * @include A list of keys to include in the population
	 * @exclude A list of keys to exclude in the population
	 * @ignoreEmpty Ignore empty values on populations, great for ORM population
	 * @nullEmptyInclude A list of keys to NULL when empty
	 * @nullEmptyExclude A list of keys to NOT NULL when empty
	 * @composeRelationships Automatically attempt to compose relationships from memento
	 * @memento A structure to populate the model, if not passed it defaults to the request collection
	 * @jsonstring If you pass a json string, we will populate your model with it
	 * @xml If you pass an xml string, we will populate your model with it
	 * @qry If you pass a query, we will populate your model with it
	 * @rowNumber The row of the qry parameter to populate your model with
	 */
	function populate(
		struct memento = coldbox
			.getRequestService()
			.getContext()
			.getCollection(),
		scope = "",
		boolean trustedSetter = false,
		include = "",
		exclude = "",
		boolean ignoreEmpty = false,
		nullEmptyInclude = "",
		nullEmptyExclude = "",
		boolean composeRelationships = false,
		string jsonstring,
		string xml,
		query qry
	) {
		arguments[ "model" ] = this;
		arguments.target = this;

		// json?
		if ( structKeyExists( arguments, "jsonstring" ) ) {
			return wirebox.getObjectPopulator().populateFromJSON( argumentCollection = arguments );
		}
		// XML
		else if ( structKeyExists( arguments, "xml" ) ) {
			return wirebox.getObjectPopulator().populateFromXML( argumentCollection = arguments );
		}
		// Query
		else if ( structKeyExists( arguments, "qry" ) ) {
			return wirebox.getObjectPopulator().populateFromQuery( argumentCollection = arguments );
		}
		// Mementos
		else {
			// populate
			return wirebox.getObjectPopulator().populateFromStruct( argumentCollection = arguments );
		}
	}

	/**
	 * Validate an object or structure according to the constraints rules.
	 * @fields The fields to validate on the target. By default, it validates on all fields
	 * @constraints A structure of constraint rules or the name of the shared constraint rules to use for validation
	 * @locale The i18n locale to use for validation messages
	 * @excludeFields The fields to exclude from the validation
	 * @includeFields The fields to include in the validation
	 *
	 * @return cbvalidation.model.result.IValidationResult
	 * @throws ValidationException error
	 */
	public struct function validateOrFail(
		any constraints = {},
		string fields = "*",
		string locale = "",
		string excludeFields = "",
		string includeFields = ""
	) {
		var result = wirebox
			.getInstance( "ValidationManager@cbvalidation" )
			.validate(
				target = this,
				fields = arguments.fields,
				constraints = arguments.constraints,
				locale = arguments.locale,
				excludeFields = arguments.excludeFields,
				includeFields = arguments.includeFields
			);
		if ( result.hasErrors() ) {
			throw(
				type = "ValidationException",
				message = "The Model #getEntityName()# failed to pass validation",
				extendedInfo = serializeJSON( result.getAllErrors() )
			);
		}
		return this;
	}

	function save() {
		if ( isLoaded() ) {
			return wirebox.getInstance( "#getServiceName()#" ).update( this );
		} else {
			return wirebox.getInstance( "#getServiceName()#" ).create( this );
		}
	}

	function delete() {
		return wirebox.getInstance( "#getServiceName()#" ).delete( this.getID() );
	}

	this.memento = {
		// An array of the properties/relationships to include by default
		defaultIncludes: [ "*" ],
		// An array of properties/relationships to exclude by default
		defaultExcludes: [],
		// An array of properties/relationships to NEVER include
		neverInclude: [],
		// A struct of defaults for properties/relationships if they are null
		defaults: {},
		// A struct of mapping functions for properties/relationships that can transform them
		mappers: {}
	}

}
