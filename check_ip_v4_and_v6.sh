#!/bin/bash
#-----
# networking script for unix =====>>> ITP/IP
#----
make_function() {
    printf -- "-------BASH NETWORKING MENU-------:\n"
    printf -- "1) ifconfig       - show all network interfaces\n"
    printf -- "2) networksetup   - show IPv4 and IPv6 config for Wi-Fi\n"
    printf -- "3) ipconfig       - show IPv4 address for the en0 interface\n"
    printf -- "4) scutil         - show network state with IPv4 and IPv6 addresses\n"
    printf -- "----------------------------------\n"

    read -p "Select an option: " choice

    case "$choice" in
        1)
            echo "=========================================================" >> wireless_network.log
            echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - network interfaces" >> wireless_network.log
            ifconfig > >(tee -a wireless_network.log)
            ;;
        2)
            echo "=========================================================" >> wireless_network.log
            echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - ipv4 and ipv6" >> wireless_network.log
            networksetup -getinfo Wi-Fi > >(tee -a wireless_network.log)
            ;;
        3)
            echo "=========================================================" >> wireless_network.log
            echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - ipv4 address for the en0 interface" >> wireless_network.log
            ipconfig getifaddr en0 > >(tee -a wireless_network.log)
            ;;
        4)
            echo "=========================================================" >> wireless_network.log
            echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - network state" >> wireless_network.log
            scutil --nwi > >(tee -a wireless_network.log)
            ;;
        *)
            echo "[INFO] No output logged..."
            ;;
    esac
}

while true; do
    make_function
    echo
    read -p "Retry? (yes or no): " retry_choice
    retry_choice=$(echo "$retry_choice" | awk '{print tolower($0)}')

    if [[ "$retry_choice" == "no" || "$retry_choice" == "n" ]]; then
        echo "[INFO] End of program..."
        break
    fi;
done;

if [[ -f wireless_network.log && $(wc -c < wireless_network.log) -gt 50000 ]]; then
    mv wireless_network.log wireless_network.log.old
fi;