/**
 * My RESTFul Event Handler which inherits from the module `api`
 */
component extends="api.handlers.BaseHandler" {

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only = "";
	this.prehandler_except = "";
	this.posthandler_only = "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	 * Index
	 */
	any function index( event, rc, prc ) {
		prc.response.setData( "Welcome to my ColdBox RESTFul Service v3" );
	}

}
