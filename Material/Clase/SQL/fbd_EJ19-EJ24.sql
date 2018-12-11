/*
****FUNDAMENTOS DE BASES DE DATOS*****
Ejercicios de SQL
M.I. Gerardo Avilés Rosas

Ejercicios 18 al 24
*/

--E18
select nombrecliente,b.numprestamo,importe,
       convert(date,fecha) as fecha,
	   datename(quarter,fecha) as trimestre
from prestatario a,prestamo b,cliente c
where a.numprestamo = b.numprestamo and
      a.idcliente = c.idcliente and
      datename(year,fecha) in (2013,2014) and
	  datename(qq,fecha) in (1,3);

--E18.1: ordenando la presentación del resultado
select nombrecliente,b.numprestamo,importe,
       convert(date,fecha) as fecha,
	   datename(quarter,fecha) as trimestre
from prestatario a,prestamo b,cliente c
where a.numprestamo = b.numprestamo and
      a.idcliente = c.idcliente and
      datename(year,fecha) in (2013,2014) and
	  datename(qq,fecha) in (1,3)
order by trimestre desc;

--E18.2: ordenando por más de un atributo
select nombrecliente,b.numprestamo,importe,
       convert(date,fecha) as fecha,
	   datename(quarter,fecha) as trimestre
from prestatario a,prestamo b,cliente c
where a.numprestamo = b.numprestamo and
      a.idcliente = c.idcliente and
      datename(year,fecha) in (2013,2014) and
	  datename(qq,fecha) in (1,3)
order by 5 desc,datename(year,fecha) desc,
         importe asc;

--E19
select a.*,datename(yy,fecha),datename(m,fecha),
       datename(w,fecha) 
from cuenta a,sucursal b
where a.numsucursal = b.numsucursal and
      estado in ('michoacán','quintana roo','yucatán')
	  and datename(yy,fecha) between 2013 and 2015
	  and datename(m,fecha) in ('enero','abril',
	                            'julio','octubre')
      and datename(w,fecha) in ('lunes','miércoles',
	                            'viernes');

--Ej20.1: Esta consulta encuentra los clientes que nacieron el mismo día
select distinct a.idcliente,a.nombrecliente,convert(char(12),a.nacimiento,0) nacimiento
from cliente a join cliente b on a.nacimiento = b.nacimiento and a.idcliente <> b.idcliente
order by nacimiento;

--Ej20.2:
select distinct a.idcliente,a.nombrecliente,convert(char(12),a.nacimiento,0) nacimiento,
       d.*
from cliente a join cliente b on a.nacimiento = b.nacimiento and a.idcliente <> b.idcliente
     inner join ctacliente c on  a.idcliente = c.idcliente
     inner join cuenta d on c.numcta = d.numcta
where year(fecha) = 2013 and datepart(qq,fecha) in (2,4)
order by nacimiento;

--Ej21.1: Esta consulta encuentra los clientes que son homónimos
select distinct a.idcliente,a.nombrecliente,convert(char(12),a.nacimiento,0) nacimiento
from cliente a join cliente b on a.nombrecliente = b.nombrecliente and a.idcliente <> b.idcliente
order by nombrecliente;

--Ej21.2:
select distinct a.idcliente,a.nombrecliente,convert(char(12),a.nacimiento,0) nacimiento,
       d.*
from cliente a join cliente b on a.nombrecliente = b.nombrecliente and a.idcliente <> b.idcliente
     inner join prestatario c on  a.idcliente = c.idcliente
     inner join prestamo d on c.numprestamo = d.numprestamo
where importe between 10000 and 60000 and year(fecha) between 2012 and 2015 and
      datename(month,fecha) = 'junio'
order by nombrecliente;

--E22: UNION
select nombrecliente,numcta
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
union
select nombrecliente,numprestamo
from cliente a inner join prestatario b on a.idcliente = b.idcliente
order by 2 desc; --Ordenar por posicion de las columnas

--E22.1: UNION ALL, manetniendo los valores duplicados
select nombrecliente
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
union all
select nombrecliente
from cliente a inner join prestatario b on a.idcliente = b.idcliente;

--E23: EXCEPT
select nombrecliente
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
except
select nombrecliente
from cliente a inner join prestatario b on a.idcliente = b.idcliente;

--E23.1: EXCEPT, obtener además el número de cuenta
select nombrecliente,numcta
from ctacliente a inner join
(
select nombrecliente,a.idcliente
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
except
select nombrecliente,a.idcliente
from cliente a inner join prestatario b on a.idcliente = b.idcliente
) b on b.idcliente = a.idcliente;

--E24: INTERSECT
select nombrecliente
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
intersect
select nombrecliente
from cliente a inner join prestatario b on a.idcliente = b.idcliente;