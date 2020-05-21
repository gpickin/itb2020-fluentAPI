component {

    function up( schema, query ) {
		queryExecute( "
			CREATE TABLE IF NOT EXISTS `users` (
			`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			`username` varchar(255) NOT NULL,
			`email` varchar(255) NOT NULL,
			`password` varchar(255) NOT NULL,
			`createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
			`modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (`id`),
			UNIQUE KEY `username` (`username`),
			UNIQUE KEY `email` (`email`)
			) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
		" );

		queryExecute( "
			CREATE TABLE IF NOT EXISTS `rants` (
			`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			`body` text NOT NULL,
			`createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
			`modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
			`userId` int(10) unsigned NOT NULL,
			PRIMARY KEY (`id`),
			KEY `fk_rants_userId` (`userId`),
			CONSTRAINT `fk_rants_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
			) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4;
		" );
    }

    function down( schema, query ) {
		schema.drop( "rants" );
		schema.drop( "users" );
    }

}
