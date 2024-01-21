#!/bin/bash

install_snap_packages () {
  _install_snap_PACKAGES="code--classic"
  install_snap

  _install_snap_PACKAGES="webstorm --classic"
  install_snap
}

development_install () {
  echo
  echo -n "# Procedo con l'installazione (lamp, phpmyadmin, node, composer)? "
  read sure
  if [[ $sure = "s" ]]
    then
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

      echo "* Installazione terminata."
    else
      echo "* Installazione non eseguita."
  fi
}

git_install (){
  echo
  echo -n "# Procedo con l'installazione di git? "
  read sure
  if [[ $sure = "s" ]]
    then
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
  if [[ $sure = "s" ]]
    then
          sudo apt install ${_generic_install_PACKAGES}
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
    sudo apt-get --yes install $REQUIRED_PKG
  fi

  echo
  echo -n "# Procedo con l'installazione di ${_install_snap_PACKAGES}? "
  read sure
  if [[ $sure = "s" ]]
    then
          sudo apt install -y ${_install_snap_PACKAGES}
      echo "* Installazione ${_install_snap_PACKAGES} terminata."
    else
      echo "* Installazione ${_install_snap_PACKAGES} non eseguita."
  fi
}

######################
# Programma principale
echo "+============================================================================+"
echo "|               INSTALLAZIONE SOFTWARE LINUX MINT                            |"
echo "+============================================================================+"
echo
echo -n "~~~ Eseguire l'aggiornamento dei pacchetti? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
		sudo apt-get update
		sudo apt-get upgrade
	else
    echo "*** Aggiornamento ...[NON ESEGUITO]"
fi

echo -n "~~~ Eseguire l'installazione dei pacchetti snap? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
    install_snap_packages
	else
    echo "*** Installazione pacchetti snap ...[NON ESEGUITA]"
fi

echo
PACKAGES="ambienti di sviluppo"
echo -n "~~~ Eseguire l'installazione di ${PACKAGES} ? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
		development_install
        git_install
	else
    echo "*** Installazione ${PACKAGES} ...[NON ESEGUITA]"
fi

echo
TITLE="Google Chrome"
echo -n "~~~ Eseguire l'installazione di ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
  sudo apt-install -y wget
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

echo
TITLE="tools audio"
_generic_install_PACKAGES="audacity lmms"
echo -n "~~~ Eseguire l'installazione dei ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
		generic_install
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

echo
TITLE="tools grafici"
_generic_install_PACKAGES="gimp inkscape"
echo -n "~~~ Eseguire l'installazione di ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
		generic_install
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

echo "+============================================================================+"
echo "|                         Installazione terminata                            |"
echo "+============================================================================+"

