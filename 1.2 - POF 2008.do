******************************************************************************************************************************************
* MICROECONOMIA EMPÍRICA - 2019
* TRABALHO FINAL
* ALUNO: JOSÉ EDUARDO SOUSA
******************************************************************************************************************************************

*******************************************************************************************************************************************
*								EXTRAÇÃO DA POF 2008 VIA DATAZOOM E ORGANIZAÇÃO INICIAL
*******************************************************************************************************************************************




/* Devemos então agregar as despesas totais nos bens consumidos em nove categorias, correspondentes às categorias as quais possuímos os índices de preços, que são:

1 - Alimentação e bebidas
2 - Habitação
3 - Artigos de residência
4 - Vestuário
5 - Transportes
6 - Saúde e cuidados pessoais
7 - Despesas pessoais
8 - Educação
9 - Comunicação

Faremos isso identificando em qual categoria cada tipo de gasto se encaixa, e somando todos os gastos pertencentes a uma mesma categoria:	*/

* Definindo o diretório onde estão os dados:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Bases Salvas pelo Datazoom"

/* Abrindo a base de dados da POF 2008/2009, que foi extraída previamente a partir da rotina disponibilizada pelo Datazoom para Bases Personalizadas, na qual a base já é extraída de modo
   a se definir as categorias de agregação desejadas. 
   
   (No entanto, para se obter exatamente o nível de agregação desejado, ainda é necessário realizar alguns ajustes.)      */
   
use pof2008_pess_customized, clear

* Agregando para criar a categoria "Saúde e Cuidados Pessoais":
gen saude_gastospessoais_total =  v_DT_5_tot + v_DT_6_tot
label variable saude_gastospessoais_total "Despesa total com saúde e cuidados pessoais"

* Agregando para criar a categoria "7 - Despesas Pessoais, Educação e Leitura" 
gen despesa_7 =  v_DT_10_tot +  v_DT_7_tot +  v_DT_112_tot
label variable despesa_7 "Despesa total em Serviços pessoais, educação e comunicação"

* Renomeando e rotulando as variáveis:
label var cod_uf "Código da UF"
label var num_seq "Número sequencial" 
label var cod_dom "Número do domicílio"

rename qtd_morador_domc n_moradores
label var n_moradores "Número de moradores no domicílio"

rename v_RE_1_tot rendimento_total
label var rendimento_total "Rendimento Total (v_RE_1_tot)"

rename renda_total renda
label var renda "Renda total mensal do domicílio"

rename v_DA_0_tot despesa_1
label var despesa_1 "Despesa total em alimentação'"

rename v_DT_2_tot despesa_2
label var despesa_2 "Despesa Total em Habitação"

rename v_DT_26_tot despesa_3
label var despesa_3 "Despesa Total em Mobiliários e artigos do lar"

rename v_DT_3_tot despesa_4
label var despesa_4 "Despesa total Vestuário"

rename v_DT_4_tot despesa_5
label var despesa_5 "Despesa Total em Transporte"

rename saude_gastospessoais_total despesa_6
label var despesa_6 "Despesa total em saúde e cuidados pessoais"

label var num_inf "Número de ordem do morador"

rename num_uc id_uc
rename anos_de_estudo anos_est

rename idade_anos idade
label var idade "Idade em anos"

rename cod_sexo sexo
label define sexo 1 "Homem" 2 "Mulher"
label values sexo sexo

* Rotulando a variável de UF:
label define cod_uf 11 "RO" 12 "AC" 13 "AM" 14 "RR" 15 "PA" 16 "AP" 17 "TO" 21 "MA" 22 "PI" 23 "CE" 24 "RN" 25 "PB" 26 "PE" 27 "AL" 28 "SE" 29 "BA" 31 "MG" 32 "ES" 33 "RJ" 35 "SP" 41 "PR" 42 "SC" 43 "RS" 50 "MS" 51 "MT" 52 "GO" 53 "DF" 88 "BR"
gen uf = cod_uf
label values uf cod_uf

* Gerando Dummies de região e variável região
gen sudeste = cod_uf
recode sudeste 11/29=0 31/35=1 41/53=0
gen sul = cod_uf
recode sul 11/35=0 41/43=1 50/53=0
gen nordeste = cod_uf
recode nordeste 11/17=0 21/29=1 31/53=0
gen norte = cod_uf
recode norte 11/17=1 21/53=0
gen centrooeste = cod_uf
recode centrooeste 11/43=0 50/53=1

