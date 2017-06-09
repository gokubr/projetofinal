#!/bin/bash

#Projeto de gerenciamento de arquivos

#-----------------------------------------------------------------------------------
#-------------- INICIO DO CÓDIGO DE GERENCIAMENTO DE ARQUIVOS/DIRETÓRIOS -----------
#---------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------ SUB MENU ARQUIVOS / DIRETORIOS -------------------------

GARQ(){
OPCAO=$(dialog								\
		--stdout						\
		--title 'Gerenciamento de Arquivos e Diretórios'	\
		--menu	'Escolha uma opção:'				\
		0 0 0							\
		1 'Criar arquvivo'					\
		2 'Apagar arquivo' 					\
		3 'Renomear arquivo'					\
		4 'Mover arquivo'					\
		5 'Listar arquivos / diretórios'			\
		6 'Criar diretório' 					\
		7 'Apagar diretório'					\
		8 'Renomear diretório'				        \
		9 'Mover diretório'					\
		10 'Voltar')

case $OPCAO in
	1) CARQ ;;
	2) AARQ ;;
	3) RARQ ;;
	4) MARQ ;;
	5) LAED ;;
	6) CDIR ;;
	7) ADIR ;;
	8) RDIR ;;
	9) MDIR ;;
	10) MENU ;;
	*) MENU ;;
esac
}

#---------------------------------------------------------------------------------
#----------------------- CRIAR ARQUIVOS -------------------------------------------

CARQ(){

CRIA=$(dialog	--stdout --title 'Criar novo arquivo'				\
		--inputbox 'Digite o nome do arquivo: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local para salvar:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac


if [ -e "$LOCAL$CRIA" ]; then

               (dialog --title 'Atenção!'					\
		      --msgbox 'Esse arquivo já existe nesse diretório.'	\
		      0 0)
else

	> $LOCAL$CRIA
	      (dialog --title 'Parabéns!'					\
		      --msgbox 'Arquivo criado com sucesso.' 			\
		      0 0)
 
fi

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------------ APAGAR ARQUIVOS ----------------------------------

AARQ(){

APAGA=$(dialog	--stdout --title 'Apagar arquivo'				\
		--inputbox 'Digite o nome do arquivo: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local do arquivo:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

rm $LOCAL$APAGA 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Arquivo deletado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}


#----------------------------------------------------------------------------
#------------------------ RENOMEAR ARQUIVOS ---------------------------

RARQ(){

LOCAL=$(dialog	--stdout --title 'Selecione o local onde está o arquivo:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOME=$(dialog	--stdout --title 'Renomear arquivo'				\
		--inputbox 'Digite o nome do arquivo: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOVONOME=$(dialog --stdout --title 'Renomear arquivo'				\
		  --inputbox 'Digite o novo nome do arquivo: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

mv $NOME $NOVONOME 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Arquivo renomeado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------ MOVER ARQUIVOS----------------------------------------

MARQ(){
MOVER=$(dialog	--stdout --title 'Selecionar o arquivo'				\
		--inputbox 'Digite o nome do arquivo: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local para mover o arquivo:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

if [ -z $MOVER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	MARQ

else

mv $MOVER $LOCAL 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Arquivo movido com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GARQ
}


#-----------------------------------------------------------------------------------
#--------------------- LISTAR ARQUIVOS E DIRETÓRIOS --------------------------------

LAED(){

LIST=$(dialog	--stdout --title 'Selecione o local que deseja listar:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

ls -la $LIST > /tmp/lista
	       (dialog --textbox /tmp/lista 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

GARQ
}


#-----------------------------------------------------------------------------------
#--------------------- CRIAR DIRETORIOS--------------------------------------------

CDIR(){

CRIADIR=$(dialog --stdout --title 'Criar novo diretório'			\
		 --inputbox 'Digite o nome do diretório: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog --stdout --title 'Selecione o local para salvar:'		\
		 --fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac


mkdir $LOCAL$CRIADIR 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório criado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------------ APAGAR DIRETÓRIOS ----------------------------------

ADIR(){

APAGADIR=$(dialog --stdout --title 'Apagar diretório'				\
		  --inputbox 'Digite o nome do diretório:'	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local do diretório:'		\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

rmdir $LOCAL$APAGADIR 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório deletado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------ RENOMEAR DIRETÓRIOS ---------------------------

RDIR(){

LOCAL=$(dialog	--stdout --title 'Selecione o local onde está o diretório:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOME=$(dialog	--stdout --title 'Renomear diretório'				\
		--inputbox 'Digite o nome do diretório: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

NOVONOME=$(dialog --stdout --title 'Renomear diretório'				\
		  --inputbox 'Digite o novo nome do diretório: ' 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

mv $NOME $NOVONOME 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório renomeado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

GARQ
}

#-----------------------------------------------------------------------------------
#------------------------ MOVER DIRETÓRIOS ----------------------------------------

MDIR(){

MOVER=$(dialog	--stdout --title 'Selecionar o diretório'			\
		--inputbox 'Digite o nome do diretório: '	0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

LOCAL=$(dialog	--stdout --title 'Selecione o local para mover o diretório:'	\
		--fselect /home/ 0 0)

case $? in 1) GARQ ;; 255) GARQ ;; esac

if [ -z $MOVER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	MARQ

else

mv $MOVER $LOCAL 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Diretório movido com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GARQ
}

#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
#-------------- FIM DO CÓDIGO DE GERENCIAMENTO DE ARQUIVOS/DIRETÓRIOS ---------------
#-----------------------------------------------------------------------------------
