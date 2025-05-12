DROP DATABASE IF EXISTS bibliografia_ico;
CREATE DATABASE IF NOT EXISTS bibliografia_ico;
USE bibliografia_ico;

CREATE TABLE tipos_fuente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE fuentes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_id INT NOT NULL,
    titulo TEXT NOT NULL,
    editorial VARCHAR(255) NULL,
    anio YEAR NULL,
    lugar VARCHAR(100) NULL,
    url TEXT,
    FOREIGN KEY (tipo_id) REFERENCES tipos_fuente(id)
);

CREATE TABLE autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL
);

CREATE TABLE autor_fuente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    autor_id INT NOT NULL,
    fuente_id INT NOT NULL,
    FOREIGN KEY (autor_id) REFERENCES autores(id),
    FOREIGN KEY (fuente_id) REFERENCES fuentes(id)
);

CREATE TABLE asignaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    semestre INT
);

CREATE TABLE fuente_asignatura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fuente_id INT NOT NULL,
    asignatura_id INT NOT NULL,
    FOREIGN KEY (fuente_id) REFERENCES fuentes(id),
    FOREIGN KEY (asignatura_id) REFERENCES asignaturas(id)
);

CREATE TABLE administrador (
	id_administrador int AUTO_INCREMENT PRIMARY KEY,
	usuario VARCHAR(255) NOT NULL,
	contrasena VARCHAR(255) NOT NULL
);

INSERT INTO bibliografia_ico.administrador (usuario,contrasena) VALUES
	 ('admin','admin123'),
	 ('ico','ico123');

INSERT INTO bibliografia_ico.asignaturas (nombre,semestre) VALUES
	 ('Álgebra',1),
	 ('Cálculo Diferencial e Integral',1),
	 ('Computadoras y Programación',1),
	 ('Geometría Analítica',1),
	 ('Introducción a la Ingeniería en Computación',1),
	 ('Álgebra Lineal',2),
	 ('Cálculo Vectorial',2),
	 ('Comunicación',2),
	 ('Emprendimiento 1',2),
	 ('Programación Orientada a Objetos',2);
INSERT INTO bibliografia_ico.asignaturas (nombre,semestre) VALUES
	 ('Taller de creatividad e innovación',2),
	 ('Ecuaciones Diferenciales',3),
	 ('Electricidad y Magnetismo (L)',3),
	 ('Emprendimiento 2',3),
	 ('Estructura de Datos',3),
	 ('Métodos Numéricos',3),
	 ('Bases de Datos 1',4),
	 ('Dispositivos Electrónicos (L)',4),
	 ('Emprendimiento 3',4),
	 ('Matemáticas Discretas',4);
INSERT INTO bibliografia_ico.asignaturas (nombre,semestre) VALUES
	 ('Probabilidad y Estadística',4),
	 ('Administración de Proyectos',5),
	 ('Diseño Lógico (L)',5),
	 ('Diseño y Análisis de Algoritmos',5),
	 ('Lenguajes Formales y Autómatas',5),
	 ('Programación Web 1',5),
	 ('Compiladores',6),
	 ('Diseño de Sistemas Digitales (L)',6),
	 ('Ingeniería de Software',6),
	 ('Sistemas Operativos',6);
INSERT INTO bibliografia_ico.asignaturas (nombre,semestre) VALUES
	 ('Microprocesadores y Microcontroladores (L)',7),
	 ('Programación Web 2',7),
	 ('Redes de computadoras 1 (L)',7),
	 ('Sistemas de Información',7),
	 ('Bases de Datos 2',8),
	 ('Habilidades Directivas',8),
	 ('Programación Móvil 1',8),
	 ('Redes de Computadoras 2',8),
	 ('Inteligencia Artificial',9),
	 ('Minería de Datos',9);
INSERT INTO bibliografia_ico.asignaturas (nombre,semestre) VALUES
	 ('Seguridad Informática',9);

INSERT INTO bibliografia_ico.autor_fuente (autor_id,fuente_id) VALUES
	 (6,6),
	 (41,40),
	 (43,42),
	 (46,44),
	 (50,48),
	 (1,1),
	 (2,2),
	 (3,3),
	 (4,4),
	 (5,5);
INSERT INTO bibliografia_ico.autor_fuente (autor_id,fuente_id) VALUES
	 (7,7),
	 (8,8),
	 (9,9),
	 (10,10),
	 (11,11),
	 (12,12),
	 (13,12),
	 (14,13),
	 (15,14),
	 (16,15);
INSERT INTO bibliografia_ico.autor_fuente (autor_id,fuente_id) VALUES
	 (17,16),
	 (18,17),
	 (19,18),
	 (20,19),
	 (21,20),
	 (22,21),
	 (23,22),
	 (24,23),
	 (25,24),
	 (26,25);
INSERT INTO bibliografia_ico.autor_fuente (autor_id,fuente_id) VALUES
	 (27,26),
	 (28,27),
	 (29,28),
	 (30,29),
	 (31,30),
	 (32,31),
	 (33,32),
	 (34,33),
	 (35,34),
	 (36,35);
