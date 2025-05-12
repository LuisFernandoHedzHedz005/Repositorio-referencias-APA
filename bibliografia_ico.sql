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

INSERT INTO tipos_fuente (nombre) VALUES 
('Libros'), 
('Fuentes electronicas'), 
('Articulos');

INSERT INTO administrador (usuario, contrasena) VALUES
('admin', 'admin123'),  
('ico', 'ico123');



-- Insertar tipos de fuente
INSERT INTO tipos_fuente (nombre) VALUES 
('Libros'), 
('Fuentes electronicas'), 
('Articulos');

-- Insertar administradores
INSERT INTO administrador (usuario, contrasena) VALUES
('admin', 'admin123'),  
('ico', 'ico123');

-- Insertar autores
INSERT INTO autores (nombre_completo) VALUES
('Cárdenas, T. H.'),
('Emmer, M.'),
('Lax, P.'),
('Mena, B.'),
('Méndez, A.'),
('Péñaloza, R. E.'),
('Gigena, S.'),
('Gindikin, S.'),
('Harris, C.'),
('Adobe'),
('Antón, H.'),
('Dauben, J.'),
('Escriba, C. J.'),
('George, B. T.'),
('Marsden, J.'), 
('Fonseca, Y. S.'),
('González, R. S.'),
('Araujo, A. D.'),
('Hernández, O. M.'),
('Ceballos, S. F.'),
('Horton, I.'),
('Fingermann, G.'),
('Osterwald, A.'),
('Debnath, L.'),
('Zill, D.'),
('Giraldo, E.'),
('Sears, F.'),
('Motta, M.'),
('Pappas, J. L.'),
('Aho, A.'),
('Savitch, W.'),
('Carrasco, V. L.'),
('Mora, W. F.'),
('Korth, H.'),
('MariaDB'),
('Markus, J.'),
('Roldan, A. J.'),
('Arya, J.'),
('Hinojosa, J.'),
('Kleiman, A.'),
('Lipchutz, S.'),
('Larson, H.'),
('Montgomery, D.'),
('Meredith, J.'),
('Project Management Institute'),
('Mano, M.'),
('Millman, J.'),
('Silberschatz, A.'),
('W3Schools'),
('IETF'),
('Rex, H.'),
('Puchol, L.'),
('Russell, S.'),
('Russell, M.');

