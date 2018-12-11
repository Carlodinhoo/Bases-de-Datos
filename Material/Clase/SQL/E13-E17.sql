use MiBanquito;

--E13
SELECT DATENAME(YEAR,nacimiento) as año,DATENAME(MONTH,nacimiento) as mes,DATENAME(DAY,nacimiento) as dia
,DATENAME(DAYOFYEAR,nacimiento) as dia_año,DATENAME(WEEKDAY,nacimiento) as dia_semana,DATENAME(WK,nacimiento) as semana
FROM cliente;

--E14
SELECT DATEPART(yy,nacimiento) as anio,DATEPART(mm,nacimiento) as mes,DATEPART(d,nacimiento) as dia
,DATEPART(dy,nacimiento) as dia_año,DATEPART(dw,nacimiento) as dia_semana,DATEPART(wk,nacimiento) as semana
FROM cliente;

--E15
SELECT YEAR(nacimiento) as anio,MONTH(nacimiento) as mes,DAY(nacimiento) as dia
FROM cliente;


--E16
SELECT GETDATE() as hoy,fecha,DATEDIFF(d,fecha,GETDATE()) as diff_dias,DATEDIFF(m,fecha,GETDATE()) as diff_mes,DATEDIFF(yy,fecha,GETDATE()) as diff_anio
FROM cuenta

--E17
SELECT fecha,DATEADD(yy,5,fecha) as cambia_anio,DATEADD(d,-10,fecha) as cambia_dia,DATEADD(m,11,fecha) as cambia_mes
FROM prestamo

--Edad de los clientes
SELECT DATEDIFF(yy,nacimiento,GETDATE()) as edad,*
FROM cliente

--El cliente cumple años el dia de hoy.
SELECT *
FROM cliente
WHERE DATEPART(d,nacimiento) = DATEPART(d,GETDATE()) and DATEPART(m,nacimiento) = DATEPART(m,GETDATE()) 