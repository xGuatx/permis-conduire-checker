#!/usr/bin/env bash

# Couleurs ANSI
GREEN="\e[32m"
RED="\e[31m"
ORANGE="\e[33m"
BLUE="\e[34m"
YELLOW="\e[93m"
RESET="\e[0m"

# Configuration
BASE_URL="https://candidat.permisdeconduire.gouv.fr/api/v1/candidat/creneaux?code-departement="
DELAY=3  # Délai entre chaque requête (3 secondes pour éviter rate limiting)

# ===================================================================
# COOKIES - IMPORTANT: À copier depuis votre navigateur
# ===================================================================
# 1. Connectez-vous sur candidat.permisdeconduire.gouv.fr
# 2. Ouvrez DevTools (F12) > Onglet Network
# 3. Faites une recherche de créneaux sur le site
# 4. Cliquez sur la requête 'creneaux?code-departement=...'
# 5. Dans Request Headers, copiez TOUTE la valeur du champ 'cookie:'
#    (tout ce qui vient après "cookie: ")
# 6. Collez-la entre les apostrophes ci-dessous:


COOKIES='TCPID=125126031149453783446; cf_clearance=rk4AI9aM30SnDJV1CzBP8tOP1N9to_8ydqKbO1TmSCY-1768809054-1.2.1.1-sNx3BVXBSuGhD.Aes3YbyuowM9Q7C2J_ewOfosmAakt5gcjdNCCEZXsg720lp0W6AYiWaoxWAQB8PkUV_VSjyUWtVZgGstXZOh7TWsdQMwdWUeVoWbh8lCefgf1Qx1odDW8c4d190lZCvIAFMRwtTnfJFv2F7_6RoK5k65wmnGWrou.kK16lgaMn4XTTx62.o_K0ds4uLQsBJSXOYRiOEkcXT4josT4i5JqyXpODvNA; mod_auth_openidc_session=eyJhbGciOiAiZGlyIiwgImVuYyI6ICJBMjU2R0NNIn0..Om0kkjxWoyupYc5X.QOIzrrt2rYEwG3JABSCnE4mx_1chIeFFfxIFKtZDl3Rdxo4COSUpTjNunfnOu0FBpSez12XuCNl6Q8ia_gUuuCiW-mFMFk9n6FevG8nWVp_gS2KdYIzJYYxxPtKs1Rnq0peif9p7Na9G7BoykhDBy70kbaPIhvLruEp4W6eB7VhSH3p2_pYEKdmybp9-8caCtHLZdi_2BJDEbH61qpQ_6SNX2LrbuhZJ-7bxrPhnwNArdW4W_N6TWikpMXZLyOulnTHpXvg3jDRJp3TwJAFVaDRYOlaliO6iG3BE310bA-R6yLG910fNCoJPBQ1sztMC9OMotqMw72XMosr4_0h6HJjsmtlomxftqaqajWhv9rGZv0bRW1QAl_mD3cZaG8ii1pf21Ccjjp5KpEnEG6ymO0d4f4Zp8Gb_0mWPyMBdHA7Ee1VSNn_kjdXHIlDkc1D2i_nLls1s78aOjtI4CC8WNzof8-Kt9FIVS9TBE9l3QET85hzArIjCY9QeLhtHxl3nrfq7tNUhmGLOKUSnB3564UJKptmt-UQrUkEXiHB5akRA7V_OKEqXocSCHTWINsjfhxxxY8lP2Qq8CvLT8MT2v23jvF2nbOcFS7SBh450HXPahIcVKpe8dFNsIB6hg5OKsaChgPeV9mydBsjImpDH0d5TQdSCaana4EA7R1tdE9L0Jx5OWiMYkXm9jeoTIt17ydPj1ED8CCi0wEtnadcqsbWDJEeTchj15hw_BhXLjLL7icCDjvFxbou_QtHN0t3qZVbzu7dsF3wfOgXcpuFvefTZR6KDoE_0bW5tTPm6k2hgLQy7Z518Seom6MBIZ40RLI1p_EDE3tapz7svVD5VFiW5fnkM_Df8p84aW4QWob8rm3cVf9ou-GllGSLwUJCT5Cr9-KV6YQfEeCWxSBfv_wv8k_Y1TQY6In8uDs2OGfCVVBF2wawHxtgfpCqZ93uWVfo9BUKBhlEPfvba05LjMYTTeiAuAZ5zGdTFLkz0xtrKO3a7ErJqhzugXJzoZAX-W2sfl_LAxbnxnJYESYswHZtPRXYeLx0HTheuMUw9or8XjZXGtIvLgo0pu2vkR3QH5aKpLk7IvZjvVAS1AjtCkZdICNXE7h-LZEJSvKVZ30SjBALTfdEIdTIddMuu7KQxASa9sgb6bkO3ourJKxABmHJv52jUbESpG_CD4K-2ej92-Wu57yw2WRNqwtDt0YvVuPdkQxKB0szb7J-lc8NBWabF_qkDD8j-N7mD8kGjCGFc_bHTQHerrZlna88p3RVeY1PuSSomT_4qrqTuy2-T2_AAp0J5ZEKrfSQym6m1LI7_LrFjOlUxptz9zfJN7zdQIHPoKZMXHEn6zGccsB96SEHnkD1HWCrqxsTnCIQU9yVltsGdZscSWG1FFp5qAReCjutPv-Wm4gb3EoaUZvQa-RnIDq_xVPErhNsjbIBWJCj2ltHW4CRs_KFT_S0Zy-gVD7dc2tCIyoQKBreeViRkCS8hfFawRkhhRCwL7cLQNd94OPshLd1OPsUt3-3Wa3HYuUT9VTjDho2B59nRyTU3sm3C7DmojMhXOv0StyC7jpF57ugkdl0fd28831nyZOCa-J-zNA_TmuHiD5xTW-e6Eui8qAl2qJ5jna4Y576RfklVnhAiIV1UNmf930H7dOawmAKSrFXcLRHp_HOo6Y7kVURol63GOZlRdUWi5dPF2OvKCK7qYGvQA56OprmkKe5ATslo6ukB9rvJbEzIfysm0yM0ECbSi6nnF9UhXApmppGae276KchymX-LPITu4W2ZXA_hvqI4lH3fTRi22sPXMv24Xn4vzx1Fjw7yRKekUAI6uyPHlhJow8YmHkzYA8tzK4zMpymKcFQe1TOLydPwD3Epavr4iaw5VmktqDPYU7jZhRecI-Q5mu4VvBWyD1XVobR0YjWz0VRGLHO_1Gh5mBd7n3tXni7zyvEpzBNZU8Vp-a9_--l1QqvrXZFIb5xlPsxZfHdh1rf5VAYhIJdItnz6GeMFq77T24i68-YJMt9xsgAVdzf-tOGE4Z65XFDomN_OeSOqXxMtWr9d_CBKEQVlMXsvjyjJlRx8C4RkZGxzs9zCI6zrUilk9k5aMtQv7G0V10PRbHThg4YusNFamScQbnMVIl3dSXgUZRHiURHNH4F4ROPCn5pBwetSDO5JblvRW4e1aO1PExRQCIBOcEOzZsnxAYn2PhxqJeNzOfpiEzEsRcGs2Ul5WlfhT9cxQxGR6ROm5tDXN1TN0lC1MnkxX0n5v6eBpiqW7-A90sUvt1G7OQT4E038Bbvn3ECTBlE-VXjZi_dF7j2s1j-Z8HFAkAJx7uznUFNpI8Y3rqfij0by2hppIR2t8MSFWYxiDDw41KA9occDV496eGBC9OxSneS4mAN-8zfoJiJcnnwyWoP2hLhOnvJBa8BVH2-1inIInxAudqJAMuM_BwpJgU-4ltxbDSjPGfgEnfPD0giXrJOR-j6T5Y6STRyDfreewcQxxKT18UgqLDHRsmdv2NfJO9pmmPECmRM4_V-D_0gYM-dEJaIpt3HoGysGy83vhQmx8-NVIVRTNbYYKGddjBnVWwd4_0cK2TIxoOCGkuFVPZ_0ZrTlE-6PZcinTQK-bs2vyyGm_e5q_BoQAno_UaAKewuUL7RcAZzX8hubQMBo1vDUhfpP9Es5t0Q_6uYL8Imxd7CJCTszhqEc05FZ3HjEtRS0uiomTTFJp_LYWJwKtz_yjLkVs3aBJvg2_hFf1HP59ccszW9FaMcQOJNWb9p3cDMMS0dofW8aUv9WgAFlulxKbU9MfvO-ky1lHaIyoFy8kiu9d_BV1oJPOz7_pj-6VhfuQkQytgYGLFfTdPNEJlxTx4PI_LCcJebABosNqGbUv02yba7GjnW1or_fC9sSg_vcGvSbsx7ugT-s9ZpIKMgEqnxfFJu8hTnocwB0ze9vvVhRXtJNwd6XvMCbL0rF1lUUx1iDuxpo3-9e6NfBajyowdnnMv1DYp5ie-2M6umfwovaABpH4DGieM0DzP2D0H6b7S1yMROt8kHtPFtKIxBacsiYqP_cPMHRaBs7IvmHBhEvImxu8v2ZegUsgHLzWgdhN3POHWNcZPvijf0ZYxyr644Q35CsHXrzbsqdcleUPGP4YzHbB5ISdUIWK7dJbI5JpqWM0Dukz_k8bjjJXeoQa91GI8BrxkDZz7CPJ2OVtuKg6sGeTTUSPlSUHl7sJM-Pl7MvcO8qKQLWX_9D5Ny81nEgnXlL5-sU-0Q2zJhK7b6q7Ajrk3rD2Jchuw1b5qVuNxJuGfEB4elAVQztjFY2sUWEwznltq4SKsDm2WI9yxgBlLczv27MsFXhA3d6clwTyIfQ1gc4Ym8l4ikAXwz8ehR7QCqdVJEgtRwZRQxBaYIp5FqYiuTFR3vpMwSdBMw9w4khvqYGsba0Dhemgg7b-HXwZDhQD6dgd9Ozh138TKCwuLNJBpcetjw99IvO873q1XnAXj-zfsxLEAoxRZLAahb8wPoIICzZvlRNO3E-65bR6x8-ckpb-QPE.c4k1J8UzoduGjazJpCDjsQ; etuix=hXlGYjZQDlq5IxSzU421sO_NsMhUHqIAL3izw9VB9yX1iMU9_SRxHw--; __cf_bm=pFglxW8AYs2Vfsv_9iCcx1dKNnrlf0je7OrOwYkDEFY-1768809183.177114-1.0.1.1-PFpz5Fu4da8ToZ20RCPMy61EMVPJ.FUWl931C3Gi3QKSF1ezA2RKvOnLN1bYOumpWbc98KUQuVyWVZ8bkl6hy3RIh_bb_q_FP8d.AS9k7IIS5jSiFpbC_8rS9IXnbkOU'

