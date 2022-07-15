/**
 * v4 Module Config
 */
component {

	// Module Properties
	this.title             = "v4";
	// Module Entry Point
	this.entryPoint        = "v4";
	// Inherit entry point from parent, so this will be /api/v1
	this.inheritEntryPoint = true;
	// Model Namespace
	this.modelNamespace    = "v4";
	// CF Mapping
	this.cfmapping         = "v4";
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
