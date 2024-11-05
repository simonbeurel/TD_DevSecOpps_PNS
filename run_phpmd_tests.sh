#!/bin/bash

# Chemin vers PHPMD
PHPMD="./vendor/bin/phpmd"

# Répertoires à tester
DIRECTORIES=("src" "public")

# Règles à tester
RULES=(
    "codesize"
    "unusedcode"
    "naming"
)

# Exécution de PHPMD sur chaque fichier PHP dans les répertoires spécifiés
for DIRECTORY in "${DIRECTORIES[@]}"; do
    echo "Testing directory: $DIRECTORY"

    # Trouver tous les fichiers PHP dans le répertoire
    FILES=$(find "$DIRECTORY" -type f -name "*.php")

    # Vérifier si des fichiers PHP existent dans le répertoire
    if [ -z "$FILES" ]; then
        echo "No PHP files found in $DIRECTORY."
        continue
    fi

    # Boucle à travers chaque fichier et chaque règle
    for FILE in $FILES; do
        echo "Testing file: $FILE"
        for RULE in "${RULES[@]}"; do
            echo "Running PHPMD with rule: $RULE"
            $PHPMD "$FILE" text "$RULE" || echo "PHPMD failed for rule: $RULE"
            echo "-----------------------------------"
        done
    done
done
