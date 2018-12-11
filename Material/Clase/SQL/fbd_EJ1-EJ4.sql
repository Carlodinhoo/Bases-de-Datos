/*
****FUNDAMENTOS DE BASES DE DATOS*****
Ejercicios de SQL
M.I. Gerardo Avilés Rosas
*/
--E1
select *
from cliente
where estado = 'chihuahua' or estado = 'chiapas' or estado = 'hidalgo' or
      estado = 'jalisco' or estado = 'oaxaca';

--E1: verisión 2, utilizando IN
select *
from cliente
where estado in ('chihuahua','chiapas','hidalgo','jalisco','oaxaca');

--E2
select *
from prestamo
where numsucursal in (1,128,109,41,39,110) and importe > 40000;

--E3
select * 
from cuenta
where (saldo >= 16000 and saldo <= 58000) and
      numsucursal in (62,171,173);

--E3: versión 2, utilizando BETWEEN
select * 
from cuenta
where saldo between 16000 and 58000 and numsucursal in (62,171,173);

--E4
select *
from cuenta
where saldo >= 100000 and (fecha >= '01-01-2013' and fecha <= '31/03/2013') or
      saldo > 65 and saldo < 85000 and numsucursal in (55,164,63);

--E4: versión 2, utilizando BETWEEN
select *
from cuenta
where saldo >= 100000 and fecha between '01-01-2013' and '31/03/2013' or
      saldo > 65 and saldo < 85000 and numsucursal in (55,164,63);

--E4: versión 3, utilizando DATEPART
select *
from cuenta
where saldo >= 100000 and datepart(year,fecha) = 2013 and datepart(qq,fecha) = 1 or
      saldo > 65 and saldo < 85000 and numsucursal in (55,164,63);