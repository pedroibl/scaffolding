#!/bin/bash

# Create the project directory
project_directory="PHPprojects"

# Set the project name, change "MyProject" to your desired project name
project_name="PHPproject-NoFramework"
mkdir -p "$HOME/Documents/docker-dev"

# Create the base project directory
project_directory="$HOME/Documents/docker-dev/$project_name"

mkdir -p "$project_directory/src"
mkdir -p "$project_directory/vendor"
mkdir -p "$project_directory/src/Store"

# Create .env file
touch "$project_directory/.env"

# Create index.php, db_config.php, and insert_data.php
touch "$project_directory/index.php"
touch "$project_directory/db_config.php"
touch "$project_directory/insert_data.php"

# Create src directory and files
mkdir -p "$project_directory/src"
touch "$project_directory/src/Dotenv.php"
touch "$project_directory/src/Loader.php"
touch "$project_directory/src/Store/FileStore.php"
touch "$project_directory/src/Store/PutenvStore.php"
touch "$project_directory/src/Validator.php"

# Create vendor directory (optional)
mkdir -p "$project_directory/vendor"

cat <<EOF >"$project_directory/.env"
DB_HOST='localhost'
DB_USER='your_username'
DB_PASS='your_password'
DB_NAME='your_database_name'
EOF

cat <<EOF >"$project_directory/index.php"
<!DOCTYPE html>
<html>
<head>
    <title>PHP Form Example</title>
</head>
<body>
    <h1>Submit Form Data</h1>
    <form action="insert_data.php" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="role">Role:</label>
        <input type="text" id="role" name="role" required><br><br>

        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" required><br><br>

        <input type="submit" value="Submit">
    </form>
</body>
</html>
EOF

cat <<EOF >"$project_directory/db_config.php"
<?php
require_once __DIR__ . '/src/Dotenv.php';
require_once __DIR__ . '/src/Loader.php';
require_once __DIR__ . '/src/Store/FileStore.php';
require_once __DIR__ . '/src/Store/PutenvStore.php';
require_once __DIR__ . '/src/Validator.php';

$dotenv = new Dotenv\Dotenv(__DIR__);
$dotenv->load();
// Rest of the code remains the same
?>
EOF

echo <<EOF >"$project_directory/insert_data.php"
<?php
require_once __DIR__ . '/db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST["name"];
    $role = $_POST["role"];
    $phone = $_POST["phone"];

    // Using prepared statement to prevent SQL injection
    $sql = "INSERT INTO users (name, role, phone) VALUES (?, ?, ?)";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "sss", $name, $role, $phone);

    if (mysqli_stmt_execute($stmt)) {
        echo "Data inserted successfully!";
    } else {
        echo "Error: " . mysqli_error($conn);
    }

    mysqli_stmt_close($stmt);
}

mysqli_close($conn);
?>
EOF

cat <<EOF >"$project_directory/src/Dotenv.php"
<?php

namespace Dotenv;

use Dotenv\Exception\InvalidPathException;

class Dotenv
{
    /**
     * Load the environment file from the given path.
     *
     * @param  string  $path
     * @param  string|null  $file
     * @return void
     *
     * @throws \Dotenv\Exception\InvalidPathException
     */
    public static function load($path, $file = null)
    {
        if (!is_null($file)) {
            $path = rtrim($path, DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR.$file;
        }

        if (!file_exists($path) || !is_readable($path)) {
            throw new InvalidPathException(sprintf(
                'Dotenv: Unable to read the environment file at %s.',
                $path
            ));
        }

        $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

        foreach ($lines as $line) {
            if (strpos(trim($line), '#') === 0) {
                continue;
            }

            list($name, $value) = self::parseLine($line);

            if ($name) {
                $_ENV[$name] = $value;
                $_SERVER[$name] = $value;
            }
        }
    }

    /**
     * Parse a line to get key and value.
     *
     * @param  string  $line
     * @return array
     */
    protected static function parseLine($line)
    {
        if (strpos($line, '=') !== false) {
            list($name, $value) = explode('=', $line, 2);
            $name = trim($name);
            $value = trim($value, '"\'');

            return [$name, $value];
        }

        return [null, null];
    }
}
EOF

cat <<EOF >"$project_directory/src/Loader.php"
<?php

namespace Src;

class Loader
{
    protected $filePath;
    protected $data = [];

    public function __construct($filePath)
    {
        $this->filePath = $filePath;
    }

    public function load()
    {
        if (file_exists($this->filePath)) {
            $contents = file_get_contents($this->filePath);
            $lines = explode(PHP_EOL, $contents);

            foreach ($lines as $line) {
                $line = trim($line);

                // Skip empty lines or comments starting with #
                if (empty($line) || $line[0] === '#') {
                    continue;
                }

                list($key, $value) = explode('=', $line, 2);

                $key = trim($key);
                $value = trim($value);

                // Remove single or double quotes surrounding the value (if any)
                if ((strpos($value, '"') === 0 && strrpos($value, '"') === strlen($value) - 1)
                    || (strpos($value, "'") === 0 && strrpos($value, "'") === strlen($value) - 1)) {
                    $value = substr($value, 1, -1);
                }

                $this->data[$key] = $value;
            }
        }
    }

    public function get($key, $defaultValue = null)
    {
        return isset($this->data[$key]) ? $this->data[$key] : $defaultValue;
    }
}

EOF

cat <<EOF >"$project_directory/src/Store/FileStore.php"
<?php

namespace src\Store;

class FileStore
{
    private $filePath;

    public function __construct($filePath)
    {
        $this->filePath = $filePath;
    }

    public function get()
    {
        if (!file_exists($this->filePath)) {
            throw new \Exception("File does not exist: $this->filePath");
        }

        return parse_ini_file($this->filePath, true);
    }

    public function put(array $data)
    {
        $content = "";
        foreach ($data as $section => $values) {
            $content .= "[$section]\n";
            foreach ($values as $key => $value) {
                $content .= "$key=$value\n";
            }
            $content .= "\n";
        }

        if (!file_put_contents($this->filePath, $content)) {
            throw new \Exception("Failed to write to file: $this->filePath");
        }
    }
}

EOF

cat <<EOF >"$project_directory/src/Store/PutenvStore.php"
<?php

namespace src\Store;

class PutenvStore
{
    public function get($key)
    {
        $value = getenv($key);

        return $value === false ? null : $value;
    }

    public function put($key, $value)
    {
        if (!putenv("$key=$value")) {
            throw new \Exception("Failed to set environment variable: $key");
        }
    }
}

EOF

cat <<EOF >"$project_directory/src/Validator.php"
<?php

namespace src;

class Validator
{
    public static function validateName($name)
    {
        // Validate the name - for example, check if it's not empty
        if (empty($name)) {
            return false;
        }

        // Add more validation rules as needed

        return true;
    }

    public static function validateRole($role)
    {
        // Validate the role - for example, check if it's not empty
        if (empty($role)) {
            return false;
        }

        // Add more validation rules as needed

        return true;
    }

    public static function validatePhone($phone)
    {
        // Validate the phone number - for example, check if it's not empty and contains only digits
        if (empty($phone) || !ctype_digit($phone)) {
            return false;
        }

        // Add more validation rules as needed

        return true;
    }
}
EOF

# Output success message
echo "Project scaffolded successfully in $project_directory!"
