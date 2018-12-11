use banco
go

/**** OPERACIONES OLAP ****/

--Informaci�n en varios niveles de granularidad
create view olap as
select estado,nombresucursal,year(fecha) a�o,
       datepart(quarter,fecha) trimestre,
	   datepart(month,fecha) mes,
	   datename(month,fecha) nmes,
	   numprestamo,importe
from prestamo a inner join sucursal b on
     a.numsucursal = b.numsucursal

select * from olap;

--Obtener la cantidad de prestamos en el banco
select count(numprestamo)
from olap;

--Obtener la cantidad de prestamos por estado
select estado,count(numprestamo)
from olap
group by estado;

--Cantidad de prestamos por a�o
select a�o,count(numprestamo)
from olap
group by a�o;

--Cantidad de prestamos por trimestre
select trimestre,count(numprestamo)
from olap
group by trimestre;

--Cantidad de prestamos por estado,sucursal
select estado,nombresucursal,count(numprestamo)
from olap
group by estado,nombresucursal
order by estado;

--Cantidad de prestamos por estado,sucursal,a�o
select estado,nombresucursal,a�o,count(numprestamo)
from olap
group by estado,nombresucursal,a�o
order by estado;

--Cantidad de prestamos por estado,sucursal,a�o,trimestre
select estado,nombresucursal,a�o,trimestre,count(numprestamo)
from olap
group by estado,nombresucursal,a�o,trimestre
order by estado;

--Cantidad de prestamos por estado,sucursal,a�o,trimestre,mes
select estado,nombresucursal,a�o,trimestre,mes,count(numprestamo)
from olap
group by estado,nombresucursal,a�o,trimestre,mes
order by estado;


--Hacer convivir m�s de un nivel de agregacion
--GROUPING SETS
--Aplicar la f. agregaci�n en cada grupo
select estado,nombresucursal,a�o,trimestre,
       count(numprestamo)
from olap
group by grouping sets(estado,nombresucursal,
                       a�o,trimestre);

--Nivel de agregaci�n en particular
select estado,nombresucursal,a�o,trimestre,
       count(numprestamo)
from olap
group by grouping sets((estado,nombresucursal),
                       a�o,trimestre);

--ROLL-UP
select estado,nombresucursal,a�o,trimestre,
       count(numprestamo)
from olap
group by rollup(estado,nombresucursal,
                a�o,trimestre);

--CUBE
select estado,nombresucursal,a�o,trimestre,
       count(numprestamo)
from olap
group by cube(estado,nombresucursal,
              a�o,trimestre);

--PIVOT
select estado,nombresucursal,a�o,trimestre,
       count(numprestamo) "total prestatarios"
from olap
group by estado,nombresucursal,a�o,trimestre;