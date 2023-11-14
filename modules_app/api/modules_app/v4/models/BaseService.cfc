/**
 * I am the Base Service v4
 */
component accessors="true" {

	// DI
	property name="populator" inject="wirebox:populator";
	property name="wirebox"   inject="wirebox";

	// Properties
	property name="entityName";
	property name="tableName";
	property name="primaryKey";
	property name="serviceName";
	property name="moduleName";

	function init(
		entityName,
		tableName,
		primaryKey  = "id",
		serviceName = "#arguments.entityName#Service",
		moduleName  = ""
	){
		setEntityName( arguments.entityName );
		setTableName( arguments.tableName );
		setPrimaryKey( arguments.primaryKey );
		setServiceName( arguments.serviceName );
		setModuleName( arguments.moduleName );
		return this;
	}

	/**
	 * Check to see if there is a row with a matching primary key in the database.
	 * Much faster than a full entity query and object load
	 *
	 * @id The primary key id to verify
	 *
	 * @return Returns true if there is a row with the matching Primary Key, otherwise returns false
	 */
	boolean function exists( required id ){
		return booleanFormat(
			queryExecute(
				"select #getPrimaryKey()# from #getTableName()#
					where #getPrimaryKey()# = :id",
				{ id : arguments.id }
			).len()
		)
	}

	/**
	 * Get a new entity object according to entity name
	 */
	function new(){
		return wirebox.getInstance( "#getEntityname()#@#getModuleName()#" );
	}

	/**
	 * Check to see if there is a row with a matching primary key in the database. Much faster than a full entity query and object load
	 *
	 * @id The primary key id to verify
	 *
	 * @return Returns true if there is a row with the matching Primary Key
	 *
	 * @throws EntityNotFound if the entity is not found
	 */
	boolean function existsOrFail( required id ){
		if ( exists( argumentCollection = arguments ) ) {
			return true;
		}
		throw( type = "EntityNotFound", message = "#getEntityName()# Not Found" );
	}

	/**
	 * Query and load an entity if possible, else throw an error
	 *
	 * @id The primary key id to retrieve
	 *
	 * @return Returns the Entity if there is a row with the matching Primary Key
	 *
	 * @throws EntityNotFound if the entity is not found
	 */
	function getOrFail( required id ){
		var maybeEntity = this.get( arguments.id );
		if ( !maybeEntity.isLoaded() ) {
			throw( type = "EntityNotFound", message = "#getEntityName()# Not Found" );
		}
		return maybeEntity;
	}

	/**
	 * Try to get an entity from the requested id
	 *
	 * @id The primary key id to retrieve
	 *
	 * @return Returns the Entity if there is a row with the matching Primary Key or an empty entity if not found
	 */
	function get( required id ){
		return queryExecute(
			"select * from #getTableName()#
				where #getPrimaryKey()# = :id
			",
			{ id : arguments.id }
		).reduce( ( result, row ) => populator.populateFromStruct( result, row ), new () );
	}

	/**
	 * Base delete entity
	 */
	function delete( required id ){
		queryExecute(
			"delete from #getTableName()#
				where #getPrimaryKey()# = :id
			",
			{ id : arguments.id },
			{ result : "local.result" }
		);
		return local.result;
	}

}
