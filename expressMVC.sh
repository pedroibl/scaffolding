#!/bin/bash

# Set the project name, change "MyProject" to your desired project name
project_name="ExpressMVCProject"
mkdir -p "$HOME/Documents/docker-dev"

# Create the base project directory
project_directory="$HOME/Documents/docker-dev/$project_name"

# Create the project folders
mkdir -p "$project_directory/controllers"
mkdir -p "$project_directory/models"
mkdir -p "$project_directory/views"
mkdir -p "$project_directory/views/partials"
mkdir -p "$project_directory/public/css"
mkdir -p "$project_directory/public/js"
mkdir -p "$project_directory/public/images"
mkdir -p "$project_directory/routes"

# Create the controller files
touch "$project_directory/controllers/HomeController.js"
touch "$project_directory/controllers/OtherController.js"

touch "$project_directory/public/index.html"

# Create the model files
touch "$project_directory/models/User.js"
touch "$project_directory/models/OtherModel.js"

# Create the view files
touch "$project_directory/views/index.ejs"
touch "$project_directory/views/layout.ejs"
touch "$project_directory/views/partials/header.ejs"

# Create the public assets
touch "$project_directory/public/css/styles.css"
touch "$project_directory/public/js/scripts.js"
touch "$project_directory/public/images/logo.png"

# Create the routes files
touch "$project_directory/routes/index.js"
touch "$project_directory/routes/userRoutes.js"
touch "$project_directory/routes/otherRoutes.js"

# Create app.js, .gitignore, .env and readme.md
touch "$project_directory/app.js"
touch "$project_directory/.gitignore"
touch "$project_directory/.env"
touch "$project_directory/.eslintignore"
touch "$project_directory/.eslintrc.json"
touch "$project_directory/readme.md"

# readme.md Content
cat <<EOF >"$project_directory/readme.md"
# Run:

npm init -y
npm install express --save
npm install body-parser --save
npm install dotenv --save
npm install nodemon --save
npm install -D eslint

## Starting the Project
0 - npm init -y
1 - npm install express body-parser dotenv nodemon mysql --save
2 - npm install -D eslint
3 - npx eslint --init
	###Answears
		Check syntax, find problems, and enforce code style
		CommonJs ( require/exports )
		Config file in JSON
		Install adicional dependencies

4 - npm install -D prettier eslint-config-prettier eslint-plugin-prettier



## Remember  to create another user at mysql and flush privileges. ( For mysql )
npm install mysql --save
or 
npm install mysql2 --save

### Documentations

https://expressjs.com/

https://www.npmjs.com/package/body-parser

https://www.npmjs.com/package/dotenv

https://www.npmjs.com/package/nodemon

https://www.npmjs.com/package/mysql

https://www.npmjs.com/package/mysql2

## nodemon configuration
Start:
  "scripts": {
    "start": "nodemon app.js"
  },

#### MYSQL Configuration
#Access the root user database:
# 
#     bash
#     mysql -u root -p
# 

# 
#     mysql
#     CREATE USER 'username'@'localhost' IDENTIFIED BY 'password'
#     FLUSH PRIVILEGES
# 

# Exemple of user creation and access
#
#     mysql
#     CREATE USER 'pedrodev'@'localhost' IDENTIFIED BY '123Santb@@'
#     FLUSH PRIVILEGES
#
# >Access pedrodev) user
#
#     bash
#     mysql -u pedrodev -p
#

# >Check users:
#
#     mysql
#     SELECT user, host FROM mysql.user
#

EOF

# .gitignore Content
cat <<EOF >"$project_directory/.gitignore"
# Ignore Node.js modules and npm dependencies
node_modules/

# Ignore logs and temporary files
logs/
*.log
*.pid

# Ignore development environment files
.env

# Ignore macOS system files
.DS_Store

# Ignore IDE/Editor specific files
.vscode/
.idea/

# Ignore build artifacts
build/
dist/
*.exe

# Ignore any sensitive or private files (e.g., credentials)
secret_file.txt
EOF
########################################################
# app.js Content
cat <<EOF >"$project_directory/app.js"
const express = require('express');
const mysql = require('mysql');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