-- Insertar fuentes
INSERT INTO fuentes (tipo_id, titulo, editorial, anio, lugar, url) VALUES
(1, 'Algebra Superior', 'Editorial Trillas', 2014, 'México', NULL), 
(1, 'Imagine Math. Between Culture and Mathematics', 'Springer', 2012, 'Italia', NULL),
(1, 'Calculus with Applications', 'Springer', 2014, 'New York', NULL),
(1, 'Introduccion al Cálculo Vectorial', 'Thomson', 2003, 'México', NULL),
(1, 'Diseño de algoritmos y su programación en C', 'Alfaomega', 2013, 'México', NULL),
(1, 'Fundamentos de programación', 'UNAM ENEP Aragón', 2004, 'México', NULL),
(1, 'Álgebra y geometría: teoría, práctica y aplicaciones', 'Universitas Editorial Cientifica Universitaria', 2018, 'Argentina', NULL),
(1, 'Tales of Mathematicians and Physicists', 'Springer', 2007, 'New York', NULL),
(1, 'Engineering Ethics: Concepts and Cases', 'Wadsworth Publishing', 2014, 'USA', NULL),
(2, 'Documentación de Photoshop', NULL, 2017, NULL, 'https://helpx.adobe.com/support/photoshop.html'),
(1, 'Introducción al Álgebra Lineal', 'Limusa', 2003, 'México', NULL),
(1, 'Writing the History of Mathematics: Its Historical Development', 'Birkhäuser', 2002, 'Alemania', NULL),
(1, 'Cálculo varias variables', 'Pearson Education', 2015, 'México', NULL),
(1, 'Cálculo Vectorial', 'Pearson Education (Prentice Hall)', 2005, 'México', NULL),
(1, 'Comunicación oral y escrita', 'Pearson', 2016, 'México', NULL),
(1, 'Manual de redacción e investigación documental', 'Trillas', 2005, 'México', NULL),
(1, 'Presupuestos empresariales. Eje de la planeación financiera', 'Trillas', 2012, 'México', NULL),
(1, 'Administración de empresas', 'Piramide', 2014, 'España', NULL),
(1, 'Java 2 Curso de Programación', 'Alfaomega Ra-Ma', 2000, 'México', NULL),
(1, 'Beginning Java', 'John Wiley', 2011, 'USA', NULL),
(1, 'Relaciones humanas, fundamentos psicológicos y sociales', 'Editorial el ateneo', 1992, 'México', NULL),
(1, 'Generación de modelos de negocios', 'Wiley', 2010, 'New Jersey', NULL),
(1, 'Nonlinear partial differential equations', 'Birlchauser', 2013, 'USA', NULL),
(1, 'Ecuaciones diferenciales con aplicaciones de modelado', 'Thompson', 2006, 'México', NULL),
(1, 'Fundamentos de electricidad y magnetismo', 'Fondo Editorial EIA', 2015, 'Colombia', NULL),
(1, 'Física Universitaria', 'Addison-Wesley', 2008, 'México', NULL),
(1, 'Política de competencia: teoría y práctica', 'Fondo de Cultura Económica', 2018, 'Ciudad de México', NULL),
(1, 'Fundamentos de economía y administración', 'McGraw-Hill', 1993, 'México', NULL),
(1, 'Compiladores: principios, técnicas y herramientas', 'Addison Wesley', 2008, 'México', NULL),
(1, 'Absolute Java', 'Addison-Wesley', 2010, 'México', NULL),
(1, 'Métodos numéricos', 'Macro', 2011, 'Lima, Perú', NULL),
(1, 'Introducción a los Métodos Numéricos', 'Escuela de Matemáticas', 2016, 'Costa Rica', NULL),
(1, 'Fundamentos de Bases de Datos', 'McGraw-Hill', 2014, 'España', NULL),
(2, 'Manuales de MariaDB', NULL, 2017, NULL, 'https://mariadb.com/kb/en/documentation/'),
(1, 'Manual De Circuitos Electrónicos', 'Marcombo', 1987, 'México', NULL),
(1, 'Dispositivos electrónicos, problemas resueltos', 'Alfaomega', 2001, 'México', NULL),
(1, 'Matemáticas aplicadas a la administración y a la economía', 'Pearson', 2002, 'México', NULL),
(1, 'Evaluación económico-financiera de proyectos de inversión', 'Trillas', 2011, 'México', NULL),
(1, 'Aplicaciones matemáticas a la administración', 'Limusa', 1972, 'México', NULL),
(1, 'Teoría de conjuntos y temas afines', 'Mc Graw-Hill', 1973, 'Colombia', NULL),
(1, 'Introduction to probability theory and statistical inference', 'John Wiley & Sons', 1989, 'Canada', NULL),
(1, 'Applied statistics and probability for engineers', 'John Wiley & Sons', 2003, 'USA', NULL),
(1, 'Guía para el PMBOK', 'PMI', 2017, 'USA', NULL),
(1, 'Diseño Digital', 'Pearson', 2018, 'México', NULL),
(1, 'Microelectrónica: Circuitos y dispositivos', 'McGraw-Hill', 2015, 'España', NULL),
(1, 'Sistemas Operativos', 'McGraw-Hill', 2009, 'México', NULL),
(2, 'Tutorial HTML', NULL, 2023, NULL, 'https://www.w3schools.com/html/'),
(2, 'Especificaciones de RFC para redes', NULL, 2020, NULL, 'https://www.ietf.org/standards/rfcs/'),
(1, 'Inteligencia Artificial: Un enfoque moderno', 'Pearson', 2022, 'España', NULL),
(1, 'El libro de las entrevistas de trabajo', 'Díaz de Santos', 2010, 'Madrid', NULL),
(1, 'Minería de datos: conceptos y técnicas', 'Morgan Kaufmann', 2011, 'USA', NULL),
(1, 'Seguridad en redes y sistemas informáticos', 'McGraw-Hill', 2019, 'México', NULL);

