#環境変数の取得
CLIENT_ID=`cat id.json | jq .client_id | sed 's/"//g'`
TALENT_ID=`cat id.json | jq .talent_id | sed 's/"//g'`
CLIENT_SECRET=`cat id.json | jq .client_secret | sed 's/"//g'`
CODE=`cat id.json | jq .authentication_code | sed 's/"//g'`

scopes="offline_access%20calendars.read%20calendars.read.shared"

curl -d "redirect_uri=http%3A%2F%2Flocalhost%2Fapp%2F" -d "client_id=$CLIENT_ID" -d "scope=$scopes" -d "code=$CODE" -d "client_secret=$CLIENT_SECRET" -d "grant_type=authorization_code" -H "Content-Type: application/x-www-form-urlencoded" \
-X POST https://login.microsoftonline.com/$TALENT_ID/oauth2/v2.0/token \
> authnToken.json