//# bodyParser
//parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));

// parse application/json
app.use(bodyParser.json());

// Load environment variables from .env file
dotenv.config();

// Database connection settings
const dbConfig = {
	host: process.env.DB_HOST,
	user: process.env.DB_USER,
	password: process.env.DB_PASSWORD,
	database: process.env.DB_NAME,
	port: process.env.DB_PORT,
};

// Create a MySQL connection
const connection = mysql.createConnection(dbConfig);

// Connect to the database
connection.connect((err) => {
	if (err) {
		console.error('Error connecting to database:', err);
	} else {
		console.log('Database connection established!');
	}
});

// # App.get sendFile or set an static folder
// app.get('/', (req, res) => {
// 	res.sendFile(__dirname + '/public/index.html');
// });
app.use(express.static(path.join(__dirname, 'public')));

// Add the MySQL connection to the request object to make it accessible in routes
// app.use((req, res, next) => {
// 	req.connection = connection;
// 	next();
// });

// Other middleware and route handlers here...

// Start the server
const PORT = process.env.APP_PORT || 3000;
app.listen(PORT, () => {
	console.log($(Server started on port ${PORT}));
});

EOF

########################################################
# index.js Content at routes folder
cat <<EOF >"$project_directory/routes/index.js"
const express = require('express');
const router = express.Router();

// Define your routes here
router.get('/', (req, res) => {
  res.send('<h1>Hi From Router</h1>');
});

router.get('/about', (req, res) => {
  res.send('Welcome to the about page!');
});

// Add more routes as needed

module.exports = router;
EOF

########################################################
#.env content
cat <<EOF >"$project_directory/.env"
# Environment Configuration

# Database connection settings
DB_HOST='localhost'
DB_PORT='3306'
DB_USER='pedrodev'
DB_PASSWORD='My_database_password'
DB_NAME='expressMVC'

# API keys and secrets
API_KEY='your_api_key_here'
SECRET_KEY='your_secret_key_here'

# App settings
APP_PORT='3000'
APP_ENV='development'

# Debug mode (1 for true, 0 for false)
DEBUG_MODE=1
EOF

cat <<EOF >"$project_directory/test-driven-development.md"
# Test Driven Development

npm install jest
> Documentation: https://jestjs.io/

## Context

## Scenario

## Steps

## Examples

## Notes
EOF

cat <<EOF >"$project_directory/.eslintignore"
# Ignore built files
build/

# Ignore Node.js modules and npm dependencies
node_modules/

# Ignore logs and temporary files
logs/
*.log
*.pid

# Ignore any sensitive or private files (e.g., credentials)
secret_file.txt

# Ignore IDE/Editor specific files
.vscode/
.idea/

# Ignore build artifacts
dist/
*.exe
EOF

cat <<EOF >"$project_directory/public/index.html"
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="./css/styles.css" />
		<title>Express App</title>
	</head>
	<body>
		<h1>Static HTML File</h1>
		<h2>
			MVC folder structure for ExpressJS <br />
			It was Scaffolded via bash script. <br />
			Github: https://github.com/pedroibl <br />
			Follow the readme.md to start
		</h2>
	</body>
</html>

EOF

cat <<EOF >"$project_directory/public/css/styles.css"
body {
	background: #333;
	color: #fff;
}
EOF

cat <<EOF >"$project_directory/.eslintrc.json"
{
	"env": {
		"browser": true,
		"commonjs": true,
		"es2021": true
	},
	"extends": "airbnb-base",
	"plugins": ["prettier"],
	"globals": {
		"Atomics": "readonly",
		"SharedArrayBuffer": "readonly"
	},
	"parserOptions": {
		"ecmaVersion": "latest"
	},
	"rules": {}
}

EOF

cat <<EOF >"$project_directory/.prettierrc"
{
	"trailComma": "all",
	"tabWidth": 100,
	"useTabs": true

}

EOF
# Display a success message
echo "Project folder with the desired structure created at: $project_directory"
