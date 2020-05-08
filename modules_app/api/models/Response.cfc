/**
 * ********************************************************************************
 * Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ********************************************************************************
 * HTTP Response model, spice up as needed and stored in the request scope
 */
component accessors="true" {

	property name="format" type="string" default="json";
	property name="data" type="any" default="";
	property name="error" type="boolean" default="false";
	property name="binary" type="boolean" default="false";
	property name="messages" type="array";
	property name="location" type="string" default="";
	property name="jsonCallback" type="string" default="";
	property
		name="jsonQueryFormat"
		type="string"
		default="true"
		hint="JSON Only: This parameter can be a Boolean value that specifies how to serialize ColdFusion queries or a string with possible values row, column, or struct";
	property name="contentType" type="string" default="";
	property name="statusCode" type="numeric" default="200";
	property name="statusText" type="string" default="OK";
	property name="responsetime" type="numeric" default="0";
	property name="cachedResponse" type="boolean" default="false";
	property name="headers" type="array";

	/**
	 * Constructor
	 */
	Response function init() {
		// Init properties
		variables.format = "json";
		variables.data = {};
		variables.pagination = {};
		variables.error = false;
		variables.binary = false;
		variables.messages = [];
		variables.location = "";
		variables.jsonCallBack = "";
		variables.jsonQueryFormat = "query";
		variables.contentType = "";
		variables.statusCode = 200;
		variables.statusText = "OK";
		variables.responsetime = 0;
		variables.cachedResponse = false;
		variables.headers = [];

		return this;
	}

	STATUS_TEXTS = {
		"100": "Continue",
		"101": "Switching Protocols",
		"102": "Processing",
		"200": "OK",
		"201": "Created",
		"202": "Accepted",
		"203": "Non-authoritative Information",
		"204": "No Content",
		"205": "Reset Content",
		"206": "Partial Content",
		"207": "Multi-Status",
		"208": "Already Reported",
		"226": "IM Used",
		"300": "Multiple Choices",
		"301": "Moved Permanently",
		"302": "Found",
		"303": "See Other",
		"304": "Not Modified",
		"305": "Use Proxy",
		"307": "Temporary Redirect",
		"308": "Permanent Redirect",
		"400": "Bad Request",
		"401": "Unauthorized",
		"402": "Payment Required",
		"403": "Forbidden",
		"404": "Not Found",
		"405": "Method Not Allowed",
		"406": "Not Acceptable",
		"407": "Proxy Authentication Required",
		"408": "Request Timeout",
		"409": "Conflict",
		"410": "Gone",
		"411": "Length Required",
		"412": "Precondition Failed",
		"413": "Payload Too Large",
		"414": "Request-URI Too Long",
		"415": "Unsupported Media Type",
		"416": "Requested Range Not Satisfiable",
		"417": "Expectation Failed",
		"418": "I'm a teapot",
		"421": "Misdirected Request",
		"422": "Unprocessable Entity",
		"423": "Locked",
		"424": "Failed Dependency",
		"426": "Upgrade Required",
		"428": "Precondition Required",
		"429": "Too Many Requests",
		"431": "Request Header Fields Too Large",
		"444": "Connection Closed Without Response",
		"451": "Unavailable For Legal Reasons",
		"499": "Client Closed Request",
		"500": "Internal Server Error",
		"501": "Not Implemented",
		"502": "Bad Gateway",
		"503": "Service Unavailable",
		"504": "Gateway Timeout",
		"505": "HTTP Version Not Supported",
		"506": "Variant Also Negotiates",
		"507": "Insufficient Storage",
		"508": "Loop Detected",
		"510": "Not Extended",
		"511": "Network Authentication Required",
		"599": "Network Connect Timeout Error"
	};

	/**
	 * Sets the status code with a statusText for the API response
	 * @statusCode The status code to be set
	 * @statusText The status text to be set
	 *
	 * @return Returns the Response object for chaining
	 */
	function setStatusCode( required statusCode, statusText ) {
		if ( isNull( arguments.statusText ) ) {
			if ( structKeyExists( variables.STATUS_TEXTS, arguments.statusCode ) ) {
				arguments.statusText = variables.STATUS_TEXTS[ arguments.statusCode ];
			} else {
				arguments.statusText = "";
			}
		}
		variables.statusCode = arguments.statusCode;
		variables.statusText = arguments.statusText;
		return this;
	}

	/**
	 * Sets the data and pagination from a struct with `results` and `pagination`.
	 *
	 * @data           The struct containing both results and pagination.
	 * @resultsKey     The name of the key with the results.
	 * @paginationKey  The name of the key with the pagination.
	 */
	function setDataWithPagination( data, resultsKey = "results", paginationKey = "pagination" ) {
		variables.data = arguments.data[ arguments.resultsKey ];
		variables.pagination = arguments.data[ arguments.paginationKey ];
		return this;
	}

	/**
	 * Sets the error message with a code for the API response
	 * @errorMessage The errorMessage to be set
	 * @statusCode The status code to be set
	 * @statusText The status text to be set
	 *
	 * @return Returns the Response object for chaining

	 */
	function setErrorMessage( required errorMessage, statusCode, statusText ) {
		setError( true );
		addMessage( arguments.errorMessage );
		if ( !isNull( arguments.statusCode ) ) {
			setStatusCode( arguments.statusCode, !isNull( arguments.statusText ) ? arguments.statusText : "" );
		} else {
			if ( !isNull( arguments.statusText ) ) {
				setStatusText( arguments.statusText );
			}
		}
		return this;
	}


	/**
	 * Add some messages
	 * @message Array or string of message to incorporate
	 */
	function addMessage( required any message ) {
		if ( isSimpleValue( arguments.message ) ) {
			arguments.message = [ arguments.message ];
		}
		variables.messages.addAll( arguments.message );
		return this;
	}

	/**
	 * Add a header
	 * @name The header name ( e.g. "Content-Type" )
	 * @value The header value ( e.g. "application/json" )
	 */
	function addHeader( required string name, required string value ) {
		arrayAppend( variables.headers, { name: arguments.name, value: arguments.value } );
		return this;
	}

	/**
	 * Returns a standard response formatted data packet
	 * @reset Reset the 'data' element of the original data packet
	 */
	function getDataPacket( boolean reset = false ) {
		var packet = {
			"error": variables.error ? true : false,
			"messages": variables.messages,
			"data": variables.data,
			"pagination": variables.pagination
		};

		// Are we reseting the data packet
		if ( arguments.reset ) {
			packet.data = {};
		}

		return packet;
	}

}
