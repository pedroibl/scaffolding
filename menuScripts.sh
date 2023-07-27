#!/bin/bash

echo "Choose an option:"
echo "1. React Scaffolding"
echo "2. TypeScript Scaffolding"
echo "3. Express MVC Scaffolding"
echo "4. JS MVC Scaffolding 2"
echo "5. Exit"

read -p "Enter your choice (1-5): " choice

case $choice in
1)
    source ./ReactScaffolding.sh
    ;;
2)
    source ./TypeScriptScaffolding.sh
    ;;
3)
    echo "Running Express MVC Scaffolding..."
    source ./expressMVC.sh && cd ~/Documents/docker-dev/ExpressMVCProject && npm init -y

    # After sourcing the script, provide extra options
    echo "Extra options for Express MVC Scaffolding:"
    echo "1. Install additional packages"
    echo "2. Go back to main menu"

    read -p "Enter your choice (1-2): " express_option

    case $express_option in
    1)
        selected_packages=()
        while true; do
            echo "Select additional packages to install:"
            echo "1. Install express, body-parser, dotenv, nodemon, mysql"
            echo "2. Install eslint"
            echo "3. Configure ESLint"
            echo "4. Overwrite Prettierrc"
            echo "5. Done selecting"

            read -p "Enter your choice (1-4): " npm_option

            case $npm_option in
            1)
                selected_packages+=(express body-parser dotenv nodemon mysql)
                ;;
            2)
                selected_packages+=(eslint)
                ;;
            3)
                echo "Configuring ESLint..."
                npx eslint --init
                ;;
            4)
                echo "Overwriting Prettierrc..."
                echo ./
                
            5)
                break
                ;;
            *)
                echo "Invalid choice. Please enter a number from 1 to 4."
                ;;
            esac
        done

        if [ ${#selected_packages[@]} -gt 0 ]; then
            echo "Installing selected packages: ${selected_packages[@]}..."
            npm install ${selected_packages[@]} --save
        else
            echo "No additional packages selected. Skipping installation."
        fi
        ;;
    2)
        echo "Going back to main menu..."
        ;;
    *)
        echo "Invalid choice. Going back to main menu..."
        ;;
    esac
    ;;
4)
    source ./jsMVC-Scaffolding2.sh
    ;;
5)
    echo "Exiting..."
    exit 0
    ;;
*)
    echo "Invalid choice. Please enter a number from 1 to 5."
    exit 1
    ;;
esac
