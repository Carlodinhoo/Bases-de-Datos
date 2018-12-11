IF EXISTS (select * from sysdatabases where name = 'Pruebas')
DROP DATABASE Pruebas
GO
CREATE DATABASE Pruebas;
GO
USE Pruebas
GO
CREATE SCHEMA Laboratorio;
GO

CREATE TABLE Pruebas.Laboratorio.Domicilio(
	id_domicilio	int primary key,
	calle			varchar(50),
	numero			numeric(10,2),
	colonia			varchar(30),
	cp				char
);

CREATE TABLE Laboratorio.Persona(
	rfc 			varchar(13) primary key,
	nombre			varchar(30) not null,
	ap_paterno		varchar(30),
	ap_materno		varchar(30),
	f_nacimiento	date ,
	id_domicilio	int foreign key references Laboratorio.Domicilio(id_domicilio)
);

GO

ALTER TABLE Laboratorio.Domicilio add CONSTRAINT ck_numero_domicilio CHECK (numero > 0 AND numero < 101);
--ALTER TABLE Laboratorio.Domicilio add CONSTRAINT ck_cp CHECK (cp LIKE '[0-9][0-9][0-9][0-9][0-9]');
--ALTER TABLE Laboratorio.Persona add CONSTRAINT ck_rfc CHECK (rfc LIKE '[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][A-Z0-9][A-Z0-9][A-Z0-9]');

---SELECT * FROM Pruebas.INFORMATION_SCHEMA.[TABLES]

--SELECT * FROM Pruebas.INFORMATION_SCHEMA.[COLUMNS] where table_name = 'domicilio'