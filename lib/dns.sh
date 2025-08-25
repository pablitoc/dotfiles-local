alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
# sudo killall -HUP mDNSResponder

alias hupdns='while :; do sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; if curl -I https://ies.firstam.com; then break; fi; sleep 1; done'