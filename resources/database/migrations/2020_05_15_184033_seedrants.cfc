component {

	messages = [
		'Another rant',
		"This is the most amazing post in my life",
		"I love kittens",
		"I love espresso",
		"I love soccer!",
		"Why is this here!",
		"Captain America is the best superhero!",
		'Testing test test',
		'Scott likes me preso',
		'Scott seems to like my preso',
		'What are you talking about!',
		"This post is not really good, it sucked!",
		"Why are you doing this to me!",
		"Please please please delete!"
	];

	users = [
		{
			id : '#createUUID()#' ,
			username : 'gpickin',
			email : 'gavin@ortussolutions.com',
			password : '$2a$12$JKiBJZF352Tfm/c3PpeslOBKRAwtXlwczMPKeUV1raD0d1cwh5B5.'
		},
		{
			id : '#createUUID()#' ,
			username : 'luis',
			email : 'lmajano@ortussolutions.com',
			password : '$2a$12$FE2J7ZLWaI2rSqejAu/84uLy7qlSufQsDsSE1lNNKyA05GG30gr8C'
		},
		{
			id : '#createUUID()#' ,
			username : 'brad',
			email : 'brad@ortussolutions.com',
			password : '$2a$12$Vbb4dYywI5X.1qKEV2mDzeOTZk3iHIDfEtz80SoMT0KkFWTkb.PB6'
		},
		{
			id : '#createUUID()#' ,
			username : 'javier',
			email : 'jquintero@ortussolutions.com',
			password : '$2a$12$UIEOglSflvGUbn5sHeBZ1.sAlaoBI4rpNOCIk2vF8R2KKz.ihP9/W'
		},
		{
			id : '#createUUID()#' ,
			username : 'scott',
			email : 'scott@scott.com',
			password : '$2a$12$OjIpxecG9AlZTgVGV1jsvOegTwbqgJ29PlUkfomGsK/6hsVicsRW.'
		},
		{
			id : '#createUUID()#' ,
			username : 'mike',
			email : 'mikep@netxn.com',
			password : '$2a$12$WWUwFEAoDGx.vB0jE54xser1myMUSwUMYo/aNn0cSGa8l6DQe67Q2'
		}
	];

    function up( schema, query ) {
		// insert users
		query.newQuery().from( "users" ).insert( users );

		// insert random rants
		var rants = [];
		for( var x = 1; x lte 20; x++ ){
			rants.append( {
				"id" : createUUID(),
				"body" : messages[ randRange( 1, messages.len() ) ],
				"userId" : users[ randRange( 1, users.len() ) ].id
			} );
		}
		query.newQuery().from( "rants" ).insert( rants );
    }

    function down( schema, query ) {
		queryExecute( "truncate rants" );
		queryExecute( "truncate users" );
    }

}
