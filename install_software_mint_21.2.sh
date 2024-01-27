#!/bin/bash

install_snap_packages () {
  _install_snap_PACKAGES="code--classic"
  install_snap

  _install_snap_PACKAGES="webstorm --classic"
  install_snap
}

development_install () {
  echo
  echo -n "# Procedo con l'installazione (lamp, phpmyadmin, node, composer, filezilla)? "
  read sure
  if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
          #install lamp
          sudo apt install -y lamp-server^
          sudo apt install -y phpmyadmin

          #install node
          sudo apt install -y nodejs
          sudo apt install -y npm
          sudo npm install -g n
          sudo n stable
          nodejs -v

          #composer
          sudo apt install -y composer

          #filezilla
          sudo apt install -y filezilla

      echo "* Installazione terminata."
    else
      echo "* Installazione non eseguita."
  fi
}

git_install (){
  echo
  echo -n "# Procedo con l'installazione di git? "
  read sure
  if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
          #install git
          sudo apt install -y git
          echo -n "# Inserisci nome utente git"
          read gituser
          git config --global user.name "${gituser}"
          echo -n "# Inserisci email git"
          read gitemail
          git config --global user.email ${gitemail}
          git config --list
      echo "* Installazione terminata."
    else
      echo "* Installazione non eseguita."
  fi
}

_generic_install_PACKAGES=""
generic_install () {
  echo
  echo -n "# Procedo con l'installazione di ${_generic_install_PACKAGES}? "
  read sure
  if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
          sudo apt install -y ${_generic_install_PACKAGES}
      echo "* Installazione ${_generic_install_PACKAGES} terminata."
    else
      echo "* Installazione ${_generic_install_PACKAGES} non eseguita."
  fi
}


_install_snap_PACKAGES=""
install_snap () {

  echo
  REQUIRED_PKG="snapd"
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' ${REQUIRED_PKG}|grep "install ok installed")
  echo "... controllo installazione ${REQUIRED_PKG}: ${PKG_OK}"
  if [ "" = "${PKG_OK}" ]; then
    echo "${REQUIRED_PKG} non installato. Installazione in corso."
    sudo rm /etc/apt/preferences.d/nosnap.pref
    sudo apt-get --yes install $REQUIRED_PKG
  fi

  echo
  echo -n "# Procedo con l'installazione di ${_install_snap_PACKAGES}? "
  read sure
  if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
          sudo apt install -y ${_install_snap_PACKAGES}
      echo "* Installazione ${_install_snap_PACKAGES} terminata."
    else
      echo "* Installazione ${_install_snap_PACKAGES} non eseguita."
  fi
}

