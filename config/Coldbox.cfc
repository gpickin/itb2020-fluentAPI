component {

	/**
	 * Configure the ColdBox App For Production
	 */
	function configure(){
		/**
		 * --------------------------------------------------------------------------
		 * ColdBox Directives
		 * --------------------------------------------------------------------------
		 * Here you can configure ColdBox for operation. Remember tha these directives below
		 * are for PRODUCTION. If you want different settings for other environments make sure
		 * you create the appropriate functions and define the environment in your .env or
		 * in the `environments` struct.
		 */
		coldbox = {
			// Application Setup
			appName                  : getSystemSetting( "APPNAME", "Fluent API" ),
			eventName                : "event",
			// Development Settings
			reinitPassword           : getSystemSetting( "COLDBOX_REINITPASSWORD", "" ),
			reinitKey                : "fwreinit",
			handlersIndexAutoReload  : true,
			// Implicit Events
			defaultEvent             : "v1:Echo.index",
			requestStartHandler      : "",
			requestEndHandler        : "",
			applicationStartHandler  : "",
			applicationEndHandler    : "",
			sessionStartHandler      : "",
			sessionEndHandler        : "",
			missingTemplateHandler   : "",
			// Extension Points
			applicationHelper        : "",
			viewsHelper              : "",
			modulesExternalLocation  : [],
			viewsExternalLocation    : "",
			layoutsExternalLocation  : "",
			handlersExternalLocation : "",
			requestContextDecorator  : "",
			controllerDecorator      : "",
			// Error/Exception Handling
			invalidHTTPMethodHandler : "",
			exceptionHandler         : "v1:Echo.onError",
			invalidEventHandler      : "v1:Echo.onInvalidRoute",
			customErrorTemplate      : "",
			// Application Aspects
			handlerCaching           : true,
			eventCaching             : true,
			viewCaching              : false,
			// Will automatically do a mapDirectory() on your `models` for you.
			autoMapModels            : true,
			// Auto converts a json body payload into the RC
			jsonPayloadToRC          : true
		};

		/**
		 * --------------------------------------------------------------------------
		 * Custom Settings
		 * --------------------------------------------------------------------------
		 */
		settings = {};

		/**
		 * --------------------------------------------------------------------------
		 * Environment Detection
		 * --------------------------------------------------------------------------
		 * By default we look in your `.env` file for an `environment` key, if not,
		 * then we look into this structure or if you have a function called `detectEnvironment()`
		 * If you use this setting, then each key is the name of the environment and the value is
		 * the regex patterns to match against cgi.http_host.
		 *
		 * Uncomment to use, but make sure your .env ENVIRONMENT key is also removed.
		 */
		// environments = { development : "localhost,^127\.0\.0\.1" };

		/**
		 * --------------------------------------------------------------------------
		 * Application Logging (https://logbox.ortusbooks.com)
		 * --------------------------------------------------------------------------
		 * By Default we log to the console, but you can add many appenders or destinations to log to.
		 * You can also choose the logging level of the root logger, or even the actual appender.
		 */
		logBox = {
			// Define Appenders
			appenders : { console : { class : "coldbox.system.logging.appenders.ConsoleAppender" } },
			// Root Logger
			root      : { levelmax : "INFO", appenders : "*" },
			// Implicit Level Categories
			info      : [ "coldbox.system" ]
		};

		/**
		 * --------------------------------------------------------------------------
		 * Layout Settings
		 * --------------------------------------------------------------------------
		 */
		layoutSettings = { defaultLayout : "", defaultView : "" };

		/**
		 * --------------------------------------------------------------------------
		 * Custom Interception Points
		 * --------------------------------------------------------------------------
		 */
		interceptorSettings = { customInterceptionPoints : [] };

		/**
		 * --------------------------------------------------------------------------
		 * Application Interceptors
		 * --------------------------------------------------------------------------
		 * Remember that the order of declaration is the order they will be registered and fired
		 */
		interceptors = [];

		/**
		 * --------------------------------------------------------------------------
		 * Module Settings
		 * --------------------------------------------------------------------------
		 * Each module has it's own configuration structures, so make sure you follow
		 * the module's instructions on settings.
		 *
		 * Each key is the name of the module:
		 *
		 * myModule = {
		 *
		 * }
		 */
		moduleSettings = {
			/**
			 * Mementifier settings: https://forgebox.io/view/mementifier
			 */
			mementifier : {
				// Turn on to use the ISO8601 date/time formatting on all processed date/time properites, else use the masks
				iso8601Format     : true,
				// The default date mask to use for date properties
				dateMask          : "yyyy-MM-dd",
				// The default time mask to use for date properties
				timeMask          : "HH:mm: ss",
				// Enable orm auto default includes: If true and an object doesn't have any `memento` struct defined
				// this module will create it with all properties and relationships it can find for the target entity
				// leveraging the cborm module.
				ormAutoIncludes   : true,
				// The default value for relationships/getters which return null
				nullDefaultValue  : "",
				// Don't check for getters before invoking them
				trustedGetters    : false,
				// If not empty, convert all date/times to the specific timezone
				convertToTimezone : "UTC"
			},
			/**
			 * --------------------------------------------------------------------------
			 * cbSwagger Settings
			 * --------------------------------------------------------------------------
			 */
			cbswagger : {
				// The route prefix to search.  Routes beginning with this prefix will be determined to be api routes
				"routes"        : [ "api/v6" ],
				// Any routes to exclude
				"excludeRoutes" : [],
				// The default output format: json or yml
				"defaultFormat" : "json",
				// A convention route, relative to your app root, where request/response samples are stored ( e.g. resources/apidocs/responses/[module].[handler].[action].[HTTP Status Code].json )
				"samplesPath"   : "resources/apidocs",
				// Information about your API
				"info"          : {
					// A title for your API
					"title"          : "Fluent API for SoapBox Twitter clone",
					// A description of your API
					"description"    : "This Fluent API provides data the for SoapBox Twitter clone",
					// A terms of service URL for your API
					"termsOfService" : "",
					// The contact email address
					"contact"        : {
						"name"  : "Gavin Pickin",
						"url"   : "https://www.ortussolutions.com",
						"email" : "gavin@ortussolutions.com"
					},
					// A url to the License of your API
					"license" : {
						"name" : "Apache 2.0",
						"url"  : "https://www.apache.org/licenses/LICENSE-2.0.html"
					},
					// The version of your API
					"version" : "1.0.0"
				},
				// Tags
				"tags"         : [],
				// https://swagger.io/specification/#externalDocumentationObject
				"externalDocs" : {
					"description" : "Find more info here",
					"url"         : "https://blog.readme.io/an-example-filled-guide-to-swagger-3-2/"
				},
				// https://swagger.io/specification/#serverObject
				"servers" : [
					{
						"url"         : "http://127.0.0.1:60146",
						"description" : "Local development"
					}
				],
				// An element to hold various schemas for the specification.
				// https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#componentsObject
				"components" : {
					// Define your security schemes here
					// https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#securitySchemeObject
					"securitySchemes" : {
						 // "ApiKeyAuth" : {
						// 	"type"        : "apiKey",
						// 	"description" : "User your JWT as an Api Key for security",
						// 	"name"        : "x-api-key",
						// 	"in"          : "header"
						// },
						// "bearerAuth" : {
						// 	"type"         : "http",
						// 	"scheme"       : "bearer",
						// 	"bearerFormat" : "JWT"
						// }
					}
				}

				// A default declaration of Security Requirement Objects to be used across the API.
				// https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#securityRequirementObject
				// Only one of these requirements needs to be satisfied to authorize a request.
				// Individual operations may set their own requirements with `@security`
				// "security" : [
				//	{ "APIKey" : [] },
				//	{ "UserSecurity" : [] }
				// ]
			}
		};
	}

	/**
	 * Development environment
	 */
	function development(){
		coldbox.handlersIndexAutoReload = true;
		coldbox.handlerCaching          = false;
		coldbox.reinitpassword          = "";
		coldbox.customErrorTemplate     = "/coldbox/system/exceptions/Whoops.cfm";

		// Debugger Settings
		variables.modulesettings.cbdebugger = {
			// This flag enables/disables the tracking of request data to our storage facilities
			// To disable all tracking, turn this master key off
			enabled          : true, // getSystemSetting( "CBDEBUGGER_ENABLED", false ),
			// This setting controls if you will activate the debugger for visualizations ONLY
			// The debugger will still track requests even in non debug mode.
			debugMode        : true,
			// The URL password to use to activate it on demand
			debugPassword    : "cb",
			// This flag enables/disables the end of request debugger panel docked to the bottom of the page.
			// If you disable it, then the only way to visualize the debugger is via the `/cbdebugger` endpoint
			requestPanelDock : true,
			// Request Tracker Options
			requestTracker   : {
				storage                      : "cachebox",
				cacheName                    : "template",
				trackDebuggerEvents          : false,
				// Expand by default the tracker panel or not
				expanded                     : true,
				// Slow request threshold in milliseconds, if execution time is above it, we mark those transactions as red
				slowExecutionThreshold       : 1000,
				// How many tracking profilers to keep in stack: Default is to monitor the last 20 requests
				maxProfilers                 : 50,
				// If enabled, the debugger will monitor the creation time of CFC objects via WireBox
				profileWireBoxObjectCreation : false,
				// Profile model objects annotated with the `profile` annotation
				profileObjects               : true,
				// If enabled, will trace the results of any methods that are being profiled
				traceObjectResults           : false,
				// Profile Custom or Core interception points
				profileInterceptions         : false,
				// By default all interception events are excluded, you must include what you want to profile
				includedInterceptions        : [],
				// Control the execution timers
				executionTimers              : {
					expanded           : true,
					// Slow transaction timers in milliseconds, if execution time of the timer is above it, we mark it
					slowTimerThreshold : 250
				},
				// Control the coldbox info reporting
				coldboxInfo : { expanded : false },
				// Control the http request reporting
				httpRequest : {
					expanded        : false,
					// If enabled, we will profile HTTP Body content, disabled by default as it contains lots of data
					profileHTTPBody : false
				}
			},
			// ColdBox Tracer Appender Messages
			tracers     : { enabled : true, expanded : false },
			// Request Collections Reporting
			collections : {
				// Enable tracking
				enabled      : false,
				// Expanded panel or not
				expanded     : false,
				// How many rows to dump for object collections
				maxQueryRows : 50,
				// How many levels to output on dumps for objects
				maxDumpTop   : 5
			},
			// CacheBox Reporting
			cachebox : { enabled : true, expanded : false },
			// Modules Reporting
			modules  : { enabled : true, expanded : false },
			// Quick and QB Reporting
			qb       : {
				enabled   : false,
				expanded  : false,
				// Log the binding parameters
				logParams : true
			},
			// cborm Reporting
			cborm : {
				enabled   : false,
				expanded  : false,
				// Log the binding parameters
				logParams : false
			},
			// Adobe ColdFusion SQL Collector
			acfSql : {
				enabled   : true,
				expanded  : false,
				// Log the binding parameters
				logParams : true
			},
			async : { enabled : true, expanded : false }
		};
	}

}
