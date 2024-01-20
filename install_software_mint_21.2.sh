#!/bin/bash

snap_install () {
  PACKAGES="snapd"
  echo
  echo -n "# Procedo con l'installazione di ${PACKAGES}? "
  read sure
  if [[ $sure = "s" ]]
    then
          #install snap
          sudo rm /etc/apt/preferences.d/nosnap.pref # rimuovo blocco
          sudo apt install ${PACKAGES}
      echo "* Installazione ${PACKAGES} terminata."
    else
      echo "* Installazione ${PACKAGES} non eseguita."
  fi
}

vscode_install () {
  TITLE="vscode"
  echo
  echo -n "# Procedo con l'installazione di ${TITLE}? "
  read sure
  if [[ $sure = "s" ]]
    then
          sudo snap install --classic code
      echo "* Installazione ${TITLE} terminata."
    else
      echo "* Installazione ${TITLE} non eseguita."
  fi
}

webstorm_install () {
  TITLE="vscode"
  echo
  echo -n "# Procedo con l'installazione di ${TITLE}? "
  read sure
  if [[ $sure = "s" ]]
    then
          sudo snap install webstorm --classic
      echo "* Installazione ${TITLE} terminata."
    else
      echo "* Installazione ${TITLE} non eseguita."
  fi
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

######################
# Programma principale
echo "+============================================================================+"
echo "|               INSTALLAZIONE SOFTWARE LINUX MINT                            |"
echo "+============================================================================+"
echo
echo -n "~~~ Eseguire l'installazione dei pacchetti snap? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
		snap_install
        vscode_install
        webstorm_install
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
TITLE="tools audio"
echo -n "~~~ Eseguire l'installazione dei ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
        _generic_install_PACKAGES="audacity"
		generic_install
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

echo
TITLE="tools grafici"
echo -n "~~~ Eseguire l'installazione di ${TITLE}? (s/n):"
read sure
if [[ ${sure} = "s" || ${sure} = "y" ]]; then
        _generic_install_PACKAGES=""
		#generic_install
	else
    echo "*** Installazione ${TITLE} ...[NON ESEGUITA]"
fi

echo "+============================================================================+"
echo "|                         Installazione terminata                            |"
echo "+============================================================================+"