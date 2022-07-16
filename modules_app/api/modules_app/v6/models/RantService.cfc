/**
 * I am the Rant Service v6
 */
component
	extends="v6.models.BaseService"
	singleton
	accessors="true"
{

	/**
	 * Constructor
	 */
	RantService function init(){
		super.init(
			entityName    = "Rant",
			tableName     = "rants",
			parameterName = "rantId"
		)
		return this;
	}

	function list(){
		return this
			.listArray()
			.map( function( rant ){
				return populator.populateFromStruct( new (), rant );
			} );
	}

	array function listArray(){
		return queryExecute(
			"select * from rants ORDER BY createdDate DESC",
			{},
			{ returnType : "array" }
		);
	}

	function create( required Rant rant ){
		var now = now();
		arguments.rant.setId( createUUID() );

		queryExecute(
			"insert into rants
				set
					id 			= :rantId,
					body        = :body,
					userId      = :userId
			",
			{
				rantId : arguments.rant.getId(),
				body   : {
					value     : "#arguments.rant.getBody()#",
					cfsqltype : "cf_sql_longvarchar"
				},
				userId : arguments.rant.getuserId()
			}
		);
		return arguments.rant;
	}

	function update( required Rant rant ){
		arguments.rant.setUpdatedDate( now() );
		queryExecute(
			"update rants
				set
					body         	= :body,
					updatedDate 	= :updatedDate
				where id     	= :rantId
			",
			{
				rantId : arguments.rant.getID(),
				body   : {
					value     : "#arguments.rant.getBody()#",
					cfsqltype : "cf_sql_longvarchar"
				},
				updatedDate : {
					value     : "#arguments.rant.getUpdatedDate()#",
					cfsqltype : "cf_sql_timestamp"
				}
			}
		);
		return arguments.rant;
	}
}
