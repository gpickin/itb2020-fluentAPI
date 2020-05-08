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
		if ( !maybeEntity.len() ) {
			throw( type = "EntityNotFound", message = "#getEntityName()# Not Found" );
		}
		return maybeEntity;
	}

}
