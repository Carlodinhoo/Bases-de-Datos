use banco
go

/**** OPERACIONES OLAP ****/

--Información en varios niveles de granularidad
create view olap as
select estado,nombresucursal,year(fecha) año,
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

--Cantidad de prestamos por año
select año,count(numprestamo)
from olap
group by año;

--Cantidad de prestamos por trimestre
select trimestre,count(numprestamo)
from olap
group by trimestre;

--Cantidad de prestamos por estado,sucursal
select estado,nombresucursal,count(numprestamo)
from olap
group by estado,nombresucursal
order by estado;

--Cantidad de prestamos por estado,sucursal,año
select estado,nombresucursal,año,count(numprestamo)
from olap
group by estado,nombresucursal,año
order by estado;

--Cantidad de prestamos por estado,sucursal,año,trimestre
select estado,nombresucursal,año,trimestre,count(numprestamo)
from olap
group by estado,nombresucursal,año,trimestre
order by estado;

--Cantidad de prestamos por estado,sucursal,año,trimestre,mes
select estado,nombresucursal,año,trimestre,mes,count(numprestamo)
from olap
group by estado,nombresucursal,año,trimestre,mes
order by estado;


--Hacer convivir más de un nivel de agregacion
--GROUPING SETS
--Aplicar la f. agregación en cada grupo
select estado,nombresucursal,año,trimestre,
       count(numprestamo)
from olap
group by grouping sets(estado,nombresucursal,
                       año,trimestre);

--Nivel de agregación en particular
select estado,nombresucursal,año,trimestre,
       count(numprestamo)
from olap
group by grouping sets((estado,nombresucursal),
                       año,trimestre);

--ROLL-UP
select estado,nombresucursal,año,trimestre,
       count(numprestamo)
from olap
group by rollup(estado,nombresucursal,
                año,trimestre);

--CUBE
select estado,nombresucursal,año,trimestre,
       count(numprestamo)
from olap
group by cube(estado,nombresucursal,
              año,trimestre);

--PIVOT
select estado,nombresucursal,año,trimestre,
       count(numprestamo) "total prestatarios"
from olap
group by estado,nombresucursal,año,trimestre;