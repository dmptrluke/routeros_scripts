# SPDX-License-Identifier: CC0-1.0

# Define globals for import, and import variables
:global telegramBotKey;
:global chatID;
/system script run util_secrets

:local currentDNS [/ip dns get server]
:local primaryDNS "10.10.100.2"
:local backupDNS "1.1.1.1"
:local testDomain "www.google.com"

:if ($currentDNS = $primaryDNS) do={
    :do {
        :resolve $testDomain server $primaryDNS
    } on-error={
		:log info "Primary DNS not working. Changed DNS from $currentDNS to $backupDNS."
        /ip dns set servers=$backupDNS
        /tool fetch "https://api.telegram.org/bot$telegramBotKey/sendmessage?chat_id=$chatID&text=Primary DNS not working. Changed DNS from $currentDNS to $backupDNS." keep-result=no
    }
} else={
    :do {
        :resolve $testDomain server $primaryDNS
		:log info "Primary DNS is working again. Changed DNS from $currentDNS to $primaryDNS." 
        /ip dns set servers=$primaryDNS
        /tool fetch "https://api.telegram.org/bot$telegramBotKey/sendmessage?chat_id=$chatID&text=Primary DNS is working again. Changed DNS from $currentDNS to $primaryDNS." keep-result=no
    } on-error={}
}