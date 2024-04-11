--	Quais os tipos de ocorrências que existem?

SELECT 	* FROM 	ocorrencia_tipo

-- Quais as ocorrências mais comuns?

SELECT DISTINCT ocorrencia_tipo FROM ocorrencia_tipo

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

-- Quais as ocorrências mais causam acidentes?

-- Passo 1

SELECT
	ocorrencia_tipo.codigo_ocorrencia1,
	ocorrencia_tipo.ocorrencia_tipo,
	ocorrencia.ocorrencia_classificacao
FROM 
	ocorrencia_tipo
INNER JOIN ocorrencia
ON 	ocorrencia_tipo.codigo_ocorrencia1 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'ACIDENTE'

-- Passo 2

SELECT
	ocorrencia_tipo, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	ocorrencia_tipo
INNER JOIN ocorrencia
ON 	ocorrencia_tipo.codigo_ocorrencia1 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'ACIDENTE'
GROUP BY 
	ocorrencia_tipo
ORDER BY
	COUNT(*) DESC

-- Quais as ocorrências mais causam incidentes?

SELECT
	ocorrencia_tipo, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	ocorrencia_tipo
INNER JOIN ocorrencia
ON 	ocorrencia_tipo.codigo_ocorrencia1 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'INCIDENTE'
GROUP BY 
	ocorrencia_tipo
ORDER BY
	COUNT(*) DESC

SELECT 
	COUNT(DISTINCT ocorrencia_tipo)
FROM
	ocorrencia_tipo

-- COMPARATIVO INCIDENTES DE 2022 E 2023

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
    COUNT(*) DESC;


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
    COUNT(*) DESC;


