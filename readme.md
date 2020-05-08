# REST HMVC Template

This template gives you the base for building RESTFul web services with ColdBox in a modular fashion.  This template will create an `api` module with a `v1` sub-module within it.  It will leverage ColdBox 5 modular inherit entry points to mimic the URL resources to your modular design.

In the `api/models` folder you will find our Universal REST Response object that can be leveraged as your base for building RESTFul services.

```
+ modules_app
  + api
    + models
    + modules_app
      + v1
```

## Implicit Methods
The base handler implements an around handler approach to provide consistency and the following actions:

- `onError` - Fires whenever there is a runtime exception in any action
- `onInvalidHTTPMethod` - Fires on invalid HTTP method access
- `onMissingAction` - Fires on invalid missing actions on handlers

## Utility Functions
We also give you some utility functions for RESTFul building:

- `routeNotFound` - Can be used to fire of route not founds via 404
- `onExpectationFailed` - Can be called when an expectation of a request fails, like invalid parameters/headers etc.
- `onAuthorizationFailure` - Can be called to send a NOT Authorized status code and message.

## HTTP Security
By default the base handlers leverages ColdBox method security via the `this.allowedMethods` structure:

```
this.allowedMethods = {
    "index"     : METHODS.GET,
    "get"       : METHODS.GET,
    "list"      : METHODS.GET,
    "update"    : METHODS.PUT & "," & METHODS.PATCH,
    "delete"    : METHODS.DELETE
};
```

## HTTP Methods
The base handler contains a static construct called `METHODS` that implements basic HTTP Methods that you can use for messages and allowed methods.

```
METHODS = {
    "HEAD"      : "HEAD",
    "GET"       : "GET",
    "POST"      : "POST",
    "PATCH"     : "PATCH",
    "PUT"       : "PUT",
    "DELETE"    : "DELETE"
};
```

## Status Codes
The base handler contains a static construct called `STATUS` that implements basic HTTP status codes you can use:

```
STATUS = {
    "CREATED"               : 201,
    "ACCEPTED"              : 202,
    "SUCCESS"               : 200,
    "NO_CONTENT"            : 204,
    "RESET"                 : 205,
    "PARTIAL_CONTENT"       : 206,
    "BAD_REQUEST"           : 400,
    "NOT_AUTHORIZED"        : 401,
    "NOT_FOUND"             : 404,
    "NOT_ALLOWED"           : 405,
    "NOT_ACCEPTABLE"        : 406,
    "TOO_MANY_REQUESTS"     : 429,
    "EXPECTATION_FAILED"    : 417,
    "INTERNAL_ERROR"        : 500,
    "NOT_IMPLEMENTED"       : 501
};
```


- 

## License
Apache License, Version 2.0.

## Important Links

Source Code
- https://github.com/coldbox-templates/rest-hmvc

## Quick Installation

Each application templates contains a `box.json` so it can leverage [CommandBox](http://www.ortussolutions.com/products/commandbox) for its dependencies.  
Just go into each template directory and type:

```
box install
```

This will setup all the needed dependencies for each application template.  You can then type:

```
box server start
```

And run the application.

---
 
### THE DAILY BREAD
 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12