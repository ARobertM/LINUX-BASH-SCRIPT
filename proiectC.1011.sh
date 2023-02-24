  
#!/bin/bash
clear

chmod +x proiectC.1011.sh 

#cod culori folosite in proiect

ROSU="31"
ALBASTRU="94"
GALBEN="93"
BOLDGALBEN="\e[1;${GALBEN}m"
BOLDROSU="\e[1;${ROSU}m"
ENDCOLOR="\e[0m"
ITALICALBASTRU="\e[3;${ALBASTRU}m"

echo -e "\t\t${BOLDROSU}!!!ATENTIE!!!${ENDCOLOR}"
sleep 2
echo "PENTRU A RULA ACEST SCRIPT TREBUIE SA VA INSTALATII FIGLET"
echo "Un mic program ce ajuta la un design mai placut al proiectului"
sleep 2
clear



if ! command -v figlet > /dev/null; then

#instalare figlet(mic program pentru a realiza un text mai mare)
sudo apt-get update -y
sudo apt-get install -y figlet
clear
fi
#afisarea reprezentantilor proiectului -c \t (tab)

figlet -c  PROIECT - C 

echo -e "${BOLDGALBEN}\t\t\t\tREALIZAT DE:${ENDCOLOR}"
sleep 0.5
echo -e "${ITALICALBASTRU}\t\t\t1.Alexandru Robert-Mihai"
sleep 0.5
echo -e "\t\t\t2.Badina Bogdan-Stefan"
sleep 0.5
echo -e "\t\t\t3.Andries Victor-Mihai${ENDCOLOR}"
sleep 0.5

echo -e "${BOLDGALBEN}\t\t\t\tGRUPA 1011${ENDCOLOR}"


#meniul proiectului in executie
meniu() {
figlet -c START MENU
sleep 0.5

echo -e "\t${BOLDGALBEN}\tProiectul contine urmatoarele operatiuni:${ENDCOLOR}"

echo -ne "
${BOLDROSU}1) Descarcarea unui fisier online dintr-un link cerut de la tastatura
2) Dezarhivarea unei arhive 'tar' sau 'tar.gz'
3) Crearea unei arhive 'tar' sau 'tar.gz'
4) Copiarea listei de utilizatori din /etc/passwd intr-un fisier csv
q) Exit

Alegeti optinea dorita:${ENDCOLOR}"

read -r ras  
	case $ras in
1)      sub1
	meniu
	;;
2)      sub2
	meniu
	;;
3)	sub3
	meniu
	;;
4)      sub4
	meniu	
	;;
q)
	exit 1
	;;
*)
	echo -e "\t\t${BOLDROSU} Nu ati selectat nici o varianta de mai sus! ${ENDCOLOR}"
	clear
	;;
	esac
}


#Subiectul 1

sub1(){
conexiune() {
clear
if ping -q -c 1 -W 1 google.ro >/dev/null; then
        echo "Avem conexiune la internet!"
else
        echo "Nu avem conexiune la internet"
        meniu
fi
}
conexiune

#descarcare fisier online dintr-un link cerut de la tastatura

descarcare() {
echo -ne "\t\t${BOLDGALBEN} Introduceti calea dumneavoastra de descarcare:(/home/*) ${ENDCOLOR}" $caledescarcare
read caledescarcare

if [ -d $caledescarcare  ];then
        cd $caledescarcare
        echo -ne "\t\t${BOLDGALBEN} Introduceti link-ul de descarcare: ${ENDCOLOR}"$link
        read link
        wget $link
else
        echo -ne "\t\t${BOLDROSU} Nu exista calea ,doriti sa creati alta? [y/n] : ${ENDCOLOR} "
        read ras
        case $ras in
y)
        echo -ne "\t\t${BOLDGALBEN} Introduceti numele directorului: ${ENDCOLOR}"
        read caledescarcarenoua
        mkdir $caledescarcarenoua
        cd $caledescarcarenoua
        echo "\t\t${BOLDGALBEN}Introduceti link-ul de descarcare: ${ENDCOLOR}"
        read link
        wget $link 
        ;;

n)	meniu
        ;;
*)
        echo "\t\t${BOLDROSU} Nu ati selectat nici o varianta de mai sus! ${ENDCOLOR}"

        esac
fi
}
descarcare
}


#Subiectul 2

sub2(){
echo -ne "\t\t${BOLDROSU} Introduceti numele arhivei dorite: ${ENDCOLOR} "$arhivaceruta
read arhivaceruta


if [ -f $arhivaceruta ];then

        echo -ne "\t\t${BOLDGALBEN} Introduceti locatia dezarhivarii:(/home/*) ${ENDCOLOR} "$locatie
        read locatie

        if [ -f *.tar.gz ];then
                for f in *.tar.gz
                        do
                tar zxvf "$f" -C $locatie
                        done
                else

                for f in *.tar
                        do
                tar xvf "$f" -C $locatie
                        done
        fi
	clear

        if [ ! -d "$locatie" ];then
                echo "\t\t ${BOLDROSU} Nu exista locatia dorita! ${ENDCOLOR}"
                echo -ne "\t\t ${BOLDGALBEN} Introduceti noua locatie: ${ENDCOLOR}"$locatienoua
                read locatienoua
                mkdir $locatienoua

                if [ -f *.tar.gz ];then
                        for f in *.tar.gz
                                do
                        tar zxvf "$f" -C $locatienoua
                                done
                else
                        for f in *.tar
                                do
                        tar xvf "$f" -C $locatienoua
                                done
                fi
        fi
	clear
else
        echo "\t\t${BOLDGALBEN} Nu exita arhiva cautata! ${ENDCOLOR}"
	sleep 2
	clear
        meniu

fi
}

#Subiectul 3

sub3(){
        clear
        echo "Introduceti numele arhivei dorite:"
        read arhivafolder

if [ ! -d $arhivafolder ];then
        mkdir $arhivafolder

        echo "Cate fisiere doriti sa arhivati:"
        read nrfisier

        i=0
        while [ "$i" -lt $nrfisier ]
        do
                echo "Introduceti calea fisierului:"
                read adresafisier

        mv "$adresafisier" "$arhivafolder"
        i=$(($i+1))
        done

        echo "Alegi tipul de arhiva pe care o doriti:
         1)Tar 
         2)Tar.gz"
        read ras
        case $ras in
        1) tar -cvf $arhivafolder.tar $arhivafolder
                ;;
        2) tar -cvzf $arhivafolder.tar.gz $arhivafolder
                ;;
        *) echo "Nu exista acest tip de optiune!"
           meniu
                ;;
           esac
	   clear
else

        echo "Arhiva exista deja!"
        meniu
	clear

fi
}

#Subiectul 4

sub4(){
clear
cut -d: -f1,3,6,7 /etc/passwd | tr ':' '\t' > tabelSUB4.csv
echo "Operatia s-a indeplinit cu succes!"
sleep 2
meniu
}

while true
do
	meniu
done
