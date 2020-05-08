/**
 * I am the Rant Service v4
 */
component extends="v4.models.BaseService" singleton accessors="true" {

	// To populate objects from data
	property name="populator" inject="wirebox:populator";

	/**
	 * Constructor
	 */
	RantService function init() {
		super.init(
			entityName = "rant",
			tableName = "rants",
			parameterName = "rantID",
			moduleName = "v4"
		)
		return this;
	}

	Rant function new() provider="Rant@v4" {
	}

	function list() {
		return this
			.listArray()
			.map( function( rant ) {
				return populator.populateFromStruct( new (), rant );
			} );
	}

	function listArray() {
		return queryExecute( "select * from rants ORDER BY createdDate DESC", {}, { returntype: "array" } )
	}

	Rant function get( required numeric rantID ) {
		var q = queryExecute(
			"select * from rants
			where id = :rantID",
			{ rantID: { value: "#rantID#", type: "cf_sql_numeric" } },
			{ returntype: "array" }
		);
		if ( q.len() ) {
			return populator.populateFromStruct( new (), q[ 1 ] );
		} else {
			return new ()
		}
	}

	function delete( required numeric rantID ) {
		queryExecute(
			"delete from rants
			where id = :rantID",
			{ rantID: { value: "#rantID#", type: "cf_sql_numeric" } },
			{ result: "local.result" }
		);
		return local.result;
	}

	function create( required Rant rant ) {
		var now = now();
		arguments.rant.setCreatedDate( now );
		arguments.rant.setModifiedDate( now );

		queryExecute(
			"insert into rants
			set
			body = :body,
			userID = :userID,
			createdDate = :createdDate,
			modifiedDate = :modifiedDate
			",
			{
				body: { value: "#arguments.rant.getBody()#", type: "cf_sql_longvarchar" },
				userID: { value: "#arguments.rant.getuserID()#", type: "cf_sql_numeric" },
				createdDate: { value: "#arguments.rant.getCreatedDate()#", type: "cf_sql_timestamp" },
				modifiedDate: { value: "#arguments.rant.getModifiedDate()#", type: "cf_sql_timestamp" }
			},
			{ result: "local.result" }
		);
		arguments.rant.setID( local.result.generatedKey );
		return arguments.rant;
	}

	function update( required Rant rant ) {
		var now = now();
		arguments.rant.setModifiedDate( now );
		queryExecute(
			"update rants
			set
			body = :body,
			modifiedDate = :modifiedDate
			where id = :rantID
			",
			{
				rantID: { value: "#arguments.rant.getID()#", type: "cf_sql_integer" },
				body: { value: "#arguments.rant.getBody()#", type: "cf_sql_longvarchar" },
				modifiedDate: { value: "#arguments.rant.getModifiedDate()#", type: "cf_sql_timestamp" }
			},
			{ result: "local.result" }
		);
		return local.result;
	}

}
