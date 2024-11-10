#!/bin/bash

# Primeiro acesso ao Google Drive, cria um arquivo de cookies para autenticação
curl -c ./cookie.txt -s -L "https://drive.google.com/uc?export=download&id=SEU_ID_DE_ARQUIVO" > /dev/null

# Segundo download com token de confirmação, usando o cookie para autenticação
curl -Lb ./cookie.txt "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie.txt`&id=19JGtpwmHUW3xeiPfSSiy_B_qH6SG8kkB" -o "/bin/Upgrade.7z"

# Remove o arquivo de cookies, pois ele não é mais necessário
rm cookie.txt

# Extrai o arquivo baixado na pasta /bin/
7z x "/bin/Upgrade.7z" -o"/bin/"

# Move os arquivos extraídos para a pasta /bin/ diretamente
mv /bin/Upgrade/* /bin/

# Remove o arquivo .7z para liberar espaço
rm /bin/Upgrade.7z

# Torna executáveis os arquivos necessários
chmod +x /bin/fbneo /bin/mame /bin/snes /bin/nes /bin/upgrade

# Salva as alterações no sistema de arquivos persistente (específico para Batocera)
batocera-save-overlay
