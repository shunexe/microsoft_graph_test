#環境変数の取得
CLIENT_ID=`cat id.json | jq .client_id | sed 's/"//g'`
TALENT_ID=`cat id.json | jq .talent_id | sed 's/"//g'`
CLIENT_SECRET=`cat id.json | jq .client_secret | sed 's/"//g'`

scopes="offline_access%20calendars.read%20calendars.read.shared"

url="https://login.microsoftonline.com/$TALENT_ID/oauth2/v2.0/authorize?client_id=$CLIENT_ID&response_type=code&response_mode=query&scope=$scopes&state=12345&redirect_uri=http%3A%2F%2Flocalhost%2Fapp%2F"

echo $url
#curl -I -L $url
#curl -I -s -c cookie.txt $url
#
#code=`node parseCookie.js`
#echo $code
#
#curl -d "client_id=$client_id" -d "scope=$scopes" -d "code=$code" -d "client_secret=$client_secret" \
#-d "grant_type=authorization_code" -H "Content-Type: application/x-www-form-urlencoded" \
#-X POST https://login.microsoftonline.com/$talent_id/oauth2/v2.0/token \
#> authnToken.json