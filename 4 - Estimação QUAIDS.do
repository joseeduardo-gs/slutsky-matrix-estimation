******************************************************************************************************************************************
* MICROECONOMIA EMPÍRICA - 2019
* TRABALHO FINAL
* ALUNO: JOSÉ EDUARDO SOUSA
******************************************************************************************************************************************

*******************************************************************************************************************************************
*											ESTIMAÇÃO DO MODELO QUAIDS
*******************************************************************************************************************************************
* 

clear

* Abrindo as bases de dados prontas:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Bases Manipuladas"
use base_pronta.dta, clear

* Estimando a estimação QUAIDS a partir do comando aidsills. Ver sintaxe do comando no documento disponibilzado.

// ** Estimando para ambos os sexos, na forma padrão, com especificação de homogeneidade, e homogeneidade + simetria, respectivamente:
// aidsills budget*, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic
// aidsills budget*, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic homogeneity
// aidsills budget*, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic homogeneity symmetry
//
// * Estimação para cada sexo separadamente:
// aidsills budget* if sexo == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic  // Homens
// aidsills budget* if sexo == 2, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic  // Mulheres
//
// * Estimativas impondo simetria (não retorna teste de simetria):
// aidsills budget* if sexo == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic homogeneity symmetry // Homens
// aidsills budget* if sexo == 2, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic homogeneity symmetry // Mulheres
//
//
// * Esta especificação retorna um teste de simetria:
// aidsills budget* if sexo == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic homogeneity  // Homens
// aidsills budget* if sexo == 2, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) quadratic homogeneity // Mulheres


* Estimativas controlando por características sociodemográficas, que são incluídas no termo intercept,
* e usando a Dummie da região Sul usada como categoria base. Note também que não há ninguém do centro-oeste na base, de modo que é uma variável constante e igual a zero,
* e portanto a dummie desta região não deve ser usada para não gerar colinearidade perfeita:


* MELHOR ATÉ AGORA
* Controles: ano, idade, escolaridade, casa própria, região.
aidsills budget* if sexo == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(ano_2008 idade anos_est casa_propria nordeste norte sudeste) quadratic homogeneity  // Homens
aidsills budget* if sexo == 2, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(ano_2008 idade anos_est casa_propria nordeste norte sudeste) quadratic homogeneity  // Mulheres

* Controles: ano, idade, escolaridade, casa própria, região. Área úrbana
aidsills budget* if sexo == 1 & urbano == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(ano_2008 idade anos_est casa_propria nordeste norte sudeste) quadratic homogeneity  // Homens
aidsills budget* if sexo == 2 & urbano == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(ano_2008 idade anos_est casa_propria nordeste norte sudeste) quadratic homogeneity  // Mulheres

* Controles: ano, idade, escolaridade, casa própria, região e urbano.
aidsills budget* if sexo == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(urbano ano_2008 idade anos_est casa_propria_2002 casa_propria_2008 nordeste norte sudeste) quadratic homogeneity  // Homens
aidsills budget* if sexo == 2, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(urbano ano_2008 idade anos_est casa_propria_2002 casa_propria_2008 nordeste norte sudeste) quadratic homogeneity  // Mulheres



************************************************************************************************************************************************************************************************


* Repetindo e gravando um arquivo log com a melhor especificação:

* Arquivo Log-file para gravar os resultados:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Eletivas\Microeconomia Empírica\Trabalho Final\Do-files e Log Files"
log using "log QUAIDS", text replace

* Controles: ano, idade, escolaridade, casa própria, região. Área úrbana
aidsills budget* if sexo == 1 & urbano == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(ano_2008 idade anos_est casa_propria nordeste norte sudeste) quadratic homogeneity  // Homens
aidsills budget* if sexo == 2 & urbano == 1, prices(price_1 - price_7) expenditure(despesa_0) ivexpenditure(renda) intercept(ano_2008 idade anos_est casa_propria nordeste norte sudeste) quadratic homogeneity  // Mulheres


log close


