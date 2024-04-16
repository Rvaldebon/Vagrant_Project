#!/bin/bash

# Fonction pour attendre pendant un certain temps
wait_for_seconds() {
  local seconds="$1"
  echo "Attente de $seconds secondes..."
  sleep "$seconds"
}

# Répertoires où exécuter "vagrant up"
directories=("./Linux" "../Windows_Client" "../Windows_Server")

# Exécuter "vagrant up" dans chaque répertoire et attendre 10 secondes entre chaque
for dir in "${directories[@]}"; do
  echo "Se déplaçant vers le répertoire : $dir"
  cd "$dir" || exit 1
  vagrant up
  wait_for_seconds 5
done

# Lancer VirtualBox
echo "Lancement de VirtualBox..."
virtualbox
