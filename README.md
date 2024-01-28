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


### Média de ocorrêcias por ano

```
SELECT 
    ROUND((SELECT COUNT(*) * 1.0 / COUNT(DISTINCT YEAR(ocorrencia_dia)) FROM ocorrencia), 2) AS 'Média de Ocorrências por Ano'
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/MediaAnualOcorrencias.png" alt="" width="50%">


**Percepções**

Ao ano, em média, a aviação civil brasileira tem 577,71 ocorrêcias.


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

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/OcorrenciasPorAno.png?raw=true" alt="" width="50%">

**Percepções**

As ocorrências registradas de 2015 à 2023 vêm em uma escalada crescimento. Destes o que chamou mais atenção foi o ano de 2023. Ano que não só ultrapassou o recorde histórico que era de 2013, como mais que dobrou. A diferença é enorme até para o ano de 2022. É um valor que deve ser investigado mais profundamente. Pode ter acontecido de fato mais ocorrências, uma maior fiscalização ou até mesmo uma mudança na metodologia que ocasionou esse crescimento. O fato é que esse crescimento continuo pode trazer preocupação.

### Ocorrências do tipo acidente, incidente e incidente grave por ano

Diante dos números alarmantes do item anterior, uma investigação que explique em parte uma possível relação é necessária

**Acidente por ano**

```
SELECT
    YEAR(ocorrencia_dia) AS Ano,
    COUNT(*) AS Total_Acidentes
FROM  
    ocorrencia
WHERE ocorrencia_classificacao = 'ACIDENTE'
GROUP BY
    YEAR(ocorrencia_dia)
ORDER BY
    Ano
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/AcidenteAnopng.png" alt="" width="50%">

**Incidente Grave por ano**

```
SELECT
    YEAR(ocorrencia_dia) AS Ano,
    COUNT(*) AS Total_Acidentes
FROM  
    ocorrencia
WHERE ocorrencia_classificacao = 'INCIDENTE GRAVE'
GROUP BY
    YEAR(ocorrencia_dia)
ORDER BY
    Ano
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/IncidenteGraveAno.png" alt="" width="50%">

**Incidente por ano**

```
SELECT
    YEAR(ocorrencia_dia) AS Ano,
    COUNT(*) AS Total_Acidentes
FROM  
    ocorrencia
WHERE ocorrencia_classificacao = 'INCIDENTE'
GROUP BY
    YEAR(ocorrencia_dia)
ORDER BY
    Ano
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/IncidenteAno.png" alt="" width="50%">

**Percepções**

A investigação nos traz que o número expressivo de ocorrências em 2023 está ligada diretamente com o número de incidentes. Os números de acidentes e de incidentes graves oscilaram dentro de uma aparente normalidade. É um achado que de certa forma pode ser considerado como uma boa notícia. Pois o aumento expressivo está ligado com o tipo de ocorrêcia menos preocupante.


### Distribuição de ocorrências por Unidades Federativas

```
SELECT  TOP (10)
	ocorrencia_uf AS 'Estados', 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
	ocorrencia
GROUP BY 
	ocorrencia_uf
ORDER BY
	COUNT(*) DESC
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/OcorrenciasPorEstado.png" alt="" width="100%">


**Percepções**

Como esperado, o maior número de ocorrências registradas aconteceram no estado de São Paulo. Mais até que a soma de todos os estados da região Sudeste. Esse número pode ser explicado por ser o estado com mais aeroportos e consequentemente uma maior movimentação aérea. Para a região Sul, o estado que se destaca é o do Paraná. No Centro-Oeste, Mato Grosso. No Norte, Pará. E no Nordeste, o Estado da Bahia. 

Na base de dados existem registros sem UF, preenchidos com "***". Estes registros são de ocorrências em aeronaves que decolaram no Brasil mas que tiveram problemas em águas internacionais ou em lugar desconhecido, Como pode ser visto abaixo.
```
SELECT  
	ocorrencia_uf, ocorrencia_classificacao, ocorrencia_cidade, ocorrencia_dia
FROM  
	ocorrencia
WHERE 
	ocorrencia_uf = '***'
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/ocorrenciasSEMUF.png" alt="" width="100%">


### Tipos de ocorrência

