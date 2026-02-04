#!/usr/bin/env bash

echo "Copiez la ligne complète 'cookie:' depuis les Request Headers de votre navigateur"
echo "puis appuyez sur Entrée et Ctrl+D pour terminer:"
echo ""

# Lit l'input de l'utilisateur
cookies=$(cat)

# Nettoie l'input (enlève "cookie:" si présent au début)
cookies=$(echo "$cookies" | sed 's/^cookie: *//i' | tr -d '\n')

if [ -z "$cookies" ]; then
    echo "Aucun cookie fourni!"
    exit 1
fi

echo ""
echo "Cookies extraits avec succès!"
echo ""
echo "Éditez maintenant le fichier check_permis_api.sh :"
echo ""
echo "nano check_permis_api.sh"
echo ""
echo "Et remplacez la ligne:"
echo 'COOKIES=""'
echo ""
echo "par:"
echo "COOKIES=\"$cookies\""
echo ""
echo "Ou exécutez cette commande:"
echo ""
echo "sed -i 's|^COOKIES=\"\"$|COOKIES=\"$cookies\"|' check_permis_api.sh"
