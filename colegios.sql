### AUTHOR: YOJAN ANTONIO PARDO ZABALA ###
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
	aula_id  VARCHAR(6) PRIMARY KEY NOT NULL,
	capacidad INTEGER NOT NULL,
	colegio_id INTEGER REFERENCES colegios(colegio_id)
);

INSERT INTO aulas
VALUES
	('1.A01',40,1),
	('1.B01',20,1),
	('2.B01',20,2);

CREATE TABLE profesores(
	profesor_id VARCHAR(11) PRIMARY KEY NOT NULL,
	primer_nombre VARCHAR(30) NOT NULL,
	segundo_nombre VARCHAR(30) DEFAULT '---',
	primer_apellido VARCHAR(30) NOT NULL,
	segundo_apellido VARCHAR(30) DEFAULT '---',
	aula_id VARCHAR(6) REFERENCES aulas(aula_id)
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
	asignatura_id INTEGER REFERENCES asignaturas(asignatura_id),
	profesor_id VARCHAR(11) REFERENCES profesores(profesor_id),
	PRIMARY KEY (asignatura_id,profesor_id)
);

INSERT INTO profesores_asignaturas (profesor_id,asignatura_id)
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
	PRIMARY KEY (libro_id)
);

INSERT INTO libros (nombre,editorial_id)
VALUES
	('APRENEDER Y ENSEÑAR EN EDUCACIÓN INFANTIL',1),
	('PREESCOLAR RUBIO. N6',2),
	('EDUCACIÓN INFANTIL. N9',1),
	('SABER EDUCAR: GUIA PARA PADRES Y PROFESORES',4);


CREATE TABLE profesores_libros(
	prestamo_id SERIAL NOT NULL,
	profesor_id VARCHAR(11) REFERENCES profesores(profesor_id),
	libro_id INTEGER REFERENCES libros(libro_id),
	fecha_prestamo DATE NOT NULL,
	PRIMARY KEY (profesor_id,libro_id,prestamo_id) 
);

INSERT INTO profesores_libros (profesor_id,libro_id,fecha_prestamo)
VALUES
	('10',1,'2006/09/09'),
	('10',2,'2005/05/05'),
	('11',3,'2005/05/05'),
	('11',1,'2005/05/06'),
	('12',1,'2005/05/06'),
	('12',4,'2006/09/09'),
	('13',4,'2006/12/18'),
	('13',1,'2005/05/06');


###SECCIÓN DE CONSULTAS###

SELECT aula_id,capacidad,colegios.nombre
FROM aulas,colegios
WHERE colegios.colegio_id=aulas.colegio_id;

SELECT profesores.primer_nombre,profesores.primer_apellido,colegios.nombre
FROM profesores,colegios,aulas
WHERE colegios.colegio_id=2 AND colegios.colegio_id=aulas.colegio_id AND profesores.aula_id=aulas.aula_id;

SELECT profesores.primer_nombre, profesores.primer_apellido, asignaturas.nombre
FROM profesores, asignaturas, profesores_asignaturas
WHERE profesores_asignaturas.profesor_id='10' AND profesores_asignaturas.asignatura_id=asignaturas.asignatura_id AND profesores_asignaturas.profesor_id=profesores.profesor_id; 

SELECT profesores.primer_nombre, profesores.primer_apellido
FROM profesores
WHERE primer_nombre LIKE 'A%';

#TALLER OCTUBRE#S

SELECT asignaturas.nombre, asignaturas.asignatura_id, asignaturas.curso
FROM asignaturas
WHERE curso='1' ORDER BY nombre;

SELECT profesores.primer_nombre, profesores.profesor_id
FROM profesores
WHERE profesores.aula_id='1.A01' ORDER BY profesores.primer_nombre;

#este esta masomenos#
SELECT profesores.primer_nombre, profesores.primer_apellido, asignaturas.nombre
FROM profesores, asignaturas, profesores_asignaturas
WHERE asignaturas.curso='1' AND profesores_asignaturas.asignatura_id=asignaturas.asignatura_id AND profesores_asignaturas.profesor_id=profesores.profesor_id;

SELECT profesores.primer_nombre, profesores.primer_apellido, libros.nombre
FROM profesores, libros, profesores_libros
WHERE profesores_libros.libro_id=1 AND profesores_libros.profesor_id=profesores.profesor_id AND profesores_libros.libro_id=libros.libro_id;

SELECT profesores.primer_nombre,profesores.primer_apellido,colegios.nombre
FROM profesores,colegios,aulas
WHERE colegios.colegio_id=1 AND colegios.colegio_id=aulas.colegio_id AND profesores.aula_id=aulas.aula_id;

SELECT libros.nombre, editoriales.nombre
FROM libros, editoriales
WHERE libros.editorial_id=1 AND libros.editorial_id=editoriales.editorial_id;

SELECT profesores.primer_nombre, profesores.primer_apellido, libros.nombre, fecha_prestamo
FROM profesores, libros, profesores_libros
WHERE fecha_prestamo='2006/09/09' AND profesores_libros.profesor_id=profesores.profesor_id AND profesores_libros.libro_id=libros.libro_id;

