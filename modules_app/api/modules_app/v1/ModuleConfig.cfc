/**
 * v1 Module Config
 */
component {

	// Module Properties
	this.title             = "v1";
	// Module Entry Point
	this.entryPoint        = "v1";
	// Inherit URI entry point from parent, so this will be /api/v1
	this.inheritEntryPoint = true;
	// Model Namespace
	this.modelNamespace    = "v1";
	// CF Mapping
	this.cfmapping         = "v1";
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
