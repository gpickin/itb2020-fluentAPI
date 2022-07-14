/**
 * I am the Rant Service v3
 */
component
	extends="v3.models.BaseService"
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
			parameterName = "rantID",
			moduleName    = "v3"
		)
		return this;
	}

	array function list(){
		return queryExecute( "select * from rants ORDER BY createdDate DESC", {} ).reduce( ( result, row ) => {
			result.append( row );
			return result;
		}, [] );
	}

	struct function get( required numeric rantID ){
		return queryExecute(
			"select * from rants
			where id = :rantID",
			{ rantID : { value : "#rantID#", cfsqltype : "cf_sql_numeric" } }
		).reduce( ( result, row ) => row, {} );
	}

	function delete( required numeric rantID ){
		queryExecute(
			"delete from rants
			where id = :rantID",
			{ rantID : { value : "#rantID#", cfsqltype : "cf_sql_numeric" } },
			{ result : "local.result" }
		);
		return local.result;
	}

	function create( required body, required numeric userID ){
		var now = now();
		queryExecute(
			"insert into rants
			set
				body         = :body,
				userID       = :userID,
				createdDate  = :createdDate,
				updatedDate = :updatedDate
			",
			{
				body        : { value : "#body#", cfsqltype : "cf_sql_longvarchar" },
				userID      : { value : "#userID#", cfsqltype : "cf_sql_numeric" },
				createdDate : { value : "#now#", cfsqltype : "cf_sql_timestamp" },
				updatedDate : { value : "#now#", cfsqltype : "cf_sql_timestamp" }
			},
			{ result : "local.result" }
		);
		return local.result;
	}

	function update( required body, required rantId ){
		var now = now();
		queryExecute(
			"update rants
			set
			body                                 = :body,
			updatedDate = :updatedDate
			where id                 = :rantID
			",
			{
				rantID      : { value : "#rantID#", cfsqltype : "cf_sql_integer" },
				body        : { value : "#body#", cfsqltype : "cf_sql_longvarchar" },
				updatedDate : { value : "#now#", cfsqltype : "cf_sql_timestamp" }
			},
			{ result : "local.result" }
		);
		return local.result;
	}

}
