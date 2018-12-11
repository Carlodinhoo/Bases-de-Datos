--Cursores en SQL Server
--Declaración
declare micursor cursor --local| global | scroll
for select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal;

--Abrir el cursor
open micursor;

--Navegar en el cursor
fetch next from micursor; --next | prior | last | first

--cerrar el cursor
close micursor;

--liberar de memoria
deallocate micursor;

--Ejemplo 2: Recuperar más de una fila

--Declaración
declare @cliente varchar(100),
        @cta char(7),
		@saldo money,
		@fecha date,
		@sucursal varchar(100);

declare micursor cursor for
select top 10 nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
	 where d.estado = 'durango';

--Abrir el cursor
open micursor;

--Navegar en el cursor
fetch micursor into @cliente,@cta,@saldo,@fecha,@sucursal
while(@@fetch_status = 0)
begin
print @cliente + ',' + @cta + ',' + format(@saldo,'c','en-us') + ',' +
      convert(char(8),@fecha,1) + ',' + @sucursal
fetch micursor into @cliente,@cta,@saldo,@fecha,@sucursal
end

--cerrar el cursor
close micursor;

--liberar de memoria
deallocate micursor;

--Son muuuuuuy lentos --> lo mejor es no utilizarlos