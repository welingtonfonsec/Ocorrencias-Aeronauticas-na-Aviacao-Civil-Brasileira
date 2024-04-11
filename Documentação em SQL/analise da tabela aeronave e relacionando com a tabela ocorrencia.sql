
-- QUAL TIPO DE MOTOR GEROU MAIS OCORRÊNCIAS?

SELECT * FROM  aeronave

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

-- OCORRÊNCIAS POR TIPO DE AERONAVE

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


-- OCORRÊNCIAS POR FABRICANTE

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

-- QUAL O TIPO DE VOO COSTUMA TER MAIS OCORRÊNCIAS?

SELECT
	aeronave_registro_segmento, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
GROUP BY 
	aeronave_registro_segmento
ORDER BY
	COUNT(*) DESC


-- QUAL O TIPO DE VOO COSTUMA TER MAIS OCORRÊNCIAS DO TIPO ACIDENTE?

SELECT
	aeronave_registro_segmento, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'ACIDENTE'
GROUP BY 
	aeronave_registro_segmento
ORDER BY
	COUNT(*) DESC


-- ACIDENTE POR QUANTIDADE DE MOTORES DAS AERONAVES

SELECT
	aeronave_motor_quantidade, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'ACIDENTE'
GROUP BY 
	aeronave_motor_quantidade
ORDER BY
	COUNT(*) DESC


-- OCORRÊNCIAS POR FASE DE OPERAÇÃO

SELECT TOP (10)
	aeronave_fase_operacao, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
GROUP BY 
	aeronave_fase_operacao
ORDER BY
	COUNT(*) DESC


-- OCORRÊNCIAS POR TIPO DE DANO

SELECT
	aeronave_nivel_dano, 
	COUNT(*) AS total_ocorrencias,
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
GROUP BY 
	aeronave_nivel_dano
ORDER BY
	COUNT(*) DESC

-- MORTES POR OCORRÊNCIA

SELECT
	aeronave_fatalidades_total AS 'Mortes', 
	COUNT(aeronave_fatalidades_total) AS 'Frequência',
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
GROUP BY 
	aeronave_fatalidades_total
ORDER BY
	COUNT(*) DESC

-- MORTES POR OCORRÊNCIA DO TIPO ACIDENTE

SELECT
	aeronave_fatalidades_total AS 'Mortes', 
	COUNT(aeronave_fatalidades_total) AS 'Frequência',
	FORMAT(CAST(COUNT(*) AS DECIMAL(18, 2)) / CAST(SUM(COUNT(*)) OVER () AS DECIMAL(18, 2)), '0.00%') AS 'Percentual'
FROM 
	aeronave
INNER JOIN ocorrencia
ON 	aeronave.codigo_ocorrencia2 = ocorrencia.codigo_ocorrencia1
WHERE ocorrencia_classificacao = 'ACIDENTE'
GROUP BY 
	aeronave_fatalidades_total
ORDER BY
	COUNT(*) DESC







