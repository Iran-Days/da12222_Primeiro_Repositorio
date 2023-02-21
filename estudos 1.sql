-------------------------------------------------------
-- Praticando
-- Algumas Funçõe Básicas SQL
-- Iran Dias
-------------------------------------------------------


-- comando primario "Select"
SELECT * -- O "Asterisco" selecina todas as colunas de uma tabela
From orders -- "From" Seleciona a Tabela a ser exibida 
Limit -- "LIMITE" Define o Limite de linhas a serem exibidas
--exemplo 
Select * 
   From orders 
Limit 10

-- "Distinct" é uma função que separa os dados distintos, sem repetir algum dado em comum entre as informações

select DISTINCT product_category_name from products p 

-- Para contar a quantidade de dados que existem dentro da tabela usa-se "Count" 

select COUNT  (product_category_name) from products p

-- usando count em distinct

select COUNT(DISTINCT product_category_name) from products p 

---------------------------------------------------------------------
-- Quantas Categorias de produtos existem dentro de OLIST?
---------------------------------------------------------------------

Select DISTINCT  product_category_name FRO
 FROM products 
 SELECT 
 COUNT(DISTINCT product_category_name)
  FROM products 
 
 ---------------------------------------------------------------------
  -- Qantos Clientes existem por estado?
 ---------------------------------------------------------------------
  
  Select *
  FROM customers 
Limit 10

-- para filtrar uma busca usa-se "Where", etão vamos ultilizar essa função
-- para filtrar os clientes de uma determinada região.

Select *
  FROM customers 
  WHERE customer_state = "SP"

  -- para realizar a contagem dos clientes usamos "COUNT" e para precisar mais ainda usa-se "DISTINCT" 

  SELECT COUNT(DISTINCT  customer_unique_id)
FROM customers 
WHERE customer_state = "SP"

-- "AS" é o comando que serve para mudar o nome da coluna 

 SELECT COUNT(DISTINCT  customer_unique_id) As numero_clientes
FROM customers 
WHERE customer_state = "SP"

 -- Para Agrupar Informações utilizamos o comando "Group By" da seguinte forma

Select *
 FROM customers 
  GROUP BY customer_state 
  
  -- utilizando para responder a pergunta
  
  Select 
  COUNT(DISTINCT  customer_unique_id) As numero_clientes
FROM customers 
Group By customer_state

-- observa-se que não ficou claro sobre qual estado cada numero representa para
-- resolver isso é só selecionar o nome da coluna seguido por virgula

Select customer_state AS UF	,
  COUNT(DISTINCT  customer_unique_id) As numero_clientes
FROM customers 
Group By customer_state

-- Para ordenar a tabela utilizamos a função "Order By" segudio pelo nome da coluna
-- a ser ordenada 

  Select customer_state AS UF	,
  COUNT(DISTINCT  customer_unique_id) As numero_clientes
FROM customers 
Group By customer_state
Order By numero_clientes

-- Por padrão automaticamente a tabela fica em ordem Crescente, para mudar esta ordem
-- usa-se "DESC" 

Select customer_state AS UF	,
  COUNT(DISTINCT  customer_unique_id) As numero_clientes
FROM customers 
Group By customer_state
Order By numero_clientes DESC 

-------------------------------------------------------------------------
-- Os valores das compras são diferentes entre as formas de pagamentos?
-------------------------------------------------------------------------

SELECT *
FROM order_payments 

-- para se obter uma média dos valores de compras utilizamos o codifo "AVG"

SELECT 
AVG(payment_value) 
FROM order_payments 

-- Para se obter o valor MAximo o codigo é "MAX"

SELECT 
MAX(payment_value) 
FROM order_payments 

-- Para se obter o valor Minimo é "MIM"

SELECT 
Min(payment_value) 
FROM order_payments 

-- também é possivel fazer tudo junto

SELECT 
AVG(payment_value) As Valor_Medio,
MAX(payment_value) As Valor_Maximo,
MIN(payment_value)  As Valor_Minimo
FROM order_payments 

-- Filtrando apenas um meio de pagamento

Select 
payment_type, 
AVG(payment_value) As Valor_Medio,
MAX(payment_value) As Valor_Maximo,
MIN(payment_value) As Valor_Minimo
FROM order_payments 
WHERE payment_type  = 'credit_card'  	

-- Agrupando todas as formas de pagamentos