-- Relacionar autores con fuentes (corregido para que los IDs coincidan)
INSERT INTO autor_fuente (autor_id, fuente_id) VALUES
(1, 1),  -- Cárdenas -> Algebra Superior
(2, 2),  -- Emmer -> Imagine Math
(3, 3),  -- Lax -> Calculus with Applications
(4, 4),  -- Mena -> Introduccion al Cálculo Vectorial
(5, 5),  -- Méndez -> Diseño de algoritmos y su programación en C
(6, 6),  -- Péñaloza -> Fundamentos de programación
(7, 7),  -- Gigena -> Álgebra y geometría
(8, 8),  -- Gindikin -> Tales of Mathematicians and Physicists
(9, 9),  -- Harris -> Engineering Ethics
(10, 10), -- Adobe -> Documentación de Photoshop
(11, 11), -- Antón -> Introducción al Álgebra Lineal
(12, 12), -- Dauben -> Writing the History of Mathematics
(13, 12), -- Escriba -> Writing the History of Mathematics (co-autor)
(14, 13), -- George -> Cálculo varias variables
(15, 14), -- Marsden -> Cálculo Vectorial
(16, 15), -- Fonseca -> Comunicación oral y escrita
(17, 16), -- González -> Manual de redacción e investigación documental
(18, 17), -- Araujo -> Presupuestos empresariales
(19, 18), -- Hernández -> Administración de empresas
(20, 19), -- Ceballos -> Java 2 Curso de Programación
(21, 20), -- Horton -> Beginning Java
(22, 21), -- Fingermann -> Relaciones humanas
(23, 22), -- Osterwald -> Generación de modelos de negocios
(24, 23), -- Debnath -> Nonlinear partial differential equations
(25, 24), -- Zill -> Ecuaciones diferenciales con aplicaciones
(26, 25), -- Giraldo -> Fundamentos de electricidad y magnetismo
(27, 26), -- Sears -> Física Universitaria
(28, 27), -- Motta -> Política de competencia
(29, 28), -- Pappas -> Fundamentos de economía y administración
(30, 29), -- Aho -> Compiladores
(31, 30), -- Savitch -> Absolute Java
(32, 31), -- Carrasco -> Métodos numéricos
(33, 32), -- Mora -> Introducción a los Métodos Numéricos
(34, 33), -- Korth -> Fundamentos de Bases de Datos
(35, 34), -- MariaDB -> Manuales de MariaDB
(36, 35), -- Markus -> Manual De Circuitos Electrónicos
(37, 36), -- Roldan -> Dispositivos electrónicos
(38, 37), -- Arya -> Matemáticas aplicadas a la administración
(39, 38), -- Hinojosa -> Evaluación económico-financiera de proyectos
(40, 39), -- Kleiman -> Aplicaciones matemáticas a la administración
(41, 40), -- Lipchutz -> Teoría de conjuntos y temas afines
(42, 41), -- Larson -> Introduction to probability theory
(43, 42), -- Montgomery -> Applied statistics and probability
(44, 43), -- Meredith -> Guía para el PMBOK
(45, 43), -- Project Management Institute -> Guía para el PMBOK (organización autora)
(46, 44), -- Mano -> Diseño Digital
(47, 45), -- Millman -> Microelectrónica: Circuitos y dispositivos
(48, 46), -- Silberschatz -> Sistemas Operativos
(49, 47), -- W3Schools -> Tutorial HTML
(50, 48), -- IETF -> Especificaciones de RFC para redes
(51, 49), -- Rex -> Inteligencia Artificial
(52, 50), -- Puchol -> El libro de las entrevistas de trabajo
(53, 51), -- Russell, S. -> Minería de datos
(54, 52); -- Russell, M. -> Seguridad en redes y sistemas informáticos

-- Insertar asignaturas
INSERT INTO asignaturas (nombre, semestre) VALUES
-- PRIMER SEMESTRE
('Álgebra', 1),
('Cálculo Diferencial e Integral', 1),
('Computadoras y Programación', 1),
('Geometría Analítica', 1),
('Introducción a la Ingeniería en Computación', 1),

-- SEGUNDO SEMESTRE
('Álgebra Lineal', 2),
('Cálculo Vectorial', 2),
('Comunicación', 2),
('Emprendimiento 1', 2),
('Programación Orientada a Objetos', 2),
('Taller de creatividad e innovación', 2),

