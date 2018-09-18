-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-09-2018 a las 00:43:41
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `conexion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `balaces`
--

CREATE TABLE `balaces` (
  `remision` int(4) NOT NULL,
  `num_doc` int(4) NOT NULL,
  `fecha` date NOT NULL,
  `cod_cuenta` int(6) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `cod_auxiliar` int(4) NOT NULL,
  `valor` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `cod_cuenta` int(6) NOT NULL,
  `nom_cuenta` varchar(120) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `naturaleza`
--

CREATE TABLE `naturaleza` (
  `cod_nat` varchar(1) NOT NULL,
  `tipo_nat` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad`
--

CREATE TABLE `registro_actividad` (
  `cod_actividad` varchar(8) NOT NULL,
  `descripcion` varchar(400) NOT NULL,
  `fecha_sistema` date NOT NULL,
  `cod_usuario` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_manual`
--

CREATE TABLE `registro_manual` (
  `n°_documento` varchar(25) NOT NULL,
  `descripcion` varchar(400) NOT NULL,
  `fecha` date NOT NULL,
  `fecha_sistema` date NOT NULL,
  `cod_cuenta` int(6) NOT NULL,
  `cod_nat` varchar(1) NOT NULL,
  `cod_tercero` int(4) DEFAULT NULL,
  `valor` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `cod_rol` varchar(8) NOT NULL,
  `nombre` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`cod_rol`, `nombre`) VALUES
('1871', 'administrador'),
('2542', 'gerente'),
('3213', 'contador'),
('3894', 'almacenista'),
('5565', 'vendedor'),
('6236', 'auxiliar contable');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `terceros`
--

CREATE TABLE `terceros` (
  `cod_tercero` int(4) NOT NULL,
  `nom_tercero` varchar(25) CHARACTER SET utf8 NOT NULL,
  `descripcion` varchar(400) CHARACTER SET utf8 NOT NULL,
  `telefono` varchar(10) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(4) NOT NULL,
  `nombre` varchar(25) CHARACTER SET utf8 NOT NULL,
  `apellido` varchar(25) CHARACTER SET utf8 NOT NULL,
  `usuario` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `contra` varchar(25) CHARACTER SET utf8 NOT NULL,
  `cod_rol` varchar(8) CHARACTER SET utf8 NOT NULL,
  `telefono` varchar(10) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `usuario`, `contra`, `cod_rol`, `telefono`) VALUES
(1, 'sebastian', 'restrepo', 'srestrepo', '123', '1871', '123456789'),
(2, 'munevar', 'rativa', 'mrativa', '456', '2542', '987654321'),
(3, 'juan', 'reina', 'jreina', '789', '3213', '369258147'),
(4, 'daniel', 'ortiz', 'dortiz', '147', '3894', '147258369'),
(5, 'angela', 'arenas', 'aarenas', '159', '5565', '159374862'),
(6, 'mac', 'allen', 'mallen', '753', '6236', '741236985');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `balaces`
--
ALTER TABLE `balaces`
  ADD PRIMARY KEY (`remision`),
  ADD KEY `cod_cuenta` (`cod_cuenta`),
  ADD KEY `cod_auxiliar` (`cod_auxiliar`);

--
-- Indices de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`cod_cuenta`);

--
-- Indices de la tabla `naturaleza`
--
ALTER TABLE `naturaleza`
  ADD PRIMARY KEY (`cod_nat`);

--
-- Indices de la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD PRIMARY KEY (`cod_actividad`),
  ADD KEY `cod_usuario` (`cod_usuario`);

--
-- Indices de la tabla `registro_manual`
--
ALTER TABLE `registro_manual`
  ADD PRIMARY KEY (`n°_documento`),
  ADD KEY `cod_cuenta` (`cod_cuenta`),
  ADD KEY `cod_nat` (`cod_nat`),
  ADD KEY `cod_tercero` (`cod_tercero`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`cod_rol`);

--
-- Indices de la tabla `terceros`
--
ALTER TABLE `terceros`
  ADD PRIMARY KEY (`cod_tercero`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cod_rol` (`cod_rol`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `balaces`
--
ALTER TABLE `balaces`
  ADD CONSTRAINT `balaces_ibfk_1` FOREIGN KEY (`cod_cuenta`) REFERENCES `cuenta` (`cod_cuenta`),
  ADD CONSTRAINT `balaces_ibfk_2` FOREIGN KEY (`cod_auxiliar`) REFERENCES `terceros` (`cod_tercero`);

--
-- Filtros para la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD CONSTRAINT `cod_usuario` FOREIGN KEY (`cod_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `registro_manual`
--
ALTER TABLE `registro_manual`
  ADD CONSTRAINT `cod_cuenta` FOREIGN KEY (`cod_cuenta`) REFERENCES `cuenta` (`cod_cuenta`),
  ADD CONSTRAINT `cod_nat` FOREIGN KEY (`cod_nat`) REFERENCES `naturaleza` (`cod_nat`),
  ADD CONSTRAINT `cod_tercero` FOREIGN KEY (`cod_tercero`) REFERENCES `terceros` (`cod_tercero`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `cod_rol` FOREIGN KEY (`cod_rol`) REFERENCES `roles` (`cod_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
