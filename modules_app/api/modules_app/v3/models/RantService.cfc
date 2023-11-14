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
			entityName = "rant",
			tableName  = "rants",
			moduleName = "v3"
		)
		return this;
	}

	array function list(){
		return queryExecute(
			"select * from rants ORDER BY createdDate DESC",
			{},
			{ returnType : "array" }
		);
	}

	function create( required body, required userId ){
		var now    = now();
		var newKey = createUUID();
		queryExecute(
			"insert into rants
			set
				id 				= :rantId,
				body         	= :body,
				userId       	= :userId
			",
			{
				rantId : newKey,
				body   : { value : "#body#", cfsqltype : "cf_sql_longvarchar" },
				userId : arguments.userId
			},
			{ result : "local.result" }
		);
		local.result.generatedKey = newKey;
		return local.result;
	}

	function update( required body, required rantId ){
		var now = now();
		queryExecute(
			"update rants
				set
				body        = :body,
				updatedDate = :updatedDate
				where id    = :rantId
			",
			{
				rantId      : arguments.rantId,
				body        : { value : "#body#", cfsqltype : "cf_sql_longvarchar" },
				updatedDate : { value : "#now#", cfsqltype : "cf_sql_timestamp" }
			},
			{ result : "local.result" }
		);
		return local.result;
	}

}
