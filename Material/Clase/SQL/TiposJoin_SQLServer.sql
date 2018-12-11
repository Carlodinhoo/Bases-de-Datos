/*
****FUNDAMENTOS DE BASES DE DATOS*****
Ejercicios de SQL
M.I. Gerardo Avilés Rosas

TIPOS DE JOIN EN SQL SERVER:

INNER JOIN, JOIN, LEFT JOIN, RIGHT JOIN, LEFT OUTER JOIN,
RIGHT OUTER JOIN, CROSS JOIN, SELF JOIN
*/

--INNER JOIN
select nombrecliente,c.numcta,convert(date,nacimiento) as nacimiento,
       cast(fecha as date) as fecha,saldo
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
     inner join cuenta c on c.numcta = b.numcta;

--JOIN
select nombrecliente,c.numcta,convert(date,nacimiento) as nacimiento,
       cast(fecha as date) as fecha,saldo
from cliente a join ctacliente b on a.idcliente = b.idcliente
     join cuenta c on c.numcta = b.numcta;

--JOIN EXTERNOS: IZQUIERDA, DERECHA Y COMPLETO

--Nombre de los clientes que tienen cuenta y prestamo o solo cuenta
select a.idcliente,numcta,numprestamo
from ctacliente a left outer join prestatario b 
     on a.idcliente = b.idcliente;

--Clientes que estan en ambas tablas
select a.idcliente,numcta,numprestamo,nombrecliente
from ctacliente a left outer join prestatario b 
     on a.idcliente = b.idcliente
	 inner join cliente c on c.idcliente = a.idcliente
where numprestamo is not null;

--Clientes que estan solo en la tabla ctacliente
select a.idcliente,numcta,numprestamo
from ctacliente a left outer join prestatario b 
     on a.idcliente = b.idcliente
where numprestamo is null;

--Clientes que tienen prestamo y cuenta o solo prestamo
select b.idcliente,numcta,numprestamo
from ctacliente a right outer join prestatario b 
     on a.idcliente = b.idcliente
where numcta is null;

--JOIN EXTERNO COMPLETO
select a.idcliente,b.idcliente,numcta,numprestamo
from ctacliente a full outer join prestatario b 
     on a.idcliente = b.idcliente;

/*
RIGHT OUTER JOIN = RIGHT JOIN
LEFT OUTER JOIN = LEFT JOIN
*/

--CROSS JOIN
select *
from
(select nombresucursal
from sucursal where estado = 'chiapas') a
cross join
(select nombresucursal
from sucursal where estado = 'guanajuato') b;