# ===================================================================

echo -e "${BLUE}╔═══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║    Scan des codes département (001 à 099)                ║${RESET}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════╝${RESET}"
echo ""

# Vérification des cookies
if [ -z "$COOKIES" ]; then
    echo -e "${RED}✗ ERREUR: Aucun cookie configuré!${RESET}"
    echo ""
    echo -e "${YELLOW}Pour obtenir les cookies:${RESET}"
    echo "  1. Connectez-vous sur candidat.permisdeconduire.gouv.fr"
    echo "  2. Ouvrez DevTools (F12) → Network"
    echo "  3. Recherchez des créneaux sur le site"
    echo "  4. Cliquez sur la requête 'creneaux?code-departement=...'"
    echo "  5. Copiez la valeur complète du header 'cookie:'"
    echo "  6. Éditez ce script:"
    echo "     nano $0"
    echo "  7. Collez entre les apostrophes: COOKIES='...'"
    echo ""
    exit 1
fi

# Test de connexion
echo -e "${YELLOW}Test de connexion...${RESET}"
test_response=$(curl -s -w "\n%{http_code}" \
    -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Referer: https://candidat.permisdeconduire.gouv.fr/reservation/recherche-creneaux" \
    -H "Cookie: $COOKIES" \
    "${BASE_URL}01" 2>/dev/null)

