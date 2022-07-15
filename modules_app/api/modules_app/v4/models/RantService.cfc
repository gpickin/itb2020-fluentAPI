/**
 * I am the Rant Service v4
 */
component
	extends="v4.models.BaseService"
	singleton
	accessors="true"
{

	/**
	 * Constructor
	 */
	RantService function init(){
		super.init(
			entityName    = "rant",
			tableName     = "rants",
			parameterName = "rantId",
			moduleName    = "v4"
		)
		return this;
	}

	/**
	 * Let WireBox build new Rant objects for me
	 */
	Rant function new() provider="Rant@v4"{
	}

	array function list(){
		return this
			.listArray()
			.map( function( rant ){
				return populator.populateFromStruct( new (), rant );
			} );
	}

	array function listArray(){
		return queryExecute( "select * from rants ORDER BY createdDate DESC", {} ).reduce( ( result, row ) => {
			result.append( row );
			return result;
		}, [] );
	}

	Rant function get( required numeric rantId ){
		return queryExecute(
			"select * from rants
			where id = :rantId",
			{ rantId : { value : "#rantId#", cfsqltype : "cf_sql_numeric" } }
		).reduce( ( result, row ) => populator.populateFromStruct( result, row ), new () );
	}

	function delete( required numeric rantId ){
		queryExecute(
			"delete from rants
			where id = :rantId",
			{ rantId : { value : "#rantId#", cfsqltype : "cf_sql_numeric" } },
			{ result : "local.result" }
		);
		return local.result;
	}

	function create( required Rant rant ){
		var now = now();
		arguments.rant.setCreatedDate( now );
		arguments.rant.setUpdatedDate( now );

		queryExecute(
			"insert into rants
			set
			body         = :body,
			userId       = :userId,
			createdDate  = :createdDate,
			updatedDate = :updatedDate
			",
			{
				body : {
					value     : "#arguments.rant.getBody()#",
					cfsqltype : "cf_sql_longvarchar"
				},
				userId : {
					value     : "#arguments.rant.getuserId()#",
					cfsqltype : "cf_sql_numeric"
				},
				createdDate : {
					value     : "#arguments.rant.getCreatedDate()#",
					cfsqltype : "cf_sql_timestamp"
				},
				updatedDate : {
					value     : "#arguments.rant.getUpdatedDate()#",
					cfsqltype : "cf_sql_timestamp"
				}
			},
			{ result : "local.result" }
		);
		arguments.rant.setID( local.result.generatedKey );
		return arguments.rant;
	}

	function update( required Rant rant ){
		var now = now();
		arguments.rant.setUpdatedDate( now );
		queryExecute(
			"update rants
			set
			body         = :body,
			updatedDate = :updatedDate
			where id     = :rantId
			",
			{
				rantId : {
					value     : "#arguments.rant.getID()#",
					cfsqltype : "cf_sql_integer"
				},
				body : {
					value     : "#arguments.rant.getBody()#",
					cfsqltype : "cf_sql_longvarchar"
				},
				updatedDate : {
					value     : "#arguments.rant.getUpdatedDate()#",
					cfsqltype : "cf_sql_timestamp"
				}
			},
			{ result : "local.result" }
		);
		return local.result;
	}

}
