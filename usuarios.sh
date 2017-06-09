#!/bin/bash

#Projeto de gerenciamento de usuários

#-----------------------------------------------------------------------------------
#----------------- INICIO DO CÓDIGO DE GERENCIAMENTO DE USUÁRIOS/GRUPOS -------------
#----------------------------------------------------------------------------------
#----------------------------------------------------------------------------------
#------------------- SUB MENU USUÁRIO-----------------------------------------------

GUSR() {
USER=$(dialog							\
	--stdout						\
        --title 'Gerenciamento de Usuários e Grupos'            \
        --menu 'Escolha uma opção:' 0 0 0			\
	1 'Criar usuário'					\
	2 'Deletar usuário'					\
	3 'Alterar a senha do usuário'                          \
	4 'Listar usuários do sistema'				\
	5 'Criar grupo'						\
	6 'Deletar grupo'					\
	7 'Listar grupos do sistema'				\
	8 'Adicionar usuário a um grupo'			\
	9 'Remover usuário de um grupo'				\
	10 'Voltar')						\
	
case $USER in
	1) CUSR ;;
	2) DUSR ;;
	3) PUSR ;;
	4) LUSR ;;
	5) CGRU ;;
	6) DGRU ;;
	7) LGRU ;;
	8) AGRU ;;
	9) RGRU ;;
	10) MENU ;;
	*) dialog ; MENU ;;
esac
} 

#-----------------------------------------------------------------------------------
#----------------------------- CRIAR USUÁRIO-----------------------------------------

CUSR(){

NUSER=$(dialog  						\
		--stdout --title 'Criar novo usuário'		\
		--inputbox 'Digite o nome do usuário:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $NUSER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	CUSR

else

useradd $NUSER 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Usuário criado com sucesso.' 		\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GUSR

}

#-----------------------------------------------------------------------------------
#------------------DELETAR USUÁRIO-----------------------------------------

DUSR(){
DUSER=$(dialog  						\
		--stdout --title 'Deletar usuário'		\
		--inputbox 'Digite o nome do usuário:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $DUSER ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	CUSR

else

userdel $DUSER 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Usuário deletado com sucesso.' 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
fi

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ALTERAR A SENHA DO USUÁRIO-----------------------------------------

PUSR(){
USR=$(dialog  						        \
		--stdout --title 'Alterar a senha do usuário'	\
		--inputbox 'Digite o nome do usuário:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

PASS=$(dialog							\
               	--stdout --title 'Alterar a senha do usuário'	\
		--passwordbox 'Digite a senha:'		        \
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

PASS2=$(dialog							\
               	--stdout --title 'Alterar a senha do usuário'	\
		--passwordbox 'Digite a senha novamente:'	\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac
         
if [ -z $PASS ] || [ -z $PASS2 ] || [ -z $USR ]; then
    
	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	PUSR
   
else

(echo $PASS ; echo $PASS2) | passwd $USR 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog							\
		--title 'Parabéns!' 					\
		--msgbox 'Senha alterada com sucesso.'  	 	\
		0 0 || dialog --title 'Atenção'				\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
    
fi 

GUSR
}

#-----------------------------------------------------------------------------------
#------------------LISTAR USUÁRIOS DO SISTEMA-----------------------------------------

LUSR(){
        tail -f /etc/passwd > out &
	dialog							\
		--title 'Listando todos os usuários'		\
		--tailbox out					\
		0 0
GUSR
}

#-----------------------------------------------------------------------------------
#------------------ CRIAR GRUPO-----------------------------------------

CGRU(){

NGRUP=$(dialog  						\
		--stdout --title 'Criar novo grupo'		\
		--inputbox 'Digite o nome do grupo:'		\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $NGRUP ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	CGRU

else

groupadd $NGRUP 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Grupo criado com sucesso.' 		\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt

fi

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ DELETAR GRUPO-----------------------------------------

DGRU(){

DGRUP=$(dialog  						\
		--stdout --title 'Deletar grupo'		\
		--inputbox 'Digite o nome do grupo:'		\
		0 0)
case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $DGRUP ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	DGRU

else

groupdel $DGRUP 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog						\
		--title 'Parabéns!' 				\
		--msgbox 'Grupo deletado com sucesso.' 	 	\
		 0 0 || dialog --title 'Atenção'		\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
fi

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ LISTAR GRUPOS DO SISTEMA-----------------------------------------

LGRU(){
        tail -f /etc/group > out &
	dialog							\
		--title 'Listando todos os grupos'		\
		--tailbox out					\
		0 0
GUSR
}

#-----------------------------------------------------------------------------------
#------------------ ADICIONAR USUÁRIO A UM GRUPO---------------------------------------

AGRU(){    
USR=$(dialog							        \
		--stdout						\
		--title 'Adicionar usuário'				\
		--inputbox 'Digite o nome do usuário:'		        \
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

GRU=$(dialog								\
		--stdout						\
		--title 'Selecionar grupo'				\
		--inputbox 'Digite o nome do grupo:'			\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $USR ] || [ -z $GRU ]; then
    
	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	AGRU
   
else

gpasswd -a $USR $GRU 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog							\
		--title 'Parabéns!' 					\
		--msgbox 'Usuário adicionado com sucesso.'  	 	\
		0 0 || dialog --title 'Atenção'				\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
    
fi 

GUSR
}

#-----------------------------------------------------------------------------------
#------------------ REMOVER USUÁRIO DE UM GRUPO---------------------------------------

RGRU(){
USR=$(dialog							        \
		--stdout						\
		--title 'Remover usuário'				\
		--inputbox 'Digite o nome do usuário:'		        \
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

GRU=$(dialog								\
		--stdout						\
		--title 'Selecionar grupo'				\
		--inputbox 'Digite o nome do grupo:'			\
		0 0)

case $? in 1) GUSR ;; 255) GUSR ;; esac

if [ -z $USR ] || [ -z $GRU ]; then

	(dialog  							\
		--stdout --title 'Atenção'				\
		--msgbox 'Informação inválida. Tente novamente.'	\
		0 0)
	RGRU

else

gpasswd -d $USR $GRU 2> /tmp/erro.txt
erro=$(cat /tmp/erro.txt)
[ -z $erro ] && dialog							\
		--title 'Parabéns!' 					\
		--msgbox 'Usuário removido com sucesso.'   	 	\
		   0 0 || dialog --title 'Atenção'			\
				 --msgbox "$erro" 0 0; rm /tmp/erro.txt
  
fi

GUSR
}

#-----------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
#----------------- FIM DO CÓDIGO DE GERENCIAMENTO DE USUÁRIOS ------------------
#---------------------------------------------------------------------------------
