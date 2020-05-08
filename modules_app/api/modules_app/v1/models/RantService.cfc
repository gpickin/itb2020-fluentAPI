/**
 * I am the Rant Service
 */
component singleton accessors="true" {

	/**
	 * Constructor
	 */
	RantService function init() {
		return this;
	}

	function list() {
		return queryExecute( "select * from rants ORDER BY createdDate DESC", {}, { returntype: "array" } );
	}

	function getRant( required numeric rantID ) {
		return queryExecute(
			"select * from rants
			where id = :rantID",
			{ rantID: { value: "#rantID#", type: "cf_sql_numeric" } },
			{ returntype: "array" }
		);
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

	function create( required body, required numeric userID ) {
		var now = now();
		queryExecute(
			"insert into rants
			set
			body = :body,
			userID = :userID,
			createdDate = :createdDate,
			modifiedDate = :modifiedDate
			",
			{
				body: { value: "#body#", type: "cf_sql_longvarchar" },
				userID: { value: "#userID#", type: "cf_sql_numeric" },
				createdDate: { value: "#now#", type: "cf_sql_timestamp" },
				modifiedDate: { value: "#now#", type: "cf_sql_timestamp" }
			},
			{ result: "local.result" }
		);
		return local.result;
	}

	function update( required body,  ) {
		var now = now();
		queryExecute(
			"update rants
			set
			body = :body,
			modifiedDate = :modifiedDate
			where id = :rantID
			",
			{
				rantID: { value: "#rantID#", type: "cf_sql_integer" },
				body: { value: "#body#", type: "cf_sql_longvarchar" },
				modifiedDate: { value: "#now#", type: "cf_sql_timestamp" }
			},
			{ result: "local.result" }
		);
		return local.result;
	}

}
