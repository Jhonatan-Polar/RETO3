/*
NOMBRE: JHONATAN CUEVA
*/

CREATE OR REPLACE VIEW V_NO_FACTURADO AS
SELECT CLIENTES.*
FROM PEDIDOS
INNER JOIN CLIENTES 
ON PEDIDOS.COD_CLIE = CLIENTES.COD_CLIE
WHERE VAL_ESTA_PEDI <> 'FACTURADO';

CREATE OR REPLACE VIEW V_NO_CLIENTE AS
SELECT PEDIDOS.*
FROM PEDIDOS
INNER JOIN CLIENTES 
ON PEDIDOS.COD_CLIE <> CLIENTES.COD_CLIE;

CREATE OR REPLACE VIEW V_ACUMULADO AS
SELECT PEDIDOS.VAL_ESTA_PEDI,PEDIDOS.COD_REGI,SUM(PEDIDOS.VAL_MONT_SOLI) ACUMULADO
FROM PEDIDOS
INNER JOIN CLIENTES 
ON PEDIDOS.COD_CLIE = CLIENTES.COD_CLIE
WHERE PEDIDOS.VAL_ESTA_PEDI = 'FACTURADO' AND EXTRACT(MONTH FROM PEDIDOS.FEC_FACT) = 6
GROUP BY PEDIDOS.VAL_ESTA_PEDI,PEDIDOS.COD_REGI;

CREATE OR REPLACE VIEW V_TOTAL_AGRUP AS
SELECT PEDIDOS.VAL_ESTA_PEDI,PEDIDOS.COD_REGI,SUM(PEDIDOS.VAL_MONT_SOLI) ACUMULADO, COUNT(*) CANTIDAD 
FROM PEDIDOS
INNER JOIN CLIENTES 
ON PEDIDOS.COD_CLIE = CLIENTES.COD_CLIE
WHERE PEDIDOS.VAL_ESTA_PEDI = 'FACTURADO' AND EXTRACT(MONTH FROM PEDIDOS.FEC_FACT) = 6
GROUP BY PEDIDOS.VAL_ESTA_PEDI,PEDIDOS.COD_REGI
HAVING COUNT(*) > 500;