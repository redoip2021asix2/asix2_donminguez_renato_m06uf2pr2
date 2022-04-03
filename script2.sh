#!/bin/bash
clear

if [ "$(id -u)" != "0" ]; then
	echo "Ejecuta este script como root (o usando sudo)."
	exit 1
fi

if [[ -e usuaris.ods ]]
then
	rm usuaris.ods
fi


echo "Descarreguem el fitxer usuaris.ods:"
wget http://www.collados.org/asix2/m06/uf2/usuaris.ods > /dev/null 2>&1

if [[ -e usuaris.ods ]]
then
	echo "S'ha descarregat el fitxer"
else
	echo "ERROR: file not downloaded"
	exit 2
fi

echo "Convertim el fitxer usuaris.ods a usuaris.csv ."
libreoffice --convert-to csv --outdir . usuaris.ods  > /dev/null 2>&1

if [[ -e usuaris.csv ]]
then
	echo "FILE CONVERTED TO CSV"
else
	echo "ERROR: file not converted"
	echo "Exit..."
	exit 2
fi

uid=$((3001))
echo "***************"
while read line
do
	#cut -d ',' -f 2 $line
	#$line | cut -d ',' -f2
	username=$(echo $line | cut -d ',' -f2)

	echo $username
	echo $uid
	useradd  $username  -u  $uid  -g  users  -d  /home/$username  -m  -s  /bin/bash  -p  $(mkpasswd  fjeclot) > /dev/null 2>&1
	if id "$username" &>/dev/null; then
		echo 'USER CREATED'
		echo "***************"
	else
		echo 'USER NOT CREATED'
		echo "***************"
		exit 3
	fi
	((uid=uid+1)) 
done < usuaris.csv
	 
echo -n "S'ha finalitzat el script"
exit 0
