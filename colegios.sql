CREATE DATABASE colegios;

CREATE TABLE colegios(
	colegio_id SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR (20) NOT NULL
);

INSERT INTO colegios (nombre)
VALUES
	('C.P. Cervantes'),
	('C.P. Quevedo');

CREATE TABLE aulas(
	aula_id  VARCHAR(6) NOT NULL,
	capacidad INTEGER NOT NULL,
	colegio_id INTEGER REFERENCES colegios(colegio_id),
	PRIMARY KEY (aula_id,colegio_id)
);

INSERT INTO aulas
VALUES
	('1.A01',40,1),
	('1.B01',20,1),
	('2.B01',20,2);

CREATE TABLE profesores(
	profesor_id VARCHAR(11) NOT NULL,
	primer_nombre VARCHAR(30) NOT NULL,
	segundo_nombre VARCHAR(30) DEFAULT '---',
	primer_apellido VARCHAR(30) NOT NULL,
	segundo_apellido VARCHAR(30) DEFAULT '---',
	aula_id VARCHAR(6) REFERENCES aulas(aula_id),
	PRIMARY KEY (profesor_id,aula_id)
);

INSERT INTO profesores
VALUES
	('10','JUAN','','PÉREZ','','1.A01'),
	('11','ALICIA','','GARCIA','','1.B01'),
	('12','ANDRÉS','','FERNÁNDEZ','','1.A01'),
	('13','JUAN','','PÉREZ','','2.B01');

CREATE TABLE asignaturas(
	asignatura_id SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(40) NOT NULL,
	curso VARCHAR(2) NOT NULL
);

INSERT INTO asignaturas (nombre,curso)
VALUES
	('Pensamiento lógico','1'),
	('Escritura','1'),
	('Pensamiento numérico','1'),
	('Pensamiento espacial, temporal y causal','1'),
	('Escritura II','2'),
	('Inglés','2');

CREATE TABLE profesores_asignaturas(
	asignatura_id VARCHAR(40) REFERENCES asignaturas(asignatura_id),
	profesor_id VARCHAR(11) REFERENCES profesores(profesor_id),
	PRIMARY KEY (asignatura_id,profesor_id)
);

INSERT INTO profesores_asignaturas
VALUES
	('10',1),
	('10',2),
	('10',3),
	('11',4),
	('11',3),
	('12',5),
	('12',6),
	('13',1),
	('13',3);

CREATE TABLE editoriales(
	editorial_id SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR (15) NOT NULL
);

INSERT INTO editoriales (nombre)
VALUES
	('GRAÓ'),
	('TÉCNICAS RUBIO'),
	('PRENTINCE HALL'),
	('TEMAS DE HOY');

CREATE TABLE libros(
	libro_id SERIAL NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	editorial_id INTEGER REFERENCES editoriales(editorial_id),
	PRIMARY KEY (libro_id,editorial_id)
);

INSERT INTO libros (nombre,editorial_id)
VALUES
	('APRENEDER Y ENSEÑAR EN EDUCACIÓN INFANTIL',1),


CREATE TABLE profesores_libros(
	profesor_id VARCHAR(11) REFERENCES profesores(profesor_id),
	libro_id INTEGER REFERENCES libros(libro_id),
	fecha_prestamo DATE NOT NULL,
	PRIMARY KEY (profesor_id,libro_id,fecha_prestamo) 
);
