-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 14-10-2017 a las 17:35:01
-- Versión del servidor: 10.1.26-MariaDB-0+deb9u1
-- Versión de PHP: 7.0.19-1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `doctorado_2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivo`
--

CREATE TABLE `archivo` (
  `arc_tipoPDF_cargar` varchar(40) NOT NULL,
  `doc_identificador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capitulo_libro`
--

CREATE TABLE `capitulo_libro` (
  `doc_identificador` int(11) NOT NULL,
  `caplib_titulo_libro` varchar(200) NOT NULL,
  `caplib_titulo_capitulo` varchar(80) NOT NULL,
  `caplib_isbn` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `congreso`
--

CREATE TABLE `congreso` (
  `doc_identificador` int(11) NOT NULL,
  `cong_titulo_ponencia` varchar(200) NOT NULL,
  `cong_nombre_evento` varchar(100) NOT NULL,
  `cong_tipo_congreso` varchar(30) NOT NULL,
  `cong_doi` varchar(30) NOT NULL,
  `cong_issn` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coordinador`
--

CREATE TABLE `coordinador` (
  `id_posgrado` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentacion`
--

CREATE TABLE `documentacion` (
  `doc_identificador` int(11) NOT NULL,
  `doc_hash` varchar(40) DEFAULT NULL,
  `doc_diropkm` varchar(30) DEFAULT NULL,
  `doc_creditos` int(11) DEFAULT NULL,
  `doc_fecha_visado` date DEFAULT NULL,
  `doc_fecha_registro` date DEFAULT NULL,
  `doc_estado` varchar(15) DEFAULT NULL,
  `doc_fecha_publicacion` date NOT NULL,
  `doc_num_acta` int(20) DEFAULT NULL,
  `doc_visado` varchar(20) DEFAULT NULL,
  `id_tipo_documentacion` int(11) NOT NULL,
  `doc_autores_secundarios` varchar(300) DEFAULT NULL,
  `est_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `est_cedula` int(11) NOT NULL,
  `est_codigo` varchar(20) NOT NULL,
  `est_cohorte` int(4) NOT NULL,
  `est_tutor` varchar(45) NOT NULL,
  `est_semestre` int(2) NOT NULL,
  `est_creditos` int(11) NOT NULL,
  `est_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`est_cedula`, `est_codigo`, `est_cohorte`, `est_tutor`, `est_semestre`, `est_creditos`, `est_id`, `usu_id`) VALUES
(1059, '70_1234567890', 2015, 'pedro', 1, 1, 2, 2),
(123, '70_1234567891', 2017, 'carlos', 1, 1, 3, 6),
(123567890, '70_1234567895', 2017, 'carlos', 1, 0, 4, 7),
(123123, '70_1234567894', 2017, 'camilo', 1, 0, 5, 8),
(12345, '70_1234567897', 2017, 'carlitos', 2, 0, 21, 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante_posgrado`
--

CREATE TABLE `estudiante_posgrado` (
  `id_posgrado` int(11) NOT NULL,
  `est_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_tipo_usuario`
--

CREATE TABLE `grupo_tipo_usuario` (
  `id_tipo` varchar(30) NOT NULL,
  `nombre_usuario` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `grupo_tipo_usuario`
--

INSERT INTO `grupo_tipo_usuario` (`id_tipo`, `nombre_usuario`, `usu_id`) VALUES
('COORDINADOR', 'luan', 1),
('ESTUDIANTE', 'luiss', 2),
('ESTUDIANTE', 'lucas', 6),
('ESTUDIANTE', 'fel', 7),
('ESTUDIANTE', 'darth', 8),
('ESTUDIANTE', '', 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `doc_identificador` int(11) NOT NULL,
  `lib_titulo_libro` varchar(200) NOT NULL,
  `lib_isbn` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pasantia`
--

CREATE TABLE `pasantia` (
  `fecha_inicio` varchar(45) DEFAULT NULL,
  `fecha_terminacion` varchar(45) DEFAULT NULL,
  `lugar` varchar(45) DEFAULT NULL,
  `documentacion_doc_identificador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postgrado`
--

CREATE TABLE `postgrado` (
  `id_posgrado` int(11) NOT NULL,
  `nombre_postgrado` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `revista`
--

CREATE TABLE `revista` (
  `doc_identificador` int(11) NOT NULL,
  `rev_nombre_revista` varchar(80) NOT NULL,
  `rev_titulo_articulo` varchar(200) NOT NULL,
  `rev_categoria` varchar(2) NOT NULL,
  `rev_doi` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `identificador` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `correquisitos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`identificador`, `nombre`, `correquisitos`) VALUES
(1, 'LIBRO', NULL),
(2, 'REVISTA', NULL),
(3, 'CONGRESO', NULL),
(4, 'CAPITULO LIBRO', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `descripcion` varchar(100) NOT NULL,
  `id_tipo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`descripcion`, `id_tipo`) VALUES
('3', 'ADMINISTRADOR'),
('2', 'COORDINADOR'),
('1', 'ESTUDIANTE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `nombres` varchar(30) NOT NULL,
  `apellidos` varchar(30) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `contrasena` varchar(70) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'activo',
  `usu_id` int(11) NOT NULL,
  `nombre_usuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`nombres`, `apellidos`, `correo`, `contrasena`, `estado`, `usu_id`, `nombre_usuario`) VALUES
('luan', 'santana', 'luan', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'activo', 1, 'luan'),
('luis camilo', 'beltran', 'luiss@gmail.es', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'ACTIVO', 2, 'luiss'),
('lucas', 'film', 'lucas@gmail.es', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'ACTIVO', 6, 'lucas'),
('felipe alejandro', 'pelaes', 'fel@gmail.es', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'ACTIVO', 7, 'fel'),
('darth', 'vader', 'darth@gmail.es', '9a0ccf9f65061d33af3edcd6096eda069e88bef6afc1fc9ab93e32c4d6cdabdd', 'ACTIVO', 8, 'darth'),
('harry', 'potter', 'harrypotter@gmail.es', '437d9b6c76e4cf07274c7018de405a4bff1b9baa7846e1c708adc708e7e9e062', 'ACTIVO', 24, 'harrypotter');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `archivo`
--
ALTER TABLE `archivo`
  ADD PRIMARY KEY (`arc_tipoPDF_cargar`,`doc_identificador`),
  ADD KEY `fk_archivo_documentacion1_idx` (`doc_identificador`);

--
-- Indices de la tabla `capitulo_libro`
--
ALTER TABLE `capitulo_libro`
  ADD PRIMARY KEY (`doc_identificador`),
  ADD UNIQUE KEY `caplib_isbn_UNIQUE` (`caplib_isbn`),
  ADD KEY `fk_capitulo_libro_publicacion1_idx` (`doc_identificador`);

--
-- Indices de la tabla `congreso`
--
ALTER TABLE `congreso`
  ADD PRIMARY KEY (`doc_identificador`),
  ADD KEY `fk_congreso_publicacion1_idx` (`doc_identificador`);

--
-- Indices de la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD PRIMARY KEY (`id_posgrado`),
  ADD KEY `fk_coordinador_postgrado1_idx` (`id_posgrado`),
  ADD KEY `fk_coordinador_usuario1_idx` (`usu_id`);

--
-- Indices de la tabla `documentacion`
--
ALTER TABLE `documentacion`
  ADD PRIMARY KEY (`doc_identificador`),
  ADD KEY `fk_publicacion_tipo_publicacion1_idx` (`id_tipo_documentacion`),
  ADD KEY `fk_documentacion_estudiante1_idx` (`est_id`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`est_id`),
  ADD UNIQUE KEY `est_codigo_UNIQUE` (`est_codigo`),
  ADD UNIQUE KEY `est_cedula_UNIQUE` (`est_cedula`),
  ADD UNIQUE KEY `usu_id_UNIQUE` (`usu_id`),
  ADD UNIQUE KEY `est_id_UNIQUE` (`est_id`),
  ADD KEY `fk_estudiante_usuario1_idx` (`usu_id`);

--
-- Indices de la tabla `estudiante_posgrado`
--
ALTER TABLE `estudiante_posgrado`
  ADD PRIMARY KEY (`id_posgrado`,`est_id`),
  ADD KEY `fk_estudiante_posgrado_postgrado1_idx` (`id_posgrado`),
  ADD KEY `fk_estudiante_posgrado_estudiante1_idx` (`est_id`);

--
-- Indices de la tabla `grupo_tipo_usuario`
--
ALTER TABLE `grupo_tipo_usuario`
  ADD PRIMARY KEY (`usu_id`),
  ADD KEY `fk_grupo_tipo_usuario_tipo_usuario1_idx` (`id_tipo`),
  ADD KEY `fk_grupo_tipo_usuario_usuario1_idx` (`usu_id`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`doc_identificador`),
  ADD UNIQUE KEY `lib_isbn_UNIQUE` (`lib_isbn`),
  ADD KEY `fk_libro_publicacion1_idx` (`doc_identificador`);

--
-- Indices de la tabla `pasantia`
--
ALTER TABLE `pasantia`
  ADD PRIMARY KEY (`documentacion_doc_identificador`);

--
-- Indices de la tabla `postgrado`
--
ALTER TABLE `postgrado`
  ADD PRIMARY KEY (`id_posgrado`);

--
-- Indices de la tabla `revista`
--
ALTER TABLE `revista`
  ADD PRIMARY KEY (`doc_identificador`),
  ADD KEY `fk_revista_publicacion1_idx` (`doc_identificador`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`identificador`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_tipo_publicacion_tipo_publicacion1_idx` (`correquisitos`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`),
  ADD UNIQUE KEY `correo_UNIQUE` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documentacion`
--
ALTER TABLE `documentacion`
  MODIFY `doc_identificador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `est_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT de la tabla `postgrado`
--
ALTER TABLE `postgrado`
  MODIFY `id_posgrado` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivo`
--
ALTER TABLE `archivo`
  ADD CONSTRAINT `fk_archivo_documentacion1` FOREIGN KEY (`doc_identificador`) REFERENCES `documentacion` (`doc_identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `capitulo_libro`
--
ALTER TABLE `capitulo_libro`
  ADD CONSTRAINT `fk_capitulo_libro_publicacion1` FOREIGN KEY (`doc_identificador`) REFERENCES `documentacion` (`doc_identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `congreso`
--
ALTER TABLE `congreso`
  ADD CONSTRAINT `fk_congreso_publicacion1` FOREIGN KEY (`doc_identificador`) REFERENCES `documentacion` (`doc_identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD CONSTRAINT `fk_coordinador_postgrado1` FOREIGN KEY (`id_posgrado`) REFERENCES `postgrado` (`id_posgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_coordinador_usuario1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `documentacion`
--
ALTER TABLE `documentacion`
  ADD CONSTRAINT `fk_documentacion_estudiante1` FOREIGN KEY (`est_id`) REFERENCES `estudiante` (`est_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_publicacion_tipo_publicacion1` FOREIGN KEY (`id_tipo_documentacion`) REFERENCES `tipo_documento` (`identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `fk_estudiante_usuario1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estudiante_posgrado`
--
ALTER TABLE `estudiante_posgrado`
  ADD CONSTRAINT `fk_estudiante_posgrado_estudiante1` FOREIGN KEY (`est_id`) REFERENCES `estudiante` (`est_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_estudiante_posgrado_postgrado1` FOREIGN KEY (`id_posgrado`) REFERENCES `postgrado` (`id_posgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `grupo_tipo_usuario`
--
ALTER TABLE `grupo_tipo_usuario`
  ADD CONSTRAINT `fk_grupo_tipo_usuario_tipo_usuario1` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_usuario` (`id_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grupo_tipo_usuario_usuario1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `libro`
--
ALTER TABLE `libro`
  ADD CONSTRAINT `fk_libro_publicacion1` FOREIGN KEY (`doc_identificador`) REFERENCES `documentacion` (`doc_identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pasantia`
--
ALTER TABLE `pasantia`
  ADD CONSTRAINT `fk_pasantia_documentacion1` FOREIGN KEY (`documentacion_doc_identificador`) REFERENCES `documentacion` (`doc_identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `revista`
--
ALTER TABLE `revista`
  ADD CONSTRAINT `fk_revista_publicacion1` FOREIGN KEY (`doc_identificador`) REFERENCES `documentacion` (`doc_identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD CONSTRAINT `fk_tipo_publicacion_tipo_publicacion1` FOREIGN KEY (`correquisitos`) REFERENCES `tipo_documento` (`identificador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
