CREATE DATABASE estudiantes;

CREATE TABLE ciudades(
	codigo INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(40) NOT NULL
);

INSERT INTO ciudades 
VALUES
	(20,'CALI'),
	(22,'FUSAGASUGA');

CREATE TABLE alumnos(
	codigo SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(20) NOT NULL,
	edad INTEGER NOT NULL,
	codigo_ciudad INTEGER REFERENCES ciudades(codigo),
	codigo_programa INTEGER REFERENCES programas(codigo)
);

INSERT INTO alumnos (nombre,edad,codigo_ciudad,codigo_programa) 
VALUES
	('ALEJANDRA',16,20,1),
	('ANDREA',18,20,1),
	('CRISTIAN',36,22,2);

CREATE TABLE programas(
	codigo SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(40) NOT NULL,
);

INSERT INTO programas (nombre)
VALUES
	('SISTEMAS'),
	('ELECTRONICA'),
	('AGRONOMIA'),
	('AMBIENTAL');

SELECT * FROM estudiantes WHERE codigo_programa=1;