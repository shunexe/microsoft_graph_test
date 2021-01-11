#環境変数の取得
CLIENT_ID=`cat id.json | jq .client_id | sed 's/"//g'`
TALENT_ID=`cat id.json | jq .talent_id | sed 's/"//g'`
CLIENT_SECRET=`cat id.json | jq .client_secret | sed 's/"//g'`

echo authnTokenを再取得します

refresh_token=`cat authnToken.json | jq .refresh_token | sed 's/"//g'`
scopes="offline_access%20calendars.read%20calendars.read.shared"

curl -sS -d "redirect_uri=http%3A%2F%2Flocalhost%2Fapp%2F" -d "client_id=$CLIENT_ID" -d "scope=$scopes" -d "refresh_token=$refresh_token" -d "client_secret=$CLIENT_SECRET" -d "grant_type=refresh_token" -H "Content-Type: application/x-www-form-urlencoded" \
-X POST https://login.microsoftonline.com/$TALENT_ID/oauth2/v2.0/token \
> authnToken.json

echo 再取得完了


token=`cat authnToken.json | jq .access_token | sed 's/"//g'`

# me/calendars
#↓response
#"Calendar"
#"日本の休日"
#"誕生日"
#curl -sS -H "Authorization: $token" https://graph.microsoft.com/v1.0/me/calendars | jq '.value[].name'

# me/calendar/events

#curl -sS -H "Authorization: $token" https://graph.microsoft.com/v1.0/me/events | jq '.value[].subject'
#curl -sS -H "Authorization: $token" "https://graph.microsoft.com/v1.0/me/events?\$select=subject" | jq .value
# /me/calendar/calendarView?startDateTime={start_datetime}&endDateTime={end_datetime}
start_datetime=2020-12-02T00:00:00.0000000
end_datetime=2020-12-31T23:59:00.0000000

list=$(curl -sS -H "Authorization: $token" -H "Prefer: outlook.timezone=\"Tokyo Standard Time\"" "https://graph.microsoft.com/v1.0/me/calendar/calendarView?\$top=200&startDateTime=$start_datetime&endDateTime=$end_datetime" \
| jq '.value | sort_by(.start.dateTime) | map(.subject)')

node countWeekly.js $list

#curl -sS -H "Authorization: $token" \
#https://graph.microsoft.com/v1.0/me/calendar/calendarView?startDateTime=2017-01-01T00:00:00.0000000&endDateTime=2018-12-30T00:00:00.0000000