Em um item anterior, analisamos a classificação de ocorrêcias. Onde foi visto por uma perspectiva de gravidade. Neste item, a analise será feita pelo tipo da ocorrência. Ou seja, o que de fato aconteceu. Na consulta abaixo foi selecionada as 20 maiores causas, de um universo de 86 tipos de ocorrências.

```
SELECT TOP (20)
	ocorrencia_tipo, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
	ocorrencia_tipo
GROUP BY 
	ocorrencia_tipo
ORDER BY
	COUNT(*) DESC
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/PercentualTipoOcorrencia.png" alt="" width="100%">


**Percepções**

Temos que das cinco principais causas de ocorrências, quatro são de fatores que em tese não remetem à falha humana. Do ponto de vista para o profissional de aviação são bons resultados. Mas por outro lado, mostra uma certa preocupação por serem situações que fogem de seu controle. Essas informações são de grande importância para as fabricantes de aeronaves. É válido destacar também as ocorrências de colisão com aves, que é um problema que necessita de uma cooperação de todos os envolvidos nesse sistema. O CENIPA entrega um anuário ratificando seu compromisso de contribuir para a prevenção de acidentes aeronáuticos, decorrentes de colisões com fauna, com o desenvolvimento contínuo de técnicas de investigação deste tipo de ocorrência, manutenção do SIGRA (Sistema de Gerenciamento de Risco Aviário) e trabalho em cooperação com outras organizaçõoes (ANAC, Operadores de Aeródromos, SAC, etc) para desenvolver produtos que melhorem o gerenciamento de desse tipo de ocorrência e ao mesmo tempo proteja a fauna no Brasil.

### Tipos de ocorrência por incidente

Como mostrado em um item anterior, foi evidenciado um aumento muito forte de ocorrências entre os anos de 2022 e 2023. Assim foi feita uma breve investigação, e constatou-se que esse aumento tem relação com o aumento das ocorrências classicadas como incidentes. E agora para saber qual tipo de ocorrência afetou diretamento o resultado, vamos para a proxima consulta.
Foi comparado os anos de 2022 e 2023.
```
SELECT TOP (5)
    ocorrencia_tipo, 
    COUNT(*) AS total_ocorrencias,
    FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
    ocorrencia_tipo
INNER JOIN ocorrencia
ON  ocorrencia_tipo.codigo_ocorrencia1 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'INCIDENTE' AND YEAR(ocorrencia_dia) = 2022
GROUP BY 
    ocorrencia_tipo
ORDER BY
    COUNT(*) DESC
```
```
SELECT TOP (5)
    ocorrencia_tipo, 
    COUNT(*) AS total_ocorrencias,
    FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
    ocorrencia_tipo
INNER JOIN ocorrencia
ON  ocorrencia_tipo.codigo_ocorrencia1 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'INCIDENTE' AND YEAR(ocorrencia_dia) = 2023
GROUP BY 
    ocorrencia_tipo
ORDER BY
    COUNT(*) DESC
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/IncidentesTipo2022e2023.png" alt="" width="100%">

**Percepções**

Como observado acima, a razão do grande aumento de ocorrências em 2023 foi o aumento expressivo de colisões com aves. Esse aumento pode ser causado de fato pelo aumento desse tipo de ocorrência, por uma maior fiscalização ou por uma mudança metodológica.


### Qual tipo de motor mais gerou ocorrências?

