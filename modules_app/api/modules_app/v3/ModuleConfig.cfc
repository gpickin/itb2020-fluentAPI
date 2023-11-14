/**
 * v3 Module Config
 */
component {

	// Module Properties
	this.title             = "v3";
	// Module Entry Point
	this.entryPoint        = "v3";
	// Inherit entry point from parent, so this will be /api/v1
	this.inheritEntryPoint = true;
	// Model Namespace
	this.modelNamespace    = "v3";
	// CF Mapping
	this.cfmapping         = "v3";
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
