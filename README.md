# ESTUDO DE CASO: 
## Análise das Ocorrências Aeronáuticas na Aviação Civil Brasileira

Autor: Welington Fonseca


## Índice

[1. Introdução](#introdução)

[2. Tarefa de Negócios](#tarefa-de-negócios)

[3. Dados](#dados)

[4. Processamento e Exploração](#processamento-e-exploração)

[5. Análise e Visualização](#análise-e-visualização)

[6. Conclusão e recomendações](#conclusão-e-recomendações)



### Quantas ocorrências estão registradas no banco de dados?

Primeiramente é importante que se conceitue o que de fato é uma ocorrência. Segundo a Agência Nacional de Aviação Civil - ANAC, é considerada Ocorrência de Segurança Operacional qualquer evento havido durante a operação da aeronave que fuja dos parâmetros previstos na regulamentação, nos manuais técnicos e demais documentos que orientam a atividade aérea e que exponham a aeronave e/ou seus ocupantes a condições de perigo real ou potencial. Agora vamos para a consulta.

```
SELECT 	
	count(*) AS 'Quantidade Total de Ocorrências' 
FROM 
	ocorrencia
 ```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/QuantidadeOcorrencias.png?raw=true" alt="" width="100%">


**Percepções**

Como foi observado na consulta, durante o periodo foram registradas 9821 ocorrências.


### Como é classificada uma ocorrência? 

As ocorrências são classificadas em Acidente, Incidente e Incidente Grave.

**Acidente**

É toda ocorrência relacionada com a operação de uma aeronave, havida entre o período em que uma pessoa nela embarca com a intenção de realizar um voo, até
o momento em que todas as pessoas tenham dela desembarcado e, durante o qual, pelo menos uma das situações abaixo ocorra:

a) qualquer **pessoa sofra lesão grave ou morra** como resultado de estar na aeronave, em contato direto com qualquer uma de suas partes, incluindo aquelas
que dela tenham se desprendido, ou submetida à exposição direta do sopro de hélice, rotor ou escapamento de jato, ou às suas consequências. Exceção é feita
quando as lesões resultarem de causas naturais, forem auto ou por terceiros infligidas, ou forem causadas a pessoas que embarcaram clandestinamente e se
acomodaram em área que não as destinadas aos passageiros e tripulantes;

b) a **aeronave** sofra dano ou falha estrutural que afete adversamente** a resistência estrutural, o seu desempenho ou as suas características de voo; exija
a substituição de grandes componentes ou a realização de grandes reparos no componente afetado. Exceção é feita para falha ou danos limitados ao motor,
suas carenagens ou acessórios; ou para danos limitados a hélices, pontas de asa, antenas, pneus, freios, carenagens do trem, amassamentos leves e pequenas
perfurações no revestimento da aeronave; 

c) a aeronave seja considerada **desaparecida** ou o local onde se encontre seja
**absolutamente inacessível.**

**Incidente**

É toda ocorrência, inclusive de tráfego aéreo, associada à operação de uma aeronave, havendo intenção de voo, que não chegue a se caracterizar como um
acidente, mas que **afete ou possa afetar a segurança da operação.**

**Incidente Grave**

Incidente grave (serious incident) é uma ocorrência intermediária entre acidente e incidente, definida na NSCA 3-1 do CENIPA, item 3.63, como:
“3.63.1 Incidente ocorrido sob circunstâncias em que um acidente quase ocorreu. **A diferença entre o incidente grave e o acidente está apenas nas conseqüências.**”

```
SELECT DISTINCT 
	ocorrencia_classificacao AS 'Tipos de Ocorrêcias' 
FROM  
	ocorrencia
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/TiposDeOcorrecia.png" alt="" width="50%">


### Como se divide o total geral nestas categorias?

```
SELECT 
    ocorrencia_classificacao,
    COUNT(*) AS total_ocorrencias,
    FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
    ocorrencia 
GROUP BY 
    ocorrencia_classificacao;
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/Percentual-Acid-Inc-IncGrav.png" alt="" width="50%">


**Percepções**

Diante da consulta é evidenciado que a grande maioria das ocorrêcias registradas durante o período são as de menor gravidade, pelo menos para a ANAC. Ou seja, são números confortantes.


### Quantas ocorrências por ano?

```
SELECT
    YEAR(ocorrencia_dia) AS Ano,
    COUNT(*) AS Total_Ocorrencias
FROM  
    ocorrencia
GROUP BY
    YEAR(ocorrencia_dia)
ORDER BY
    Total_Ocorrencias DESC
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/OcorrenciasPorAno.png" alt="" width="50%">

**Percepções**
