/**
 * I am the Base Service
 */
component accessors="true" {

	property name="entityName";
	property name="tableName";
	property name="primaryKey";
	// property name="parameterName";
	property name="serviceName";
	property name="moduleName";

	function init(
		entityName,
		tableName,
		primaryKey = "id",
		// parameterName="",
		serviceName = "",
		moduleName = ""
	) {
		setEntityName( arguments.entityName );
		setTableName( arguments.tableName );
		setPrimaryKey( arguments.primaryKey );
		// if( arguments.parameterName != "" ){
		// 	setParameterName( arguments.parameterName );
		// } else {
		// 	setParameterName( arguments.primaryKey );
		// }
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
	 * Return a new Entity, empty or pre-populated with passed in data
	 *
	 * @data Data to populate the new Entity with
	 */
	function new( struct data = {} ) {
		// if( data.isEmpty() ){

		// } else {
		var modelName = getEntityName();
		if ( getModuleName() != "" ) {
			modelName = modelName & "@" & getModuleName();
		}
		return populator.populateFromStruct( target = wireBox.getInstance( "#modelName#" ), memento = arguments.data )
		// }
	}

	/**
	 * Check to see if there is a row with a matching primary key in the database. Much faster than a full entity query and object load
	 *
	 * @return Returns true if there is a row with the matching Primary Key, otherwise returns false
	 */
	boolean function exists() {
		return booleanFormat(
			queryExecute(
				"select id from #getTableName()#
				where #getPrimaryKey()# = :id",
				{ id: { value: arguments[ 1 ], type: "cf_sql_numeric" } },
				{ returntype: "array" }
			).len()
		)
	}

	/**
	 * Check to see if there is a row with a matching primary key in the database. Much faster than a full entity query and object load
	 *
	 * @return Returns true if there is a row with the matching Primary Key
	 * @throws EntityNotFound if the entity is not found
	 */
	function existsOrFail() {
		if ( exists( argumentCollection = arguments ) ) {
			return true;
		} else {
			throw( type = "EntityNotFound", message = "#entityName# Not Found" );
		}
	}

	/**
	 * Query and load an entity if possible, else throw an error
	 *
	 * @return Returns the Entity if there is a row with the matching Primary Key
	 * @throws EntityNotFound if the entity is not found
	 */
	function getOrFail() {
		var maybeEntity = this.get( argumentCollection = arguments );
		if ( isNull( maybeEntity ) || !maybeEntity.isLoaded() ) {
			throw( type = "EntityNotFound", message = "#getEntityName()# Not Found" );
		}
		return maybeEntity;
	}

	/**
	 * Helper to get Entity Constraints
	 *
	 * @constraintsKeyName The name of the variable with the entity constraints inside of the entity. Defaults to the convention of `constraints`
	 *
	 * @return a CBValidation compliant struct of Entity Constraints
	 */
	function getConstraints( string constraintsKeyName = "constraints" ) {
		return new ( {} )[ arguments.constraintsKeyName ];
	}


	/**
	 * Helper to add a structure of Constraints into the existing entity constraints and return the combined struct
	 *
	 * @newConstraints The new struct full of constraints to add
	 * @constraintsKeyName The name of the variable with the entity constraints inside of the entity. Defaults to the convention of `constraints`
	 *
	 * @return a CBValidation compliant struct of Entity Constraints
	 */
	function addConstraints( newConstraints = {}, constraintsKeyName = "constraints" ) {
		var constraints = getConstraints( arguments.constraintsKeyName );
		constraints.append( arguments.newConstraints );
		return constraints;
	}

}
