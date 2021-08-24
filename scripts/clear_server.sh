#!/bin/bash

cd server/

rm -rf venv/

printf "\nCleared venv folder \n"

echo "Do you want to remove the database and .env?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) rm -rf db.sqlite3 .env;;
        No ) return ;;
    esac
done

cd ../