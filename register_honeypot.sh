
DB_PATH="/opt/chnserver/storage/chnserver/sqlite/mhn.db"
read -r -p "Enter the server hostname (e.g. https://csirt-cy.com): " HOSTNAME
read -r -p "Enter the bearer token: " TOKEN


sudo apt-get update && sudo apt-get install -y sqlite3
API_KEY=$(sqlite3 "${DB_PATH}" "SELECT api_key FROM api_key LIMIT 1;")

echo "$API_KEY"

curl --location "$HOSTNAME/api/honeypot-register" \
--header 'Accept: application/json' \
--header "Authorization: Bearer $TOKEN" \
--form "api_key=$API_KEY"