copy_config (){
  echo
  echo -n "# Inserisci nome home vecchio utente: "
  read olduser
  echo "Vecchio utente '${olduser}'"
  echo
  echo -n "# Inserisci nome home nuovo utente: "
  read newuser
  echo "Nuovo utente '${newuser}'"
  echo
  echo "# Procedo con la copia dei files di configurazione da /home/${olduser} a /home/${newuser}? (s|N):"
  read sure
  if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
      if [ -d /home/${olduser} ] && [ -d /home/${newuser} ]; then # controllo se esistono le directory

        echo "Copio /home/${olduser}/.ssh"
        cp -r "/home/${olduser}/.ssh" "/home/${newuser}"

        echo "Copio /home/${olduser}/.config/GIMP"
        cp -r "/home/${olduser}/.config/GIMP" "/home/${newuser}/.config"

        echo "Copio /home/${olduser}/.config/inkscape"
        cp -r "/home/${olduser}/.config/inkscape" "/home/${newuser}/.config"

        echo "Copio /home/${olduser}/.audacity-data"
        cp -r "/home/${olduser}/.audacity-data" "/home/${newuser}"

        echo "Copio /home/${olduser}/.config/filezilla"
        cp -r "/home/${olduser}/.config/filezilla" "/home/${newuser}/.config"

        echo "Copio /home/${olduser}/.mongodb"
        cp -r "/home/${olduser}/.mongodb" "/home/${newuser}"

        echo "Copio /home/${olduser}/.docker"
        cp -r "/home/${olduser}/.docker" "/home/${newuser}"

        echo "Copio /home/${olduser}/.vscode"
        cp -r "/home/${olduser}/.vscode" "/home/${newuser}"

        echo "# Procedo con la copia di /home/${olduser}/.thunderbird (potrebbe essere di grandi dimensioni)? (s|N):"
        read sure
        if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
          echo "Copio /home/${olduser}/.thunderbird"
          cp -r "/home/${olduser}/.thunderbird" "/home/${newuser}"
        fi

      else
        echo "* Una delle due cartelle specificate non esiste."
        copy_config
      fi
    else
      echo "* Copia configurazioni non eseguita."
  fi
}
#######################
## Programma principale
#TITOLOAPP="Titolo"
#DESCRIZIONEAPP="Descrizione :"
#
#ARRAYOPZIONI=(
#"AGGIORNAMENTO"
#"INSTALLAZIONE_PACCHETTI_SNAP"
#"INSTALLAZIONE_AMBIENTI_DI_SVILUPPO"
#"GOOGLE_CHROME"
#"AUDIO"
#"GRAFICA"
#)
#ARRAYOPZIONI=( ${ARRAYOPZIONI[@]/#/"FALSE "} )
#
#
#while true; do
#  OPZIONE="$(zenity --width 309 --height 240 --title="$TITOLOAPP" --text="$DESCRIZIONEAPP" --list --radiolist  --column "a" --column="Valore" "${ARRAYOPZIONI[@]}")"
#
#      if   [ "$OPZIONE" = "AGGIORNAMENTO" ]; then
#          zenity --info --text="Selezionata opzione $OPZIONE"
#          zenity --info --text=$(sudo apt-get update | sudo apt-get upgrade) --title="AGGIORNAMENTO"
#
#      elif [ "$OPZIONE" = "1.7.0" ]; then
#          zenity --info --text="Selezionata opzione $OPZIONE"
#      elif [ "$OPZIONE" = "1.7.1" ]; then
#          zenity --info --text="Selezionata opzione $OPZIONE"
#      elif [ "$OPZIONE" = "1.7.2" ]; then
#          zenity --info --text="Selezionata opzione $OPZIONE"
#      elif [ "$OPZIONE" = "1.7.3" ]; then
#          zenity --info --text="Selezionata opzione $OPZIONE"
#      elif [ "$OPZIONE" = "Esci" ]; then
#         exit 1
#         else
#          zenity --info --text="$Opcion, non valido"
#         fi
#done
echo "+============================================================================+"
echo "|               INSTALLAZIONE SOFTWARE LINUX MINT                            |"
echo "+============================================================================+"
echo
### UPDATE
echo -n "~~~ Eseguire l'aggiornamento dei pacchetti? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
		sudo apt-get update
		sudo apt-get upgrade
	else
    echo "*** Aggiornamento ...[NON ESEGUITO]"
fi

### SNAP
echo -n "~~~ Eseguire l'installazione dei pacchetti snap? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
    install_snap_packages
	else
    echo "*** Installazione pacchetti snap ...[NON ESEGUITA]"
fi

### AMBIENTI DI SVILUPPO
echo
PACKAGES="ambienti di sviluppo"
echo -n "~~~ Eseguire l'installazione di ${PACKAGES} ? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
		development_install
        git_install
	else
    echo "*** Installazione ${PACKAGES} ...[NON ESEGUITA]"
fi

## TOOLS GENERICI
echo
TITLE="tools generici"
_generic_install_PACKAGES="gparted keepassx"
echo -n "~~~ Eseguire l'installazione di ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
		generic_install
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

## TOOLS AUDIO
echo
TITLE="tools audio"
_generic_install_PACKAGES="audacity"
echo -n "~~~ Eseguire l'installazione dei ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
		generic_install
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

### TOOLS GRAFICI
echo
TITLE="tools grafici"
_generic_install_PACKAGES="gimp inkscape"
echo -n "~~~ Eseguire l'installazione di ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
		generic_install
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

### ALTRE APP
echo
TITLE="Google Chrome"
echo -n "~~~ Eseguire l'installazione di ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" || $sure = "" ]]; then
  sudo apt-install -y wget
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo rm google-chrome-stable_current_amd64.deb
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

## COPIA CONFIGURAZIONI E SSH
echo
echo -n "~~~ Eseguire la copia dei files di configurazione e chiavi ssh dal vecchio al nuovo utente? (s/N):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
		copy_config
	else
    echo "*** Copia ...[NON ESEGUITA]"
fi

echo "+============================================================================+"
echo "|                         Installazione terminata                            |"
echo "+============================================================================+"

