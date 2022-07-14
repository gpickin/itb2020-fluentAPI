/**
 * API Core Module Configuration
 */
component {

	// Module Properties
	this.title = "api";
	this.description = "Base API Module";
	this.version = "1.0.0";

	// Module Entry Point in the URI: http://yourapp/api
	this.entryPoint = "api";
	// Inheritable entry point.
	this.inheritEntryPoint = true;
	// Model Namespace
	this.modelNamespace = "api";
	// CF Mapping
	this.cfmapping = "api";
	// Module Dependencies
	this.dependencies = [];

	/**
	 * Configure the module
	 */
	function configure() {
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad() {
	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload() {
	}

}