test_code=$(echo "$test_response" | tail -n1)
test_body=$(echo "$test_response" | sed '$d')

if [ "$test_code" == "403" ] || echo "$test_body" | grep -q "Cloudflare"; then
    echo -e "${RED}✗ Bloqué par Cloudflare - Cookies invalides ou expirés${RESET}"
    echo "Les cookies de session expirent rapidement (±30min)."
    echo "Veuillez récupérer de nouveaux cookies et relancer le script."
    exit 1
elif [ "$test_code" == "401" ]; then
    echo -e "${RED}✗ Non autorisé - Cookies expirés${RESET}"
    echo "Veuillez vous reconnecter et récupérer de nouveaux cookies."
    exit 1
else
    echo -e "${GREEN}✓ Connexion OK${RESET}"
    echo ""
fi

# Compteurs
total=0
vides=0
disponibles=0
invalides=0
erreurs=0

echo -e "${BLUE}Scan en cours...${RESET}"
echo ""

for i in $(seq -w 001 099); do
    code="${i}"
    url="${BASE_URL}${i}"

    ((total++))
    printf "[%2d/99] Code %s : " "$total" "$code"

    # Requête avec les cookies
    response=$(curl -s -w "\n%{http_code}" \
        -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" \
        -H "Accept: application/json, text/plain, */*" \
        -H "Referer: https://candidat.permisdeconduire.gouv.fr/reservation/recherche-creneaux" \
        -H "Cookie: $COOKIES" \
        "$url" 2>/dev/null)

    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')

    case "$http_code" in
        200)
            # Succès - vérifier si vide
            if [[ -z "$body" || "$body" == "{}" || "$body" == "[]" || "$body" == "null" ]]; then
                echo -e "${RED}Vide${RESET}"
                ((vides++))
            else
                echo -e "${GREEN}✓ CRÉNEAUX DISPONIBLES!${RESET}"
                ((disponibles++))
                # Affiche le body formaté
                if command -v jq &> /dev/null; then
                    echo "$body" | jq -C '.' 2>/dev/null || echo "$body"
                else
                    echo "$body"
                fi
                echo ""
            fi
            ;;
        400)
            # Vérifier si c'est une erreur de département invalide
            if echo "$body" | grep -q "CODE_DEPARTEMENT_INVALIDE"; then
                echo -e "${ORANGE}Code invalide${RESET}"
                ((invalides++))
            else
                echo -e "${ORANGE}Erreur 400${RESET}"
                ((erreurs++))
            fi
            ;;
        401)
            echo -e "${RED}✗ Session expirée${RESET}"
            echo "Les cookies ont expiré. Relancez le script avec de nouveaux cookies."
            exit 1
            ;;
        403)
            echo -e "${RED}✗ Bloqué par Cloudflare${RESET}"
            echo "Vous avez été bloqué. Attendez quelques minutes avant de relancer."
            exit 1
            ;;
        404)
            echo -e "${ORANGE}Code inexistant${RESET}"
            ((invalides++))
            ;;
        429)
            echo -e "${ORANGE}Rate limit - pause de 10s${RESET}"
            ((erreurs++))
            sleep 10
            ;;
        *)
            echo -e "${ORANGE}HTTP $http_code${RESET}"
            ((erreurs++))
            ;;
    esac

    # Délai pour éviter le rate limiting
    sleep "$DELAY"
done

echo ""
echo -e "${BLUE}╔═══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║                       RÉSUMÉ                              ║${RESET}"
echo -e "${BLUE}╠═══════════════════════════════════════════════════════════╣${RESET}"
printf "${BLUE}║${RESET} Total testé           : %-31s ${BLUE}║${RESET}\n" "$total codes"
printf "${BLUE}║${RESET} ${GREEN}✓ Créneaux disponibles${RESET} : %-31s ${BLUE}║${RESET}\n" "$disponibles"
printf "${BLUE}║${RESET} ${RED}○ Centres vides       ${RESET} : %-31s ${BLUE}║${RESET}\n" "$vides"
printf "${BLUE}║${RESET} ${ORANGE}× Codes invalides     ${RESET} : %-31s ${BLUE}║${RESET}\n" "$invalides"
printf "${BLUE}║${RESET} ${ORANGE}! Erreurs             ${RESET} : %-31s ${BLUE}║${RESET}\n" "$erreurs"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════╝${RESET}"
