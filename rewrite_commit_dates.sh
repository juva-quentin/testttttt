#!/bin/bash

# Commencer le rebase interactif à partir du premier commit
git rebase -i --root

# Initialiser une date de début
current_date=$(date "+%Y-%m-%dT%H:%M:%S")  # Aujourd'hui

# Intervalle de jours à ajouter entre chaque commit
days_to_add=1

# Boucle pour amender chaque commit avec une nouvelle date
while true; do
    # Modifier le commit actuel avec une nouvelle date
    GIT_COMMITTER_DATE="$current_date" git commit --amend --no-edit --date="$current_date"

    # Ajouter un jour à la date actuelle
    current_date=$(date -j -v+${days_to_add}d -f "%Y-%m-%dT%H:%M:%S" "$current_date" "+%Y-%m-%dT%H:%M:%S")

    # Continuer le rebase
    git rebase --continue || break
done

echo "Dates mises à jour. Vous devrez peut-être forcer le push avec : git push --force"