INSERT INTO bibliografia_ico.autor_fuente (autor_id,fuente_id) VALUES
	 (37,36),
	 (38,37),
	 (39,38),
	 (40,39),
	 (42,41),
	 (47,45),
	 (48,46),
	 (49,47),
	 (52,50),
	 (56,49);
INSERT INTO bibliografia_ico.autor_fuente (autor_id,fuente_id) VALUES
	 (54,52);

INSERT INTO bibliografia_ico.autores (nombre_completo) VALUES
	 ('Cárdenas, T. H.'),
	 ('Emmer, M.'),
	 ('Lax, P.'),
	 ('Mena, B.'),
	 ('Méndez, A.'),
	 ('Péñaloza, R. E.'),
	 ('Gigena, S.'),
	 ('Gindikin, S.'),
	 ('Harris, C.'),
	 ('Adobe');
INSERT INTO bibliografia_ico.autores (nombre_completo) VALUES
	 ('Antón, H.'),
	 ('Dauben, J.'),
	 ('Escriba, C. J.'),
	 ('George, B. T.'),
	 ('Marsden, J.'),
	 ('Fonseca, Y. S.'),
	 ('González, R. S.'),
	 ('Araujo, A. D.'),
	 ('Hernández, O. M.'),
	 ('Ceballos, S. F.');
INSERT INTO bibliografia_ico.autores (nombre_completo) VALUES
	 ('Horton, I.'),
	 ('Fingermann, G.'),
	 ('Osterwald, A.'),
	 ('Debnath, L.'),
	 ('Zill, D.'),
	 ('Giraldo, E.'),
	 ('Sears, F.'),
	 ('Motta, M.'),
	 ('Pappas, J. L.'),
	 ('Aho, A.');
INSERT INTO bibliografia_ico.autores (nombre_completo) VALUES
	 ('Savitch, W.'),
	 ('Carrasco, V. L.'),
	 ('Mora, W. F.'),
	 ('Korth, H.'),
	 ('MariaDB'),
	 ('Markus, J.'),
	 ('Roldan, A. J.'),
	 ('Arya, J.'),
	 ('Hinojosa, J.'),
	 ('Kleiman, A.');
INSERT INTO bibliografia_ico.autores (nombre_completo) VALUES
	 ('Lipchutz, S.'),
	 ('Larson, H.'),
	 ('Montgomery, D.'),
	 ('Meredith, J.'),
	 ('Project Management Institute'),
	 ('Mano, M.'),
	 ('Millman, J.'),
	 ('Silberschatz, A.'),
	 ('W3Schools'),
	 ('IETF');
INSERT INTO bibliografia_ico.autores (nombre_completo) VALUES
	 ('Rex, H.'),
	 ('Puchol, L.'),
	 ('Russell, S.'),
	 ('Russell, M.'),
	 ('Rossell S.'),
	 ('Russell S.');

INSERT INTO bibliografia_ico.fuente_asignatura (fuente_id,asignatura_id) VALUES
	 (6,3),
	 (40,20),
	 (42,21),
	 (44,23),
	 (48,33),
	 (1,1),
	 (2,1),
	 (3,2),
	 (4,2),
	 (5,3);
INSERT INTO bibliografia_ico.fuente_asignatura (fuente_id,asignatura_id) VALUES
	 (7,4),
	 (8,4),
	 (9,5),
	 (10,5),
	 (11,6),
	 (12,4),
	 (13,7),
	 (14,7),
	 (15,8),
	 (16,8);
INSERT INTO bibliografia_ico.fuente_asignatura (fuente_id,asignatura_id) VALUES
	 (17,9),
	 (18,9),
	 (19,10),
	 (20,10),
	 (21,11),
	 (22,11),
	 (23,12),
	 (24,12),
	 (25,13),
	 (26,13);
INSERT INTO bibliografia_ico.fuente_asignatura (fuente_id,asignatura_id) VALUES
	 (27,14),
	 (28,14),
	 (29,27),
	 (30,15),
	 (31,16),
	 (32,16),
	 (33,17),
	 (34,17),
	 (35,18),
	 (36,18);
INSERT INTO bibliografia_ico.fuente_asignatura (fuente_id,asignatura_id) VALUES
	 (37,19),
	 (38,19),
	 (39,20),
	 (41,21),
	 (45,18),
	 (46,30),
	 (47,32),
	 (50,36),
	 (49,39),
	 (52,40);

INSERT INTO bibliografia_ico.fuentes (tipo_id,titulo,editorial,anio,lugar,url) VALUES
	 (1,'Algebra Superior','Editorial Trillas',2014,'México',''),
	 (1,'Imagine Math. Between Culture and Mathematics','Springer',2012,'Italia',''),
	 (1,'Calculus with Applications','Springer',2014,'New York',''),
	 (1,'Introduccion al Cálculo Vectorial','Thomson',2003,'México',''),
	 (1,'Diseño de algoritmos y su programación en C','Alfaomega',2013,'México',''),
	 (1,'Fundamentos de programación','UNAM ENEP Aragón',2004,'México',NULL),
	 (1,'Álgebra y geometría: teoría, práctica y aplicaciones','Universitas Editorial Cientifica Universitaria',2018,'Argentina',''),
	 (1,'Tales of Mathematicians and Physicists','Springer',2007,'New York',''),
	 (1,'Engineering Ethics: Concepts and Cases','Wadsworth Publishing',2014,'USA',''),
	 (2,'Documentación de Photoshop',NULL,2017,NULL,'https://helpx.adobe.com/support/photoshop.html');
