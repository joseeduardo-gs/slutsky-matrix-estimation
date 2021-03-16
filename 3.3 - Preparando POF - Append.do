******************************************************************************************************************************************
* MICROECONOMIA EMPÍRICA - 2019
* TRABALHO FINAL
* ALUNO: JOSÉ EDUARDO SOUSA
******************************************************************************************************************************************

*******************************************************************************************************************************************
*							PREPARAÇÃO DA POF PARA A ESTIMAÇÃO QUAIDS - APPEND ENTRE BASES 2002 E 2008
*******************************************************************************************************************************************

clear

* Iremos empilhar (append)as duas bases de deados, 2002 e 2008, para obtermos a base de dados final pronta para se aplicar a estimação do modelo QUAIDS:

* Abrindo a base de dados para o ano de 2002:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Bases Manipuladas"
use base_2002_pronta.dta, clear

* Realizando o empilhamento (append):
append using base_2008_pronta.dta

* Gerando dummies para cada ano, que serão úteis para a estimação:
gen ano_2002 = ( ano == 2002 )
gen ano_2008 = ( ano == 2008 )

* Retirando missing values nas dummies de casa própria:
replace casa_propria_2002 = 0 if casa_propria_2002 == .
replace casa_propria_2008 = 0 if casa_propria_2008 == .

* Criando as Dummies de cidade:

* Gerando dummies para cada cidade:
gen belo_horizonte = ( cidade == "Belo Horizonte" )
gen belem = ( cidade == "Belém" )
gen curitiba = ( cidade == "Curitiba" )
gen fortaleza = ( cidade == "Fortaleza" )
gen porto_alegre = ( cidade == "Porto Alegre" )
gen recife = ( cidade == "Recife" )
gen rio_de_janeiro = ( cidade == "Rio de Janeiro" )
gen salvador = ( cidade == "Salvador" )
gen sao_paulo = ( cidade == "São Paulo" )

label var ano_2002 "Dummie de ano"
label var ano_2008 "Dummie de ano"

* Mantendo somente observações em areas urbanas:
// keep if urbano == 1

foreach var in belo_horizonte belem curitiba fortaleza porto_alegre recife rio_de_janeiro salvador sao_paulo {

label var `var' "Dummie de cidade"

} 

* Salvando esta base final que está pronta para a estimação QUAIDS:
save base_pronta.dta, replace
