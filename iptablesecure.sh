#!/bin/bash

# Variables
export IF_RESEAU="wlan0"


# On efface toutes les regles existantes # On supprime d'eventuelles regles personnelles
/sbin/iptables -F
/sbin/iptables -X 
# Mise en place des regles par defaut (on refuse tout par default)
/sbin/iptables -P INPUT DROP
/sbin/iptables -P FORWARD DROP
/sbin/iptables -P OUTPUT DROP
# On accepte les connexions sur la boucle locale (sur lo == 127.0.0.1)
/sbin/iptables -A INPUT  -i lo -j ACCEPT
/sbin/iptables -A OUTPUT -o lo -j ACCEPT
# On accept le DNS + HTTP + HTTPS en sortie
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 53    -j ACCEPT #dns
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 80  -j ACCEPT #web - apacge

/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 443 -j ACCEPT #https
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 9050 -j ACCEPT #tor
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 9051 -j ACCEPT #tor browser
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 8118 -j ACCEPT #privoxy
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 21 -j ACCEPT #ftp
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 3128 -j ACCEPT #squif
#Messagerie 

/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 143 -j ACCEPT #sql
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 143 -j ACCEPT #sql
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 993 -j ACCEPT #imap ssl
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 993 -j ACCEPT #imap ssl
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 465 -j ACCEPT #ssmtp
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 465 -j ACCEPT #ssmtp
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 25 -j ACCEPT #smtp
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 25 -j ACCEPT #smtp
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 110 -j ACCEPT #pop3
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 110 -j ACCEPT #pop3
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 995 -j ACCEPT #spop3
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 995 -j ACCEPT #spop3
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 143 -j ACCEPT #imap2
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 143 -j ACCEPT #imap2
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 220 -j ACCEPT #imap3
/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 220 -j ACCEPT #imap3

#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 3001 -j ACCEPT
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 7337 -j ACCEPT
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 3790 -j ACCEPT
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 8834 -j ACCEPT
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 51413 -j ACCEPT
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 445 -j ACCEPT # MS
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 4444  -j ACCEPT
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p udp --dport 51413 -j ACCEPT
#/sbin/iptables -A OUTPUT -o $IF_RESEAU -p tcp --dport 8245 -j ACCEPT
#/sbin/iptables -A OUTPUT -p udp --sport 51413 -j ACCEPT
#/sbin/iptables -A INPUT -i $IF_RESEAU -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 5298 -j ACCEPT

#Synergy
/sbin/iptables -A INPUT  -i $IF_RESEAU -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 24800 -j ACCEPT
/sbin/iptables -A OUTPUT -o $IF_RESEAU -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 24800 -j ACCEPT

#/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p udp --dport 5900 -j ACCEPT
#/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 5900 -j ACCEPT
#VOIP
/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p udp --dport 5060 -j ACCEPT #sip
/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 5060 -j ACCEPT #sip
/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p udp --dport 5064 -j ACCEPT #proxy-sio
/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 5064 -j ACCEPT #proxy-sip

#/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p udp --dport 6881 -j ACCEPT
#/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 6881 -j ACCEPT
#/sbin/iptables -A INPUT  -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p udp --dport 6881 -j ACCEPT
#/sbin/iptables -A INPUT  -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 6881 -j ACCEPT

#/sbin/iptables -A OUTPUT -o wlan0 -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 8008 -j ACCEPT
#/sbin/iptables -A INTPUT -i wlan0 -m state --state NEW,RELATED,ESTABLISHED -p tcp --dport 8008 -j ACCEPT




##configuration server tor
/sbin/iptables -t filter -A INPUT  -p tcp --source-port 1024: --destination-port 9001  -m state --state NEW,ESTABLISHED -j ACCEPT
/sbin/iptables -t filter -A OUTPUT -p tcp --destination-port 1024: --source-port 9001  -m state --state ESTABLISHED -j ACCEPT
/sbin/iptables -I INPUT -j ACCEPT -i lo -p tcp --dport 8118:9050 --sport 1:65000
/sbin/iptables -A OUTPUT -j ACCEPT -o lo -p tcp --dport 1:65000 --sport 8118:9050

# On autorise les connexions deja etablies ou relatives a une autre connexion a sortir
/sbin/iptables -A OUTPUT -o $IF_RESEAU --match state --state ESTABLISHED,RELATED -j ACCEPT

# On autorise les connexions deja etablies a entrer
/sbin/iptables -A INPUT -i $IF_RESEAU --match state --state ESTABLISHED,RELATED -j ACCEPT

# On sauvegarde la configuration de iptables
/sbin/iptables-save

# On redemarre le service iptable pour prendre en compte la nouvelle configuration
service iptables restart

# Chargement du module de gestion des connexion state 
# (autorisation des connexions deja etablies a passer le firewall)
# Sur distrib ovh, pas possible car noyau monolitique
/sbin/modprobe ip_conntrack

