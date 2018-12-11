use MiBanquito
--E28 
select estado,nombresucursal,DATEPART(yy,fecha) as Anio,DATEPART(QUARTER,fecha) as Trimestre,count(a.numprestamo) as total_prestatario, avg(a.importe) as prestamo_promedio
FROM Prestamo a inner join sucursal b on a.numsucursal = b.numsucursal
group by estado,nombresucursal,DATEPART(yy,fecha),DATEPART(QUARTER,fecha)

--Obtener todos los prestamos que ya hayan sido pagadados
select a.numprestamo,MAX(a.importe) importe, SUM(b.pago) as total_pagos
FROM Prestamo a JOIN Pagos b ON a.numprestamo = b.numprestamo
GROUP BY a.numprestamo
HAVING SUM(b.pago) >= MAX(a.importe)


--Por cada mes del anio 2014, Obten las sucursales que la suma de los pagos de sus prestamos sea mayor a 7500

SELECT '2014' as anio,DATEPART(mm,a.fecha) as mes,b.nombresucursal,sum(c.pago) as pagos_recibidos
FROM (Prestamo a INNER JOIN Sucursal b ON a.numsucursal = b.numsucursal) INNER JOIN Pagos c ON a.numprestamo = c.numprestamo
WHERE DATEPART(yy,a.fecha) = 2014
GROUP BY DATEPART(mm,a.fecha),b.nombresucursal
HAVING sum(c.pago) > 7500
ORDER BY mes


--E29

--Total Cuentahabientes
select estado,nombresucursal,DATEPART(yy,fecha) as Anio,DATEPART(QUARTER,fecha) as Trimestre,count(a.numcta) as total_cuentahabientes
FROM Cuenta a inner join sucursal b on a.numsucursal = b.numsucursal
group by estado,nombresucursal,DATEPART(yy,fecha),DATEPART(QUARTER,fecha)
having count(a.numcta) > 6 

--Total de prestatarios

select estado,nombresucursal,DATEPART(yy,fecha) as Anio,DATEPART(QUARTER,fecha) as Trimestre,count(a.numprestamo) as total_prestatario
FROM Prestamo a inner join sucursal b on a.numsucursal = b.numsucursal
group by estado,nombresucursal,DATEPART(yy,fecha),DATEPART(QUARTER,fecha)

--UNION de las anteriores consultas

SELECT a.estado,a.nombresucursal,a.Anio,a.Trimestre,a.total_cuentahabientes,b.total_prestatario
FROM 
(select estado,nombresucursal,DATEPART(yy,fecha) as Anio,DATEPART(QUARTER,fecha) as Trimestre,count(a.numcta) as total_cuentahabientes
FROM Cuenta a inner join sucursal b on a.numsucursal = b.numsucursal
group by estado,nombresucursal,DATEPART(yy,fecha),DATEPART(QUARTER,fecha)
having count(a.numcta) > 6 ) as a
LEFT JOIN
(select estado,nombresucursal,DATEPART(yy,fecha) as Anio,DATEPART(QUARTER,fecha) as Trimestre,count(a.numprestamo) as total_prestatario
FROM Prestamo a inner join sucursal b on a.numsucursal = b.numsucursal
group by estado,nombresucursal,DATEPART(yy,fecha),DATEPART(QUARTER,fecha)) as b
ON a.estado = b.estado and a.nombresucursal = b.nombresucursal and a.Anio = b.Anio and a.Trimestre = b.Trimestre 


--E30
select b.idcliente,avg(c.saldo) as saldo_promedio
FROM (Cliente a inner join ctacliente b on a.idcliente = b.idcliente ) INNER JOIN cuenta c on  b.numcta = c.numcta
WHERE estado ='CHIAPAS'
group by b.idcliente
having COUNT(b.numcta) >= 3

--E38 Por cuenta
select a.idcliente,a.nombrecliente,a.direccion,a.estado,a.nacimiento,c.saldo,
	CASE 
		WHEN c.saldo BETWEEN 10000 and 19999 THEN 'Tarjeta clàsica'
		WHEN c.saldo BETWEEN 20000 and 35000 THEN 'Tarjeta oro'
		WHEN c.saldo BETWEEN 35000 and 50000 THEN 'Tarjeta premium'
		WHEN c.saldo> 50000 THEN 'Tarjeta platinum'
	END as tipo_tarjeta
FROM (Cliente a inner join ctacliente b on a.idcliente = b.idcliente ) INNER JOIN cuenta c on  b.numcta = c.numcta
where c.saldo >=10000



--E38
--Por cliente, es decir acumulando su saldo de las distintas 
select d.idcliente,d.nombrecliente,d.direccion,d.estado,d.nacimiento,e.total,e.tipo_tarjeta
FROM (
	select b.idcliente as id_cliente,SUM(c.saldo) as total,
		CASE 
			WHEN SUM(c.saldo) BETWEEN 10000 and 19999 THEN 'Tarjeta clàsica'
			WHEN SUM(c.saldo) BETWEEN 20000 and 35000 THEN 'Tarjeta oro'
			WHEN SUM(c.saldo) BETWEEN 35000 and 50000 THEN 'Tarjeta premium'
			WHEN SUM(c.saldo)> 50000 THEN 'Tarjeta platinum'
	END as tipo_tarjeta
	FROM (Cliente a inner join ctacliente b on a.idcliente = b.idcliente ) INNER JOIN cuenta c on  b.numcta = c.numcta
	where c.saldo >=10000
	group by b.idcliente) as e INNER JOIN Cliente d ON e.id_cliente = d.idcliente

