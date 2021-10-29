USE MASTER
GO

IF EXISTS(SELECT NAME FROM SYSDATABASES WHERE NAME IN('BDJardinPasitos'))
DROP DATABASE BDJardinPasitos
GO

CREATE DATABASE BDJardinPasitos
GO

USE BDJardinPasitos
GO
CREATE TABLE TipoDocumento
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nombre VARCHAR(50)
);

CREATE TABLE TipoAlumno
(
id INT IDENTITY(1,1)NOT NULL PRIMARY KEY,
nombre VARCHAR(20)
);
CREATE TABLE TipoPersonal
(
id INT IDENTITY(1,1)NOT NULL PRIMARY KEY,
nombre VARCHAR(20)
);
CREATE TABLE TipoPersona
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nombre VARCHAR(20)
);
CREATE TABLE TResponsable
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
tipoDocumento INT NOT NULL,
nroDocumento VARCHAR(8) NOT NULL,
fecha_Nacimiento DATETIME NOT NULL,
direccion VARCHAR(50) NOT NULL,
celular VARCHAR(10) NOT NULL,
ocupacion VARCHAR(50) NOT NULL,
tipoPersona INT NOT NULL,
CONSTRAINT fk_tipoPersona FOREIGN KEY(tipoPersona) REFERENCES TipoPersona(id),
CONSTRAINT fk_tipoDocumento FOREIGN KEY(tipoDocumento)REFERENCES TipoDocumento(id)
);

CREATE TABLE TInstitucionEducativa
(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
nombre VARCHAR(50) NOT NULL,
ruc VARCHAR(20) NOT NULL,
codigoIE VARCHAR(20) NOT NULL,
directora VARCHAR(20) NOT NULL
);

CREATE TABLE TPersonal
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
foto IMAGE,
fechaNacimiento DATETIME NOT NULL,
tipoDocumento INT NOT NULL,
institucioneducativa INT NOT NULL,
nroDocumento VARCHAR(20) NOT NULL,
direccion VARCHAR(50) NOT NULL,
celular VARCHAR(10) NOT NULL,
email VARCHAR(50) NOT NULL,
tipoPersonal INT NOT NULL
CONSTRAINT fk_tipoPersonal FOREIGN KEY(tipoPersonal)REFERENCES TipoPersonal(id),
CONSTRAINT fk_tipoDocumentoP FOREIGN KEY(tipoDocumento)REFERENCES TipoDocumento(id),
CONSTRAINT fk_institucionEducativa FOREIGN KEY(institucioneducativa)REFERENCES TInstitucionEducativa(id)
);

CREATE TABLE TAula
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
grado VARCHAR(20) NOT NULL,
seccion VARCHAR(20) NOT NULL,
capacidad INT NOT NULL,
idDocente INT NOT NULL,
CONSTRAINT fk_idDocente FOREIGN KEY(idDocente)REFERENCES TPersonal(id)
);
CREATE TABLE TPago
(
id INT IDENTITY(1,1)NOT NULL PRIMARY KEY,
nroBoleta VARCHAR(7) NOT NULL,
rucIE VARCHAR(20) NOT NULL,
fecha DATETIME NOT NULL,
concepto VARCHAR(15)NOT NULL,
monto DECIMAL(9,2) NOT NULL
);
--MODIFICAR ESTA MAL PLANTEADO
CREATE TABLE TPrivilegio
(
id INT IDENTITY(1,1)NOT NULL PRIMARY KEY,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE TUsuario
(
id INT IDENTITY(1,1)NOT NULL PRIMARY KEY,
usuario VARCHAR(20) NOT NULL,
contrasenia VARBINARY(500) NOT NULL,
personal INT NOT NULL,
privilegio INT NOT NULL,
CONSTRAINT fk_personal FOREIGN KEY(personal)REFERENCES TPersonal(id),
CONSTRAINT fk_privilegio FOREIGN KEY(privilegio)REFERENCES TPrivilegio(id)
);

CREATE TABLE TAlumno
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idResponsable INT,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
foto IMAGE,
tipo_Documento INT NOT NULL,
nro_Documento VARCHAR(8) NOT NULL,
fecha_Nacimiento DATETIME NOT NULL,
departamento VARCHAR(20) NOT NULL,
distrito VARCHAR(20) NOT NULL,
provincia VARCHAR(20) NOT NULL,
telefono VARCHAR(10) NOT NULL,
direccion VARCHAR(50) NOT NULL,
genero VARCHAR(50) NOT NULL,
tipoAlumno INT NOT NULL,
alegias VARCHAR(50) NOT NULL,
CONSTRAINT fk_idResponsable FOREIGN KEY(idResponsable)REFERENCES TResponsable(id),
CONSTRAINT fk_tipoAlumno FOREIGN KEY(tipoAlumno)REFERENCES TipoAlumno(id)
);

CREATE TABLE TMatricula
(
id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idAlumno INT NOT NULL,
idUsuRes INT NOT NULL,
idAula INT NOT NULL,
codModular VARCHAR(20) NOT NULL,
idpago INT NOT NULL,
CONSTRAINT fk_idUsuRes FOREIGN KEY (idUsuRes)REFERENCES TUsuario(id),
CONSTRAINT fk_idAula FOREIGN KEY(idAula)REFERENCES TAula(id),
CONSTRAINT fk_idPago FOREIGN KEY(idPago)REFERENCES TPago(id),
CONSTRAINT fk_alumno FOREIGN KEY(idAlumno)REFERENCES TAlumno(id)
);

CREATE TABLE TMensualidad
(
id INT IDENTITY(1,1)NOT NULL PRIMARY KEY,
nombreMes VARCHAR(20) NOT NULL,
monto DECIMAL(9,2)NOT NULL,
estado BIT NOT NULL,
idPago INT NOT NULL,
CONSTRAINT fk_idPagoM FOREIGN KEY (idPago) REFERENCES TPago(id)
);