INSERT INTO bibliografia_ico.fuentes (tipo_id,titulo,editorial,anio,lugar,url) VALUES
	 (1,'Introducción al Álgebra Lineal','Limusa',2003,'México',''),
	 (1,'Writing the History of Mathematics: Its Historical Development','Birkhäuser',2002,'Alemania',''),
	 (1,'Cálculo varias variables','Pearson Education',2015,'México',''),
	 (1,'Cálculo Vectorial','Pearson Education (Prentice Hall)',2005,'México',''),
	 (1,'Comunicación oral y escrita','Pearson',2016,'México',''),
	 (1,'Manual de redacción e investigación documental','Trillas',2005,'México',''),
	 (1,'Presupuestos empresariales. Eje de la planeación financiera','Trillas',2012,'México',''),
	 (1,'Administración de empresas','Piramide',2014,'España',''),
	 (1,'Java 2 Curso de Programación','Alfaomega Ra-Ma',2000,'México',''),
	 (1,'Beginning Java','John Wiley',2011,'USA','');
INSERT INTO bibliografia_ico.fuentes (tipo_id,titulo,editorial,anio,lugar,url) VALUES
	 (1,'Relaciones humanas, fundamentos psicológicos y sociales','Editorial el ateneo',1992,'México',''),
	 (1,'Generación de modelos de negocios','Wiley',2010,'New Jersey',''),
	 (1,'Nonlinear partial differential equations','Birlchauser',2013,'USA',''),
	 (1,'Ecuaciones diferenciales con aplicaciones de modelado','Thompson',2006,'México',''),
	 (1,'Fundamentos de electricidad y magnetismo','Fondo Editorial EIA',2015,'Colombia',''),
	 (1,'Física Universitaria','Addison-Wesley',2008,'México',''),
	 (1,'Política de competencia: teoría y práctica','Fondo de Cultura Económica',2018,'Ciudad de México',''),
	 (1,'Fundamentos de economía y administración','McGraw-Hill',1993,'México',''),
	 (1,'Compiladores: principios, técnicas y herramientas','Addison Wesley',2008,'México',''),
	 (1,'Absolute Java','Addison-Wesley',2010,'México','');
INSERT INTO bibliografia_ico.fuentes (tipo_id,titulo,editorial,anio,lugar,url) VALUES
	 (1,'Métodos numéricos','Macro',2011,'Lima, Perú',''),
	 (1,'Introducción a los Métodos Numéricos','Escuela de Matemáticas',2016,'Costa Rica',''),
	 (1,'Fundamentos de Bases de Datos','McGraw-Hill',2014,'España',''),
	 (2,'Manuales de MariaDB',NULL,2017,NULL,'https://mariadb.com/kb/en/documentation/'),
	 (1,'Manual De Circuitos Electrónicos','Marcombo',1987,'México',''),
	 (1,'Dispositivos electrónicos, problemas resueltos','Alfaomega',2001,'México',''),
	 (1,'Matemáticas aplicadas a la administración y a la economía','Pearson',2002,'México',''),
	 (1,'Evaluación económico-financiera de proyectos de inversión','Trillas',2011,'México',''),
	 (1,'Aplicaciones matemáticas a la administración','Limusa',1972,'México',''),
	 (1,'Teoría de conjuntos y temas afines','Mc Graw-Hill',1973,'Colombia',NULL);
INSERT INTO bibliografia_ico.fuentes (tipo_id,titulo,editorial,anio,lugar,url) VALUES
	 (1,'Introduction to probability theory and statistical inference','John Wiley & Sons',1989,'Canada',''),
	 (1,'Applied statistics and probability for engineers','John Wiley & Sons',2003,'USA',NULL),
	 (1,'Diseño Digital','Pearson',2018,'México',NULL),
	 (1,'Microelectronics','McGraw-Hill',2001,'USA',''),
	 (1,'Sistemas Operativos','Limusa',2002,'México',''),
	 (2,'JavaScript Tutorial',NULL,2017,NULL,'https://www.w3schools.com/jS/default.asp'),
	 (2,'Especificaciones de RFC para redes',NULL,2020,NULL,'https://www.ietf.org/standards/rfcs/'),
	 (1,'Inteligencia Artificial: Un enfoque moderno','Prentice Hall Hispanoamericano',1996,'México',''),
	 (1,'El libro de las Habilidades Directivas','Díaz de Santos',2010,'España',''),
	 (1,'Mining the social web ','O''Reilly',2011,'USA','');


INSERT INTO bibliografia_ico.tipos_fuente (nombre) VALUES
	 ('Libros'),
	 ('Fuentes electronicas'),
	 ('Articulos');
