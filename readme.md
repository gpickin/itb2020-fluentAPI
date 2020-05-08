# 2020-ITB - Modern Functional & Fluent CFML REST APIs

This repo is the demo repo for the presentation given at Into the Box 2020.

## Slides:

The slides can be found at: SLIDES HERE

## App Setup

### Modules needed

This app works with CommandBox, it also uses a couple of modules which are useful in most CommandBox projects:

- CFConfig CLI - https://www.forgebox.io/view/commandbox-cfconfig
- CommandBox dotenv - https://www.forgebox.io/view/commandbox-dotenv

Recommened but not required: 

- CFFormat - https://www.forgebox.io/view/commandbox-cfformat
- commandbox-cflint - https://www.forgebox.io/view/commandbox-cflint

### Database setup

The database needed for this is MySQL 5.7. The SQL file for this project is located in the /workbench/database folder. Please use that to seed your database, and call the database fluentAPI for consistency with the .env.example file provided.

### Config setup

Please copy the .env.example file into a new file you can create called .env
You could use the `dotenv populate` command for a wizard to help you make that file.

Change the host, username and password of the database server you intend to use.

### Install Dependencies

The box.json stores all of the dependencies of the app, these are not stored in the repo, so please use the command below to install these dependencies ( using ForgeBox behind the scenes )

`box install`

### Start the app

Once you have your .env, your db loaded, and your box.json dependencies installed, you can start your server.

`box start`

## What can you do in the app?

Apart from hitting the root of the site, which is an API echo response, there are lots of things you can do with this app

http://127.0.0.1:60146/

### Hit API Endpoints

- List rants: http://127.0.0.1:60146/api/v6/rants
- Create Rants
- Read Rants
- Update Rants
- Delete Rants

### View the Tests

http://127.0.0.1:60146/tests/runner.cfm

### View API Docs

http://127.0.0.1:60146/cbswagger

#### What can you do with the API Docs?

- Import into Postman: https://www.postman.com/
- Use with Swagger.io site: https://editor.swagger.io/