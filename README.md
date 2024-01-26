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

```
SELECT 	
	count(*) AS 'Quantidade Total de Ocorrências' 
FROM 
	ocorrencia
 ```

<img src="https://github.com/welingtonfonsec/Ocorrencias-Aeronauticas-na-Aviacao-Civil-Brasileira/blob/main/Imagens/QuantidadeOcorrencias.png" alt="" width="100%">


**Percepções**

SELECT DISTINCT 
	ocorrencia_classificacao AS 'Tipos de Ocorrêcias' 
FROM  
	ocorrencia


SELECT 
    ocorrencia_classificacao,
    COUNT(*) AS total_ocorrencias,
    FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
    ocorrencia 
GROUP BY 
    ocorrencia_classificacao;
