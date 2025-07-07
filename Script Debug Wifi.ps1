# FORCE L'ENCODAGE EN UTF8 SANS BOM
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)

WRITE-HOST "=========================================="
WRITE-HOST "  RESET COMPLET DES PROFILS WIFI WINDOWS"
WRITE-HOST "=========================================="

# LISTE DES PROFILS EXISTANTS
WRITE-HOST ""
WRITE-HOST "LISTE DES PROFILS WIFI DETECTES :"
$PROFILS = netsh wlan show profiles | Select-String "Profil Tous les utilisateurs" | ForEach-Object {
    ($_ -split ":")[1].Trim()
}

IF ($PROFILS) {
    $PROFILS | ForEach-Object {
        WRITE-HOST "PROFIL DETECTE :" $_
    }
} ELSE {
    WRITE-HOST "AUCUN PROFIL WIFI DETECTE."
}

# SUPPRESSION DE TOUS LES PROFILS
WRITE-HOST ""
WRITE-HOST "SUPPRESSION DE TOUS LES PROFILS WIFI..."
netsh wlan delete profile name=*

# VIDAGE CACHE DNS
WRITE-HOST ""
WRITE-HOST "VIDAGE DU CACHE DNS..."
ipconfig /flushdns

# REINITIALISATION WINSOCK
WRITE-HOST ""
WRITE-HOST "REINITIALISATION DU WINSOCK..."
netsh winsock reset

# REINITIALISATION TCP/IP
WRITE-HOST ""
WRITE-HOST "REINITIALISATION TCP/IP..."
netsh int ip reset

# AFFICHAGE D'UN MESSAGE FINAL
WRITE-HOST ""
WRITE-HOST "TOUT EST FAIT ! REDEMARRE TON PC POUR APPLIQUER LES CHANGEMENTS."
PAUSE
