#!/bin/bash

# Set the project name, change "MyProject" to your desired project name
project_name="TypeScriptMVCAPIProject"

# Create the base project directory
project_directory="$HOME/Documents/docker-dev/$project_name"

# Create the project folders
mkdir -p "$project_directory/src"
mkdir -p "$project_directory/tests"
mkdir -p "$project_directory/src/api"

#src/config
mkdir -p "$project_directory/src/config"
mkdir -p "$project_directory/src/config/swagger"

# src/v1
mkdir -p "$project_directory/src/v1"
mkdir -p "$project_directory/src/v1/controllers"
mkdir -p "$project_directory/src/v1/controllers/tests"
mkdir -p "$project_directory/src/v1/helpers"
mkdir -p "$project_directory/src/v1/helpers/tests"
mkdir -p "$project_directory/src/v1/interfaces"
mkdir -p "$project_directory/src/v1/interfaces/tests"
mkdir -p "$project_directory/src/v1/interfaces/types"
mkdir -p "$project_directory/src/v1/middlewares"
mkdir -p "$project_directory/src/v1/middlewares/tests"
mkdir -p "$project_directory/src/v1/models"
mkdir -p "$project_directory/src/v1/models/tests"
mkdir -p "$project_directory/src/v1/routes"
mkdir -p "$project_directory/src/v1/routes/tests"
mkdir -p "$project_directory/src/v1/services"
mkdir -p "$project_directory/src/v1/services/tests"
mkdir -p "$project_directory/src/v1/validations"
mkdir -p "$project_directory/src/v1/validations/tests"

create an index.ts in each folder to export
touch "$project_directory/src/v1/services/UserService.ts"
touch "$project_directory/src/config/constants.ts"
touch "$project_directory/src/config/DatabaseConfig.ts"
touch "$project_directory/src/config/Logger.ts"
touch "$project_directory/src/index.ts"

# Create the controller files
touch "$project_directory/src/v1/controllers/UserController.ts"
touch "$project_directory/controllers/OtherController.js"

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
touch "$project_directory/readme.md"

# readme.md Content
cat <<EOF >"$project_directory/readme.md"
# Run:

npm init -y
npm install express --save
npm install body-parser --save
npm install dotenv --save
npm install nodemon --save

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
const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.send('hello world')
})

app.listen(3000)
EOF

########################################################
# index.js Content at routes folder
cat <<EOF >"$project_directory/routes/index.js"
const express = require('express');
const router = express.Router();

// Define your routes here
router.get('/', (req, res) => {
  res.send('<h1>MVC folder structure for ExpressJS <br> It was Scaffolded via bash script. <br> Github: https://github.com/pedroibl <br> Follow the readme.md to start</h1>');
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
DB_HOST=localhost
DB_PORT=3306
DB_USER=pedrodev
DB_PASSWORD=My_database_password
DB_NAME=expressMVC

# API keys and secrets
API_KEY=your_api_key_here
SECRET_KEY=your_secret_key_here

# App settings
APP_PORT=3000
APP_ENV=development

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

find "$project_directory/src" -type d -exec touch {}/index.ts \;
# Display a success message
echo "Project folder with the desired structure created at: $project_directory"
