#!/bin/bash

# Set the project name, change "MyProject" to your desired project name
project_name="ExpressMVCProject"
mkdir -p "$HOME/Documents/docker-dev"

# Create the base project directory
project_directory="$HOME/Documents/docker-dev/$project_name"
# Create the project folders Root
mkdir -p "$project_directory/src"
mkdir -p "$project_directory/public"
mkdir -p "$project_directory/config"

# Create the src
mkdir -p "$project_directory/src/components"
mkdir -p "$project_directory/src/assets"
mkdir -p "$project_directory/src/constants"
mkdir -p "$project_directory/src/core-ui"
mkdir -p "$project_directory/src/helpers"
mkdir -p "$project_directory/src/hooks"
mkdir -p "$project_directory/src/redux"

# Exclusive to typescript
mkdir -p "$project_directory/src/interfaces"

mkdir -p "$project_directory/src/pages"
mkdir -p "$project_directory/src/pages/AboutUs"
mkdir -p "$project_directory/src/pages/AboutUs/test"
mkdir -p "$project_directory/src/pages/Login"
mkdir -p "$project_directory/src/pages/Main"
mkdir -p "$project_directory/src/pages/Products"
mkdir -p "$project_directory/src/pages/Profile"
mkdir -p "$project_directory/src/pages/Registration"

mkdir -p "$project_directory/src/services"
mkdir -p "$project_directory/src/services/auth"
mkdir -p "$project_directory/src/validations"
mkdir -p "$project_directory/src/validations/schemas"

# Create Files src
touch "$project_directory/src/App.ts"
touch "$project_directory/src/index.ts"
touch "$project_directory/src/reportWebVitals.ts"

# Create Files src/assets
touch "$project_directory/src/assets/button.ts"
touch "$project_directory/src/assets/input.ts"

# Create Files src/pages
touch "$project_directory/src/pages/index.ts"
touch "$project_directory/src/pages/AboutUs/about-us.ts"
touch "$project_directory/src/pages/AboutUs/about-us.styles.ts"

touch "$project_directory/src/services/auth/AuthContext.ts"
touch "$project_directory/src/validations/schemas/index.ts"

# Create Files src/assets
# Create Files src/assets
# Create Files src/assets

# Create app.js, .gitignore, .env and readme.md

touch "$project_directory/.dockerignore"
touch "$project_directory/Dockerfile"
touch "$project_directory/.eslintrc"
touch "$project_directory/.prettierrc"
touch "$project_directory/.prettierignore"
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
# Display a success message
echo "Project folder with the desired structure created at: $project_directory"