-- TERCER SEMESTRE
('Ecuaciones Diferenciales', 3),
('Electricidad y Magnetismo (L)', 3),
('Emprendimiento 2', 3),
('Estructura de Datos', 3),
('Métodos Numéricos', 3),

-- CUARTO SEMESTRE
('Bases de Datos 1', 4),
('Dispositivos Electrónicos (L)', 4),
('Emprendimiento 3', 4),
('Matemáticas Discretas', 4),
('Probabilidad y Estadística', 4),

-- QUINTO SEMESTRE
('Administración de Proyectos', 5),
('Diseño Lógico (L)', 5),
('Diseño y Análisis de Algoritmos', 5),
('Lenguajes Formales y Autómatas', 5),
('Programación Web 1', 5),

-- SEXTO SEMESTRE
('Compiladores', 6),
('Diseño de Sistemas Digitales (L)', 6),
('Ingeniería de Software', 6),
('Sistemas Operativos', 6),

-- SÉPTIMO SEMESTRE
('Microprocesadores y Microcontroladores (L)', 7),
('Programación Web 2', 7),
('Redes de computadoras 1 (L)', 7),
('Sistemas de Información', 7),

-- OCTAVO SEMESTRE
('Bases de Datos 2', 8),
('Habilidades Directivas', 8),
('Programación Móvil 1', 8),
('Redes de Computadoras 2', 8),

-- NOVENO SEMESTRE
('Inteligencia Artificial', 9),
('Minería de Datos', 9),
('Seguridad Informática', 9);

-- Relacionar fuentes con asignaturas
INSERT INTO fuente_asignatura (fuente_id, asignatura_id) VALUES
(1, 1),   -- Algebra Superior -> Álgebra
(3, 2),   -- Calculus with Applications -> Cálculo Diferencial e Integral
(6, 3),   -- Fundamentos de programación -> Computadoras y Programación
(19, 3),  -- Java 2 Curso de Programación -> Computadoras y Programación
(7, 4),   -- Álgebra y geometría -> Geometría Analítica
(11, 6),  -- Introducción al Álgebra Lineal -> Álgebra Lineal
(13, 7),  -- Cálculo varias variables -> Cálculo Vectorial
(14, 7),  -- Cálculo Vectorial -> Cálculo Vectorial
(15, 8),  -- Comunicación oral y escrita -> Comunicación
(16, 8),  -- Manual de redacción e investigación documental -> Comunicación
(20, 10), -- Beginning Java -> Programación Orientada a Objetos
(24, 12), -- Ecuaciones diferenciales con aplicaciones -> Ecuaciones Diferenciales
(25, 13), -- Fundamentos de electricidad y magnetismo -> Electricidad y Magnetismo (L)
(26, 13), -- Física Universitaria -> Electricidad y Magnetismo (L)
(31, 16), -- Métodos numéricos -> Métodos Numéricos
(32, 16), -- Introducción a los Métodos Numéricos -> Métodos Numéricos
(33, 17), -- Fundamentos de Bases de Datos -> Bases de Datos 1
(34, 17), -- Manuales de MariaDB -> Bases de Datos 1
(35, 18), -- Manual De Circuitos Electrónicos -> Dispositivos Electrónicos (L)
(36, 18), -- Dispositivos electrónicos, problemas resueltos -> Dispositivos Electrónicos (L)
(40, 20), -- Teoría de conjuntos y temas afines -> Matemáticas Discretas
(41, 21), -- Introduction to probability theory -> Probabilidad y Estadística
(42, 21), -- Applied statistics and probability -> Probabilidad y Estadística
(43, 22), -- Guía para el PMBOK -> Administración de Proyectos
(44, 23), -- Diseño Digital -> Diseño Lógico (L)
(29, 26), -- Compiladores -> Compiladores
(46, 29), -- Sistemas Operativos -> Sistemas Operativos
(45, 30), -- Microelectrónica: Circuitos y dispositivos -> Microprocesadores y Microcontroladores (L)
(47, 31), -- Tutorial HTML -> Programación Web 2
(48, 33), -- Especificaciones de RFC para redes -> Redes de computadoras 1 (L)
(49, 38), -- Inteligencia Artificial -> Inteligencia Artificial
(51, 39), -- Minería de datos -> Minería de Datos
(52, 40); -- Seguridad en redes y sistemas informáticos -> Seguridad Informática