```
SELECT
	aeronave_motor_tipo, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
GROUP BY 
	aeronave_motor_tipo
ORDER BY
	COUNT(*) DESC
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/OcorrenciaMotor.png" alt="" width="100%">


**Percepções**

A popularidade é causa direta de o número 1 de ocorrências aéreas serem os **motores à pistão**. Os motores à pistão são uma opção comum em aviação, conhecidos por sua simplicidade, confiabilidade e facilidade de manutenção. Semelhantes aos motores de carros, são amplamente utilizados em aeronaves de treinamento e na aviação executiva, como no Beechcraft Baron e Piper Seneca. Além da versatilidade operacional, esses motores oferecem custos mais baixos devido à disponibilidade de mão de obra qualificada e ao uso de gasolina, mais econômica que o querosene de aviação. Sua comparação com os motores do Volkswagen Fusca destaca a acessibilidade e praticidade associadas a essa tecnologia na aviação. Em segundo lugar, os **motores à jato ou Turbofan**. Os motores turbofan funcionam inversamente aos turbo-hélices, gerando força ao expelir o ar para trás. Destacam-se pela eficiência em altas velocidades, contrastando com os turbo-hélices. A comparação com automóveis ilustra a diferença de desempenho em arrancadas e velocidades elevadas. Esses motores demandam considerável fluxo de ar para operar plenamente, passando por compressores, câmara de combustão e turbina. Aeronaves com motores à jato necessitam de infraestrutura aeroportuária mais robusta e podem ter maior consumo de combustível. A escolha entre esses motores depende das necessidades específicas do voo. A Flapper oferece aeronaves seguras e certificadas para voos personalizados no Brasil e no exterior, proporcionando tranquilidade aos clientes. Em terceiro os **Turbo-Helice**. Os motores turbo-hélice destacam-se por suas grandes hélices acopladas ao próprio eixo, muitas vezes ultrapassando a altura da aeronave. Essa característica gera uma tração significativa, facilitando operações em pistas curtas tanto durante decolagens quanto pousos. O "passo reverso" das pás, ajustado pelos pilotos por meio do governo da hélice, contribui para efetiva frenagem mecânica, aumentando a eficiência dos freios. Comparáveis ao torque de automóveis turbo, esses motores são adaptáveis em diversas fases do voo, permitindo ajustes automáticos ou manuais no ângulo das pás. A eficiência e menor consumo de combustível, especialmente ao utilizar querosene, tornam os motores turbo-hélice atrativos, com destaque para modelos como o Pratt & Whitney PT-6, reconhecidos por sua confiabilidade. O ajuste de passo desempenha papel crucial em situações de pane de motor, proporcionando controle aerodinâmico em condições extremas.


### Qual tipo de aeronave gerou mais ocorrências?

```
SELECT
	aeronave_tipo_veiculo, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
GROUP BY 
	aeronave_tipo_veiculo
ORDER BY
	COUNT(*) DESC
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/OcorrenciaTipoAeronave.png" alt="" width="100%">

**Percepções**

Claramente, ocorrências com aviões são notavelmente mais comuns do que qualquer outro tipo de aeronave. Além disso, o número total de ocorrências com aviões supera a soma de todos os outros tipos de aeronaves. 

### Qual fabricante de aeronave gerou mais ocorrências?

```
SELECT TOP (10)
	aeronave_fabricante, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
GROUP BY 
	aeronave_fabricante
ORDER BY
	COUNT(*) DESC
```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/OcorrenciaFabricante.png" alt="" width="100%">

**Percepções**

A fabricante americana Cessna Aircraft ocupa 13,66% das causas de ocorrências envolvendo aeronaves, seguida das brasileiras EMBRAER e Neiva Industria. 

A **Cessna Aircraft**, integrada à Textron Aviation, tem uma presença consolidada no mercado aéreo brasileiro. Suas aeronaves, desde modelos leves até jatos executivos, são amplamente utilizadas em operações de aviação geral, treinamento de pilotos e voos executivos. A Cessna é reconhecida por oferecer aeronaves versáteis e confiáveis, adaptadas às demandas diversificadas da aviação no Brasil.

A **Embraer** é uma das maiores fabricantes de aeronaves do mundo e tem uma influência significativa no mercado aéreo brasileiro. Reconhecida por seus jatos comerciais, executivos e militares, a Embraer desempenha um papel importante na aviação civil e de defesa no Brasil. Além da produção de aeronaves, a empresa também oferece soluções integradas em serviços de suporte e treinamento.

A **Neiva Indústria Aeronáutica**, agora parte da Embraer, teve uma presença marcante na aviação brasileira. Especializada em aeronaves de treinamento, como o conhecido T-25 Universal, a Neiva contribuiu para o desenvolvimento da aviação militar e civil no Brasil. Seu histórico inclui a produção de aeronaves robustas e adaptadas às demandas das forças armadas e escolas de aviação no país.

Essas fabricantes desempenham papéis distintos, oferecendo diversidade e qualidade à frota aérea brasileira, abrangendo desde a aviação geral até segmentos militares e executivos.
