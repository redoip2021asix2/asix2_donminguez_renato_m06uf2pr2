#!/bin/bash
#RenatoD
clear

while [[ true ]]
do
	echo "Numero d'usuaris totals (entre 1 i 100) "
	read Tusuarios
	id ((Tusuarios >=1 && Tusuarios <= 100))
	then
		while [[ true ]]
		do
			echo "Valot uid per usuaris (minim 5000) "
			read uidNumber
			if ((uidNumber >= 5000))
			then 
			
				for (( contador=0; contador<Tusuarios; contador++ ))
				 do
						 userdel -r usr$uidNumber
						 ((uidNumber++))
				 done
				 
			break;
			fi
		
		done
	break;
	fi
done
exit 0#!/bin/bash
