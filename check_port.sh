#!/bin/bash


# script to test: netcat, telnet, openssl 

print_menu() {
    printf -- "----- BASH: how to use netcat, openssl, telnet ----:\n"
    printf -- "1) port scanning       - check if a host has a certain port open - netcat\n"
    printf -- "2) port 443 scanning   - openssl\n"
    printf -- "3) port 80 scanning    - telnet and webs scrapping\n"
    printf "=========================================================\n" 
}

print_menu

read -p "Select an option: " get_menu

if [[ "$get_menu" -eq 1 ]]; then
    read -p "Enter host(ex: google.com): " open_host
    read -p "Enter port: (ex: 80 or 443)" open_port
    nc -zv "$open_host" "$open_port"

elif [[ "$get_menu" -eq 2 ]]; then
    read -p "Enter server (ex: google.com): " get_server
    openssl s_client -connect $get_server:443    


#TODO: fix.... after calling telnet it enters an interactive mode. line 32 # web scrapping telnet port 80 openssl port 443
elif [[ "$get_menu" -eq 3 ]]; then
    read -p "Enter webpage to get source code: (ex: google.com): " get_html_webpage
    telnet "$get_html_webpage" 80 > html_output.txt
    GET / HTTP/1.1 # shouldnt be a command
    Host: "$get_html_webpage"

# get xml
    read -p "want to get xml?" get_xml_scrapping
    if [[ $get_xml_scrapping -eq "no" ]]; then
        print_menu
    else:   
        echo "[INFO] Getting xml format from the webpage..."
        telnet "$get_html_webpage" 80 > xml_output.txt
        GET /xml HTTP/1.1
        Host: $get_html_webpage

else:
    echo "goodbye...";
fi;

#TODO: add retry menu