Select 
payment_type, 
AVG(payment_value) As Valor_Medio,
MAX(payment_value) As Valor_Maximo,
MIN(payment_value) As Valor_Minimo
FROM order_payments 
GROUP By payment_type 

-- para saber o valor total de todos os meios de pagamentos existe a função "SUM"
-- que é a soma dos valores de determinado dado

Select 
payment_type, 
AVG(payment_value) As Valor_Medio,
MAX(payment_value) As Valor_Maximo,
MIN(payment_value) As Valor_Minimo,
Sum(payment_value) AS Valor_Total
FROM order_payments 
GROUP By payment_type 
ORDER BY payment_value DESC

-- uma dica legal para deixar os numeros mais inteiros é usar "/" para dividir 

Select 
payment_type, 
AVG(payment_value)  As Valor_Medio,
MAX(payment_value)  As Valor_Maximo,
MIN(payment_value)  As Valor_Minimo,
Sum(payment_value)/1000000 As Valor_Total
FROM order_payments 
GROUP By payment_type 
ORDER BY payment_value DESC

--------------------------------------------------------
-- Quantos clientes existem por região?
--------------------------------------------------------

--Suldeste

SELECT 
*
FROM customers 
WHERE customer_state = "SP"

-- Para adicionar mais de um dado no filtro utiliza-se "OR"

SELECT 
*
FROM customers c 
WHERE customer_state ="SP"
OR customer_state  = "MG"
Or customer_state = "RJ"
OR customer_state = "ES"

-- Separando os dados para obter o resultado total da região Sudeste

SELECT 
COUNT(DISTINCT customer_unique_id)
FROM customers c 
WHERE customer_state ="SP"
OR customer_state  = "MG"
Or customer_state = "RJ"
OR customer_state = "ES"

--Case WHEN cria uma nova coluna para determinados dados

SELECT 
*,
Case
	When customer_state == "SP"
			OR customer_state  = "MG"
			Or customer_state = "RJ"
			OR customer_state = "ES"	
		THEN "Sudeste"
	END AS Regiao
From customers 

-- uma forma de simplificar seria com o uso de "IN"

Select
*,
	CASE 
		WHEN customer_state IN ("SP","MG","RJ","ES")
			HEN "Sudeste"
		END AS Regiao
	From customers 
-- dessa forma não é preciso ficar repetindo "OR" 
	
	-- Realizando a Operação em todas as regiões 
	    -- OBS quando houver algum dado que não pertence a nenhuma categoria
	    -- Utiliza-se "ELSE"
	
	Select
	CASE 
		When customer_state IN ("MT","MS","DF","GO") THEN "Centro-Oeste"
		When customer_state IN ("SP","MG","RJ","ES") THEN "Sudeste"
		When customer_state IN ("AC","AM","AP","PA","RO","RR","TO") THEN "Norte"
		When customer_state IN ("AL","BA","CE","MA","PI","PE","PB","RN","SE") THEN "Nordeste"
		When customer_state IN ("PR","RS","SC") THEN "SUL"
		ELSE "Vazio"
	END AS Regiao,
	*
	From customers 
	LIMIT 10
	----------------------------------------------------------------------------
	
	Select
	CASE 
		When customer_state IN ("MT","MS","DF","GO") THEN "Centro-Oeste"
		When customer_state IN ("SP","MG","RJ","ES") THEN "Sudeste"
		When customer_state IN ("AC","AM","AP","PA","RO","RR","TO") THEN "Norte"
		When customer_state IN ("AL","BA","CE","MA","PI","PE","PB","RN","SE") THEN "Nordeste"
		When customer_state IN ("PR","RS","SC") THEN "SUL"
		ELSE "Vazio"
	END AS Regiao,
	COUNT(DISTINCT customer_unique_id) As numero_clientes
From customers
Group By Regiao 
Order By numero_clientes DESC

---------------------------------------------------------------------------------
-- Quanto é pago por cada forma diferente de pagamento?
---------------------------------------------------------------------------------

SELECT 
payment_type ,
SUM(payment_value ) As total_pagamento
  FROM order_payments
 Group By payment_type 
 ORDER BY total_pagamento DESC 

 --------------------------------------------------------------------------------
 -- Qual o Total de Pedidos Por Ano?
 --------------------------------------------------------------------------------
 
 
 ---------------------------------------------------------------------------------
 
