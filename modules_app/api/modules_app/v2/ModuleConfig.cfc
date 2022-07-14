/**
 * v2 Module Config
 */
component {

	// Module Properties
	this.title             = "v2";
	// Module Entry Point
	this.entryPoint        = "v2";
	// Inherit entry point from parent, so this will be /api/v1
	this.inheritEntryPoint = true;
	// Model Namespace
	this.modelNamespace    = "v2";
	// CF Mapping
	this.cfmapping         = "v2";
	// Module Dependencies
	this.dependencies      = [];

	function configure(){
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){
	}

}
