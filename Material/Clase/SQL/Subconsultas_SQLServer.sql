use banco
go

/*** SUBCONSULTAS EN SQL SERVER ***/
--Consulta dentro de otra consulta (Hasta 32 niveles de anidamiento)

/*
OPERADORES PARA PRODUCIR UN VALOR BOOLENO

Sea s un valor o una tupla y R una relación (tabla)

1. s IN R
2. s > ANY R (s > SOME R) --> El operador de comparación puede ser: >,<,>=,<=,<>
3. s > ALL R
4. EXISTS R

Podemos utilizar los operadores negados
1. s NOT IN r
2. NOT s > ANY (SOME) R
3. NOT s > ALL R
4. NOT EXISTS R
*/

--Ejercicio 31
select distinct a.idcliente,nombrecliente
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
where a.idcliente in (select idcliente
                      from prestatario)
order by 2;

--Ejercicio 32
select nombrecliente
from prestatario a inner join cliente b on
     a.idcliente = b.idcliente
where nombrecliente not in ('%HERNÁNDEZ%','%PÉREZ%');
--Problemas porque funciona como un OR

--Una forma de hacerlo
select nombrecliente
from prestatario a inner join cliente b on
     a.idcliente = b.idcliente 
where nombrecliente not like '%HERNÁNDEZ%'
except
select nombrecliente
from prestatario a inner join cliente b on
     a.idcliente = b.idcliente 
where nombrecliente like '%PÉREZ%'

--Ejercicio 33
select nombrecliente
from ctacliente a inner join cliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = a.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
	 and nombresucursal = 'CUAJIMALPA'
where nombrecliente in
(select nombrecliente
from prestatario a inner join cliente b on
     a.idcliente = b.idcliente
	 inner join prestamo c on c.numprestamo = a.numprestamo
	 inner join sucursal d on d.numsucursal = c.numsucursal
	 and nombresucursal = 'CUAJIMALPA')

--Saber que clientes tienen prestamo y cuenta en la misma suc
select nombrecliente,a.numcta,d.numprestamo,f.nombresucursal
from ctacliente a inner join prestatario b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = a.numcta
	 inner join prestamo d on d.numprestamo = b.numprestamo
	 inner join sucursal e on e.numsucursal = c.numsucursal
	 inner join sucursal f on f.numsucursal = d.numsucursal
	 and f.numsucursal = e.numsucursal
	 inner join cliente g on g.idcliente = a.idcliente
order by nombresucursal;

--Ejercicio 34
select distinct nombrecliente
from cliente a inner join prestatario b on
     a.idcliente = b.idcliente
where b.idcliente not in (select idcliente
                          from ctacliente);

--Ejercicio 35
select DISTINCT nombresucursal
from sucursal
where activo > any (select activo 
                    from sucursal
					where estado = 'SONORA');

--También se puede usar some
select DISTINCT nombresucursal
from sucursal
where activo > SOME (select activo 
                    from sucursal
					where estado = 'SONORA');

--Ejercicio 36
select distinct nombrecliente
from cliente a inner join prestatario b on
     a.idcliente = b.idcliente
where exists (select *
              from ctacliente
			  where idcliente = b.idcliente);

--Ejercicio 37
select nombresucursal,avg(saldo)
from cuenta a inner join sucursal b on
     a.numsucursal = b.numsucursal
group by nombresucursal
having avg(saldo) >= all(select avg(saldo)
                         from cuenta
						 group by numsucursal);

						
declare @saldoprom money

select @saldoprom = max(saldoprom)
from (select avg(saldo) saldoprom
      from cuenta
	  group by numsucursal) res;

select nombresucursal,avg(saldo)
from cuenta a inner join sucursal b on
     a.numsucursal = b.numsucursal
group by nombresucursal
having avg(saldo) = @saldoprom

--Ejercicio 38
select distinct nombrecliente
from ctacliente a inner join cliente b on
     a.idcliente = b.idcliente
where not exists(
(select nombresucursal
from sucursal where estado = 'guanajuato')
except
(select nombresucursal
from ctacliente c inner join cuenta d on
     c.numcta = d.numcta
	 inner join sucursal e on e.numsucursal = d.numsucursal
where idcliente = a.idcliente)
) 