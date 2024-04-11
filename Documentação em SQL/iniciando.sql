SELECT DISTINCT aeronave_fabricante  FROM  	aeronave


SELECT 	count(*) FROM 	aeronave

SELECT 	count(*) FROM 	ocorrencia

SELECT 	count(*) FROM  	ocorrencia_tipo


SELECT 	top (10) * FROM  aeronave

SELECT 	top (10) * FROM  ocorrencia

SELECT 	top (10) * FROM  ocorrencia_tipo

SELECT 	top (10) * FROM  recomendacao


-- EXPLORANDO OS TIPOS DE COLUNAS DOS 3 DATASETS
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'ocorrencia'


SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'ocorrencia_tipo'


SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'aeronave'


-- INTERVALO DA BASE DE DADOS 

SELECT top 1 
	ocorrencia_dia AS 'Inicio'
FROM 
	ocorrencia 
ORDER BY 
	ocorrencia_dia ASC 


SELECT top 1 
	ocorrencia_dia AS 'Fim'
FROM 
	ocorrencia



-- Quantas ocorr�ncias?

SELECT 	
	count(*) AS 'Quantidade Total de Ocorr�ncias' 
FROM 
	ocorrencia






-- Como � classificada uma ocorr�ncia? 

SELECT DISTINCT 
	ocorrencia_classificacao AS 'Tipos de Ocorr�cias' 
FROM  
	ocorrencia

--Como se divide o total geral nestas categorias?

SELECT 
    ocorrencia_classificacao,
    COUNT(*) AS total_ocorrencias,
    FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
    ocorrencia 
GROUP BY 
    ocorrencia_classificacao;

-- Quantidade de ocorr�ncias por Estados

SELECT TOP (10)  
	ocorrencia_uf AS 'Estados', 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
	ocorrencia
GROUP BY 
	ocorrencia_uf
ORDER BY
	COUNT(*) DESC


SELECT  
	ocorrencia_uf, ocorrencia_classificacao, ocorrencia_cidade, ocorrencia_dia
FROM  
	ocorrencia
WHERE 
	ocorrencia_uf = '***'




-- M�DIA DE INCIDENTES POR ANO

SELECT 
    ROUND((SELECT COUNT(*) * 1.0 / COUNT(DISTINCT YEAR(ocorrencia_dia)) FROM ocorrencia), 2) AS 'M�dia de Ocorr�ncias por Ano'

/*
COUNT(*): Conta o n�mero total de registros na tabela ocorrencia.
* 1.0: Multiplica��o por 1.0 para garantir que a divis�o seja tratada como um n�mero de ponto flutuante.
COUNT(DISTINCT YEAR(ocorrencia_dia)): Conta o n�mero de anos distintos presentes na coluna ocorrencia_dia.
*/

/* 
COUNT(*): Conta o n�mero total de registros na tabela ocorrencia.
* 1.0: Multiplica��o por 1.0 para garantir que a divis�o seja tratada como um n�mero de ponto flutuante.
COUNT(DISTINCT YEAR(ocorrencia_dia)): Conta o n�mero de anos distintos presentes na coluna ocorrencia_dia.
*/



-- Quantidade de ocorr�ncias por ano

SELECT
    YEAR(ocorrencia_dia) AS Ano,
    COUNT(*) AS Total_Ocorrencias
FROM  
    ocorrencia
GROUP BY
    YEAR(ocorrencia_dia)
ORDER BY
	Ano

-- Quantidade de ocorr�ncias do tipo 'acidente' por ano

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

-- Quantidade de ocorr�ncias do tipo 'incidente grave' por ano

SELECT
    YEAR(ocorrencia_dia) AS Ano,
    COUNT(*) AS Total_Incidentes
FROM  
    ocorrencia
WHERE ocorrencia_classificacao = ('INCIDENTE GRAVE')
GROUP BY
    YEAR(ocorrencia_dia)
ORDER BY
    Ano


-- Quantidade de ocorr�ncias do tipo 'incidente' por ano

SELECT
    YEAR(ocorrencia_dia) AS Ano,
    COUNT(*) AS Total_Incidentes
FROM  
    ocorrencia
WHERE ocorrencia_classificacao = 'INCIDENTE'
GROUP BY
    YEAR(ocorrencia_dia)
ORDER BY
    Ano


-- STATUS DE INVESTIGA��O

SELECT  
	investigacao_status, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
	ocorrencia
GROUP BY 
	investigacao_status
ORDER BY
	COUNT(*) DESC

-- DAS INVESTIGA��ES FINALIZADAS, QUANTOS RELATORIOS FORAM PUBLICADOS

SELECT  
	divulgacao_relatorio_publicado, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM  
	ocorrencia
WHERE
	investigacao_status = 'FINALIZADA'
GROUP BY 
	divulgacao_relatorio_publicado
ORDER BY
	COUNT(*) DESC




