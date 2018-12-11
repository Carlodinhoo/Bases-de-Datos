use MiBanquito;

--E5
SELECT *
FROM sucursal
WHERE nombresucursal like 'SAN%' and estado != 'CDMX'

--El campo nombreCliente, de la tabla Cliente esta formado por nombre apaterno amaterno 

--E6
SELECT *
FROM cliente
WHERE nombrecliente like '% % MOYA' and estado not in ('GUERRERO','TAMAULIPAS','SONORA')

--E7
SELECT *
FROM cliente
WHERE nombrecliente like '%ALONSO%' and direccion like '%SANT[AO]%'

--E8
SELECT nombrecliente,estado,nacimiento
FROM cliente
WHERE nombrecliente like '% ALONSO %' and (direccion like '%MZNA%' or direccion like '%MANZANA%')


--E9
SELECT *
FROM sucursal
WHERE nombresucursal like '%[NOSZ]' and estado like '[A-DHLO-T]%'

--E10
SELECT *
FROM cliente
WHERE nombrecliente like '% % [ACDN-R]%[^ONRSZ]'