gen regiao = cod_uf
replace regiao = 1 if sudeste == 1
replace regiao = 2 if sul == 1 
replace regiao = 3 if nordeste == 1 
replace regiao = 4 if norte == 1 
replace regiao = 5 if centrooeste == 1

label define regiao 1 "Sudeste" 2 "Sul" 3 "Nordeste" 4 "Norte" 5 "Centro-Oeste"
label values regiao regiao


* Agregando para criar a categoria "Gastos Totais"
gen despesa_0 = despesa_1 + despesa_2 + despesa_3 + despesa_4 + despesa_5 + despesa_6 + despesa_7
label var despesa_0 "Despesa Total do indivíduo"

rename cod_domc cod_dom

* Gerando as variáveis de budget share:	
foreach i in 1 2 3 4 5 6 7 {

gen budget_`i' = despesa_`i'/despesa_0 

}

*drop ano
gen ano = 2008

// foreach var of varlist despesa* { 
//  
// gen budget_`var' = `var'/despesa_0
//
// }

* Gerando a variável que indica se o indivíduo possui casa própria: (VER DICIONÁRIO DA VARIÁVEL cod_tipo_domc):
gen casa_propria = ( cod_cond_ocup == 1 | cod_cond_ocup == 2 )
gen casa_propria_2008 = casa_propria

* Gerando a variável dummy que indica se o indivíduo mora em casa (Ver dicionário):
gen casa = ( cod_tipo_domc == 1 )

* Mantendo na base de dados somente as variáveis de interesse. (OBS: budget* seleciona todas as variáveis cujo nome começa com despesa, por exemplo)
keep ano regiao uf cod_uf num_seq num_dv cod_dom id_uc num_inf sexo anos_est idade casa_propria casa_propria_2008 urbano casa n_moradores renda rendimento_total despesa* budget* nordeste norte sudeste sul centrooeste
order ano regiao uf cod_uf num_seq num_dv cod_dom id_uc num_inf n_moradores renda rendimento_total sexo idade anos_est casa casa_propria casa_propria_2008 urbano despesa_0 despesa_1 despesa_2 despesa_3 despesa_4 despesa_5 despesa_6 despesa_7 budget* nordeste norte sudeste sul centrooeste

* Rotulando as variáveis para padronizar com a base de 2002:
label var cod_uf "Código da UF"
label var num_seq "Número Sequencial"
label var num_dv "DV do sequencial"
label var cod_dom "Número do domicílio" 
*label var id_dom "Código do domicílio (cod_uf num_seq num_dv cod_dom)"
label var id_uc "Número da unidade de consumo (UC) (cod_uf num_seq num_dv cod_dom uc)"
label var num_inf "Número de ordem do morador"
label var sexo "Sexo do indivíduo"
label var anos_est "Anos de estudo" 
label var idade "Idade em anos"
label var n_moradores "Número de moradores no domicílio"
label var renda "Renda total mensal do domicílio"
label var rendimento_total "Rendimento Total (v_RE_1_tot)"
label var despesa_0 "Despesa Total do indivíduo" 
label var despesa_1 "Despesa total em Alimentos"
label var despesa_2 "Despesa Total em Habitação"
label var despesa_3 "Despesa Total em Mobiliário e artigos do lar"
label var despesa_4 "Despesa total Vestuário"
label var despesa_5 "Despesa Total em Transporte"
label variable despesa_6 "Despesa total em saúde e cuidados pessoais"
label variable despesa_7 "Despesa total em Serviços pessoais, educação e comunicação"
label var budget_1 "Budget Share - Despesa em Alimentação"
label var budget_2 "Budget Share - Despesa em Habitação" 
label var budget_3 "Budget Share - Despesa em Mobiliários e artigos do lar"
label var budget_4 "Budget Share - Despesa em Vestuário"
label var budget_5 "Budget Share - Despesa em Transporte"
label var budget_6 "Budget Share - Despesa em Saúde e Cuidados Pessoais"
label var budget_7 "Budget Share - Despesa em Serviços pessoais, educação e comunicação"
label var uf "Unidade da federação"
label var ano "Ano da pesquisa"
label var regiao "Região"
label var nordeste "Dummy para região Nordeste"
label var sul "Dummy para região Sul"
label var centrooeste "Dummy para região Centro-Oeste"
label var sudeste "Dummy para região Sudeste"
label var norte "Dummy para região Norte"
label var casa_propria "Indica se o indivíduo possui casa própria"
label var casa_propria_2008 "Indica se o indivíduo possui casa própria em 2008"
label var casa "Dummy que indica se o indivíduo mora em uma casa"

* Salvando a base de dados:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Bases Manipuladas"
save POF_2008_manipulada, replace
