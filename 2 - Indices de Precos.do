******************************************************************************************************************************************
* MICROECONOMIA EMPÍRICA - 2019
* TRABALHO FINAL
* ALUNO: JOSÉ EDUARDO SOUSA
******************************************************************************************************************************************

*******************************************************************************************************************************************
*					EXTRAÇÃO DAS PLANILHAS DE ÍNDICES DE PREÇOS DE 2002 E 2008 GERADAS NO EXCEL E CONVERSÃO PARA FORMATO .DTA
*******************************************************************************************************************************************

* Definindo diretório:
clear
pwd
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Indices de Preços"

* Ambos comandos abaixo fazem a mesma coisa: listam os arquivos presentes no diretório atual.
dir
ls

* Extraindo a planilha de indices de preços de 2002 em formato xlsx:
import excel "Indices de Preços 2002.xlsx", sheet("Plan1") firstrow clear

* Podemos extrair a mesma planilha em formato csv:
import delimited using "Indices de Preços 2002.csv", delim(";") clear
destring, replace dpcomma    	 // Transormando as variáveis em numéricas, e substituindo vírgula por ponto como separador de decimal 
sort cod_uf

* Rotulando a variável uf:
label define cod_uf 11 "RO" 12 "AC" 13 "AM" 14 "RR" 15 "PA" 16 "AP" 17 "TO" 21 "MA" 22 "PI" 23 "CE" 24 "RN" 25 "PB" 26 "PE" 27 "AL" 28 "SE" 29 "BA" 31 "MG" 32 "ES" 33 "RJ" 35 "SP" 41 "PR" 42 "SC" 43 "RS" 50 "MS" 51 "MT" 52 "GO" 53 "DF" 88 "BR"
gen uf = cod_uf
label values uf cod_uf

sort cod_uf
order cod_uf uf cidade price_0 price_1 price_2 price_3 price_4 price_5 price_6 price_7 

* Rotulando as variáveis:
label var price_0 "Índice de Preços geral em 2002"
label var price_1 "Índice de Preços em 2002 da categoria 1 - Alimentação"
label var price_2 "Índice de Preços em 2002 da categoria 2 - Habitação"
label var price_3 "Índice de Preços em 2002 da categoria 3 - Artigos do lar"
label var price_4 "Índice de Preços em 2002 da categoria 4 - Vestuário"
label var price_5 "Índice de Preços em 2002 da categoria 5 - Transporte"
label var price_6 "Índice de Preços em 2002 da categoria 6 - Saúde e cuidados pessoais"
label var price_7 "Índice de Preços em 2002 da categoria 7 - Serviços pessoais, educação e comunicação"
label var cod_uf "Código da UF"
label var uf "Unidade da Federação"
label var cidade "Cidade"

save precos_2002.dta, replace

*****************************************************************************************************************************************************************

* Extraindo a planilha de indices de preços de 2008 em formato xlsx:
import excel "Indices de Preços 2002.xlsx", sheet("Plan1") firstrow clear

* Podemos extrair a mesma planilha em formato csv:
import delimited using "Indices de Preços 2008.csv", delim(";") clear
destring, replace dpcomma    	 // Transormando as variáveis em numéricas, e substituindo vírgula por ponto como separador de decimal 
sort cod_uf

* Rotulando a variável uf:
label define cod_uf 11 "RO" 12 "AC" 13 "AM" 14 "RR" 15 "PA" 16 "AP" 17 "TO" 21 "MA" 22 "PI" 23 "CE" 24 "RN" 25 "PB" 26 "PE" 27 "AL" 28 "SE" 29 "BA" 31 "MG" 32 "ES" 33 "RJ" 35 "SP" 41 "PR" 42 "SC" 43 "RS" 50 "MS" 51 "MT" 52 "GO" 53 "DF" 88 "BR"
gen uf = cod_uf
label values uf cod_uf

label var price_0 "Índice de Preços geral em 2008"
label var price_1 "Índice de Preços em 2008 da categoria 1 - Alimentação"
label var price_2 "Índice de Preços em 2008 da categoria 2 - Habitação"
label var price_3 "Índice de Preços em 2008 da categoria 3 - Artigos do lar"
label var price_4 "Índice de Preços em 2008 da categoria 4 - Vestuário"
label var price_5 "Índice de Preços em 2008 da categoria 5 - Transporte"
label var price_6 "Índice de Preços em 2008 da categoria 6 - Saúde e cuidados pessoais"
label var price_7 "Índice de Preços em 2008 da categoria 7 - Serviços pessoais, educação e comunicação"
label var cod_uf "Código da UF"
label var uf "Unidade da Federação"
label var cidade "Cidade"

order cod_uf uf cidade price_0 price_1 price_2 price_3 price_4 price_5 price_6 price_7 

save precos_2008.dta, replace
