******************************************************************************************************************************************
* MICROECONOMIA EMPÍRICA - 2019
* TRABALHO FINAL
* ALUNO: JOSÉ EDUARDO SOUSA
******************************************************************************************************************************************

*******************************************************************************************************************************************
*								PREPARAÇÃO DA POF 2002 PARA A ESTIMAÇÃO QUAIDS
*******************************************************************************************************************************************

clear all
set more off

cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Bases Manipuladas"
dir

use POF_2002_manipulada.dta, clear

* Mantendo na base de dados somente os domicílios que possuem um único morador, pois queremos apenas solteiros e solteiras.
keep if n_moradores == 1

* Realizando um merge com a base de índices de preços de 2002:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Indices de Preços"
merge m:1 cod_uf using precos_2002.dta

* Mantendo na base de dados somente domicílios (ou pessoas, coincide neste caso) de cidades as quais possuímos índices de preços:
keep if _merge == 3
drop _merge
order ano cidade

* Salvando a base que agora está pronta para a estimação QUAIDS:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Bases Manipuladas"
save base_2002_pronta.dta, replace




