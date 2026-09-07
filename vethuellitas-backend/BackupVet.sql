CREATE DATABASE  IF NOT EXISTS `veterinaria_web` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `veterinaria_web`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: veterinaria_web
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Productos contra pulgas, garrapatas y parásitos internos.','Antiparasitarios'),(2,'Alimentos balanceados y de prescripción para mascotas.','Alimentos'),(3,'Productos para la higiene, dermatología y limpieza.','Higiene y Cuidado'),(4,'Vitaminas y probióticos para la salud de la mascota.','Suplementos'),(5,'Juguetes y accesorios de entretenimiento.','Juguetes'),(6,'Complementos para el día a día de la mascota.','Accesorios'),(7,'Premios y snacks nutritivos.','Snacks y Premios');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `estado` enum('CANCELADA','CONFIRMADA','PENDIENTE','REALIZADA') DEFAULT NULL,
  `fecha_hora` datetime(6) DEFAULT NULL,
  `motivo` varchar(100) NOT NULL,
  `mascota_id` bigint NOT NULL,
  `servicio_id` bigint DEFAULT NULL,
  `trabajador_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKmoh4y7wq0bqnr9hf70j2m8hjk` (`mascota_id`),
  KEY `FKl89m4psdo9tdi6smrdq3n3p33` (`servicio_id`),
  KEY `FKmpyrctoll1n0n688uevrh2fe5` (`trabajador_id`),
  CONSTRAINT `FKl89m4psdo9tdi6smrdq3n3p33` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`),
  CONSTRAINT `FKmoh4y7wq0bqnr9hf70j2m8hjk` FOREIGN KEY (`mascota_id`) REFERENCES `mascotas` (`id`),
  CONSTRAINT `FKmpyrctoll1n0n688uevrh2fe5` FOREIGN KEY (`trabajador_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,'REALIZADA','2026-01-05 09:00:00.000000','Chequeo anual rutinario',1,1,1),(2,'REALIZADA','2026-01-08 10:30:00.000000','Vacuna antirrábica anual',3,2,2),(3,'REALIZADA','2026-01-12 11:00:00.000000','Limpieza dental profunda',10,3,3),(4,'REALIZADA','2026-01-15 09:30:00.000000','Análisis de sangre preventivo',8,8,4),(5,'REALIZADA','2026-01-20 14:00:00.000000','Corte de raza completo',3,5,9),(6,'REALIZADA','2026-01-22 15:00:00.000000','Ecografía abdominal control',11,6,5),(7,'REALIZADA','2026-01-28 08:30:00.000000','Rayos X cadera',8,7,6),(8,'REALIZADA','2026-02-03 10:00:00.000000','Castración programada',4,4,10),(9,'REALIZADA','2026-02-05 11:30:00.000000','Vacunación completa cachorro',7,2,1),(10,'REALIZADA','2026-02-10 09:00:00.000000','Consulta por alergia al polen',5,1,2),(11,'REALIZADA','2026-02-14 14:30:00.000000','Baño medicado piel sensible',12,5,8),(12,'REALIZADA','2026-02-18 10:00:00.000000','Ovariohisterectomía',6,4,11),(13,'REALIZADA','2026-02-25 09:30:00.000000','Hemograma completo',11,8,3),(14,'REALIZADA','2026-03-01 11:00:00.000000','Profilaxis dental',2,3,4),(15,'REALIZADA','2026-03-04 08:00:00.000000','Rayos X tórax control',13,7,5),(16,'REALIZADA','2026-03-07 10:30:00.000000','Consulta soplo cardíaco',13,1,6),(17,'REALIZADA','2026-03-10 14:00:00.000000','Corte de verano',3,5,9),(18,'REALIZADA','2026-03-11 09:00:00.000000','Ecografía abdominal',5,6,1),(19,'CONFIRMADA','2026-03-14 09:00:00.000000','Control post operatorio',6,1,2),(20,'CONFIRMADA','2026-03-14 10:30:00.000000','Vacuna quíntuple refuerzo',9,2,3),(21,'CONFIRMADA','2026-03-15 09:00:00.000000','Baño y corte raza',4,5,8),(22,'CONFIRMADA','2026-03-15 11:00:00.000000','Análisis bioquímica',8,8,4),(23,'CONFIRMADA','2026-03-16 10:00:00.000000','Cirugía programada',12,4,12),(24,'CONFIRMADA','2026-03-17 09:30:00.000000','Limpieza dental',10,3,5),(25,'CONFIRMADA','2026-03-18 14:00:00.000000','Ecografía control',1,6,6),(26,'CONFIRMADA','2026-03-19 10:00:00.000000','Rayos X columna',8,7,1),(27,'PENDIENTE','2026-03-20 09:00:00.000000','Chequeo general',2,1,2),(28,'PENDIENTE','2026-03-20 11:00:00.000000','Vacunación inicial',7,2,3),(29,'PENDIENTE','2026-03-21 10:00:00.000000','Baño medicado',5,5,9),(30,'PENDIENTE','2026-03-22 09:30:00.000000','Hemograma preventivo',13,8,4),(31,'PENDIENTE','2026-03-24 14:00:00.000000','Consulta primera vez',9,1,1),(32,'PENDIENTE','2026-03-25 10:30:00.000000','Profilaxis dental programada',7,3,5),(33,'PENDIENTE','2026-03-26 09:00:00.000000','Ecografía abdominal',12,6,6),(34,'PENDIENTE','2026-03-28 11:00:00.000000','Corte primavera',4,5,8),(35,'CANCELADA','2026-02-20 09:00:00.000000','Cliente no se presentó',1,1,1),(36,'CANCELADA','2026-02-22 10:00:00.000000','Reagendada por el cliente',3,2,2),(37,'CANCELADA','2026-03-01 14:00:00.000000','Mascota enferma al momento',9,5,9),(38,'CANCELADA','2026-03-05 09:30:00.000000','Cancelado por emergencia',6,4,11);
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(255) NOT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) NOT NULL,
  `dni` varchar(255) NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKm6ysdwsqke00e5piajbvgn6lg` (`dni`),
  UNIQUE KEY `UK8duxx4vm6d736wokeq3u5skw7` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'HUAMAN CRUZ','dennis@prueba.com','Incanato 1128','73381545','DENNIS FABRIZIO','920625158'),(2,'VASQUEZ CARRASCO','emmy@emmy.com','Las Delicias','76296919','ESMERALDA MARIA ROSINA','980228236'),(3,'PEREZ SOSA','perez.sosa@email.com','Calle Los Jazmines 450','45871236','RICARDO ALBERTO','987456123'),(4,'LOPEZ VILLEGAS','ana.lopez@email.com','Av. Santa Victoria 782','71258963','ANA BEATRIZ','951753852'),(5,'TORRES MENDOZA','mendoza.t@email.com','Urb. Las Garzas B-12','10258744','LUIS ENRIQUE','963258741'),(6,'CASTILLO DIAZ','c.diaz@email.com','Calle San Jose 115','44859632','MARIA FERNANDA','941258369'),(7,'SANCHEZ RUIZ','sanchez.r@email.com','Av. Jose Leonardo Ortiz 900','72154863','CARLOS JAVIER','932145687'),(8,'MORALES PAZ','mpaz@email.com','Calle Elvira Garcia 221','09856321','GLADYS NOEMI','914785236'),(9,'CAMPOS YOVERA','campos.y@email.com','Calle Tacna 556','73365412','JOSE MIGUEL','955441122'),(10,'DURAND SILVA','durand.s@email.com','Residencial La Ensenada','46985214','PATRICIA ROSA','988774411');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `about_image_url` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `hero_video_url` varchar(255) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `site_name` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion`
--

LOCK TABLES `configuracion` WRITE;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
INSERT INTO `configuracion` VALUES (1,'https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636471/hvz05l1flliheo17z3ol.webp','','https://res.cloudinary.com/ddxdadxtr/video/upload/v1788636529/peluche_sohgi5.webm','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636440/uwmlgummex0astrscu4q.png','Huellitas Vet','');
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_ventas`
--

DROP TABLE IF EXISTS `detalle_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_ventas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int DEFAULT NULL,
  `nombre_producto` varchar(255) DEFAULT NULL,
  `precio_unitario` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `producto_id` bigint DEFAULT NULL,
  `venta_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnunx2ycrr6jfyphwmmifo6lgx` (`producto_id`),
  KEY `FK2dn1sdhrbmva44wbs9fy6l7mn` (`venta_id`),
  CONSTRAINT `FK2dn1sdhrbmva44wbs9fy6l7mn` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`),
  CONSTRAINT `FKnunx2ycrr6jfyphwmmifo6lgx` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_ventas`
--

LOCK TABLES `detalle_ventas` WRITE;
/*!40000 ALTER TABLE `detalle_ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enfermedades`
--

DROP TABLE IF EXISTS `enfermedades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enfermedades` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `gravedad` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enfermedades`
--

LOCK TABLES `enfermedades` WRITE;
/*!40000 ALTER TABLE `enfermedades` DISABLE KEYS */;
INSERT INTO `enfermedades` VALUES (1,'Enfermedad viral grave que afecta intestinos','ALTA','Parvovirus'),(2,'Afecta sistemas respiratorios, gastrointestinal y nervioso','ALTA','Distemper (Moquillo)'),(3,'Inflamación del conducto auditivo','BAJA','Otitis Externa'),(4,'Enfermedad viral que afecta el sistema inmune','ALTA','Leucemia Felina'),(5,'Infeccion bacteriana transmitida por garrapatas, causa anemia','MEDIA','Ehrlichia (Garrapata)'),(6,'Ácaros que causan picazón intensa y pérdidad de pelo','MEDIA','Sarna Sarcópita'),(7,'Fallo en la funcion de los riñones','ALTA','Insuficiencia Renal'),(8,'Virus mortal que afecta el sistema nervioso central','ALTA','Rabia');
/*!40000 ALTER TABLE `enfermedades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especie_enfermedad`
--

DROP TABLE IF EXISTS `especie_enfermedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especie_enfermedad` (
  `enfermedad_id` bigint NOT NULL,
  `especie_id` bigint NOT NULL,
  KEY `FKr6dl41tymkfkiu6pq70mjalbm` (`especie_id`),
  KEY `FKnosh1xymyf2p9xndnhqu5r3bc` (`enfermedad_id`),
  CONSTRAINT `FKnosh1xymyf2p9xndnhqu5r3bc` FOREIGN KEY (`enfermedad_id`) REFERENCES `enfermedades` (`id`),
  CONSTRAINT `FKr6dl41tymkfkiu6pq70mjalbm` FOREIGN KEY (`especie_id`) REFERENCES `especies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especie_enfermedad`
--

LOCK TABLES `especie_enfermedad` WRITE;
/*!40000 ALTER TABLE `especie_enfermedad` DISABLE KEYS */;
INSERT INTO `especie_enfermedad` VALUES (1,2),(2,2),(3,1),(3,2),(4,1),(5,2),(6,1),(6,2),(7,1),(8,1),(8,2);
/*!40000 ALTER TABLE `especie_enfermedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especies`
--

DROP TABLE IF EXISTS `especies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especies`
--

LOCK TABLES `especies` WRITE;
/*!40000 ALTER TABLE `especies` DISABLE KEYS */;
INSERT INTO `especies` VALUES (1,'Felina'),(2,'Canina');
/*!40000 ALTER TABLE `especies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_clinico`
--

DROP TABLE IF EXISTS `historial_clinico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_clinico` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cita_id` bigint DEFAULT NULL,
  `diagnostico` varchar(255) DEFAULT NULL,
  `enfermedad_detectada` varchar(255) DEFAULT NULL,
  `fecha_registro` datetime(6) DEFAULT NULL,
  `peso` double DEFAULT NULL,
  `tratamiento` text,
  `vacuna_aplicada` varchar(255) DEFAULT NULL,
  `mascota_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2fy5y2ciotoa2kexeno5ee1ys` (`mascota_id`),
  CONSTRAINT `FK2fy5y2ciotoa2kexeno5ee1ys` FOREIGN KEY (`mascota_id`) REFERENCES `mascotas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_clinico`
--

LOCK TABLES `historial_clinico` WRITE;
/*!40000 ALTER TABLE `historial_clinico` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_clinico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_vacunacion`
--

DROP TABLE IF EXISTS `historial_vacunacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_vacunacion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `documento_clinico` json DEFAULT NULL,
  `fecha_aplicacion` datetime(6) DEFAULT NULL,
  `lote` varchar(255) DEFAULT NULL,
  `nombre_vacuna` varchar(255) DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `reacciones` varchar(255) DEFAULT NULL,
  `trabajador_id` bigint DEFAULT NULL,
  `mascota_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKege4klleoo0dd0eu563ugsnmb` (`mascota_id`),
  CONSTRAINT `FKege4klleoo0dd0eu563ugsnmb` FOREIGN KEY (`mascota_id`) REFERENCES `mascotas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_vacunacion`
--

LOCK TABLES `historial_vacunacion` WRITE;
/*!40000 ALTER TABLE `historial_vacunacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_vacunacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `activo` bit(1) NOT NULL,
  `dia_semana` enum('FRIDAY','MONDAY','SATURDAY','SUNDAY','THURSDAY','TUESDAY','WEDNESDAY') NOT NULL,
  `hora_fin` time NOT NULL,
  `hora_inicio` time NOT NULL,
  `trabajador_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` VALUES (1,_binary '','MONDAY','13:00:00','08:00:00',1),(2,_binary '','TUESDAY','13:00:00','08:00:00',1),(3,_binary '','WEDNESDAY','13:00:00','08:00:00',1),(4,_binary '','THURSDAY','13:00:00','08:00:00',1),(5,_binary '','FRIDAY','13:00:00','08:00:00',1),(6,_binary '','MONDAY','19:00:00','15:00:00',1),(7,_binary '','TUESDAY','19:00:00','15:00:00',1),(8,_binary '','WEDNESDAY','19:00:00','15:00:00',1),(9,_binary '','THURSDAY','19:00:00','15:00:00',1),(10,_binary '','FRIDAY','19:00:00','15:00:00',1),(11,_binary '','SATURDAY','13:00:00','09:00:00',1),(12,_binary '','MONDAY','14:00:00','09:00:00',2),(13,_binary '','TUESDAY','14:00:00','09:00:00',2),(14,_binary '','WEDNESDAY','14:00:00','09:00:00',2),(15,_binary '','THURSDAY','14:00:00','09:00:00',2),(16,_binary '','FRIDAY','14:00:00','09:00:00',2),(17,_binary '','MONDAY','19:00:00','15:00:00',2),(18,_binary '','WEDNESDAY','19:00:00','15:00:00',2),(19,_binary '','FRIDAY','19:00:00','15:00:00',2),(20,_binary '','SATURDAY','13:00:00','09:00:00',2),(21,_binary '','MONDAY','13:00:00','08:00:00',3),(22,_binary '','TUESDAY','13:00:00','08:00:00',3),(23,_binary '','WEDNESDAY','13:00:00','08:00:00',3),(24,_binary '','THURSDAY','13:00:00','08:00:00',3),(25,_binary '','FRIDAY','13:00:00','08:00:00',3),(26,_binary '','TUESDAY','19:00:00','15:00:00',3),(27,_binary '','THURSDAY','19:00:00','15:00:00',3),(28,_binary '','SATURDAY','12:00:00','09:00:00',3),(29,_binary '','MONDAY','14:00:00','10:00:00',4),(30,_binary '','TUESDAY','14:00:00','10:00:00',4),(31,_binary '','WEDNESDAY','14:00:00','10:00:00',4),(32,_binary '','THURSDAY','14:00:00','10:00:00',4),(33,_binary '','FRIDAY','14:00:00','10:00:00',4),(34,_binary '','MONDAY','20:00:00','16:00:00',4),(35,_binary '','WEDNESDAY','20:00:00','16:00:00',4),(36,_binary '','FRIDAY','20:00:00','16:00:00',4),(37,_binary '','MONDAY','12:00:00','08:00:00',5),(38,_binary '','TUESDAY','12:00:00','08:00:00',5),(39,_binary '','WEDNESDAY','12:00:00','08:00:00',5),(40,_binary '','THURSDAY','12:00:00','08:00:00',5),(41,_binary '','FRIDAY','12:00:00','08:00:00',5),(42,_binary '','MONDAY','18:00:00','14:00:00',5),(43,_binary '','TUESDAY','18:00:00','14:00:00',5),(44,_binary '','WEDNESDAY','18:00:00','14:00:00',5),(45,_binary '','THURSDAY','18:00:00','14:00:00',5),(46,_binary '','SATURDAY','13:00:00','08:00:00',5),(47,_binary '','MONDAY','13:00:00','09:00:00',6),(48,_binary '','TUESDAY','13:00:00','09:00:00',6),(49,_binary '','WEDNESDAY','13:00:00','09:00:00',6),(50,_binary '','THURSDAY','13:00:00','09:00:00',6),(51,_binary '','FRIDAY','13:00:00','09:00:00',6),(52,_binary '','TUESDAY','19:00:00','15:00:00',6),(53,_binary '','THURSDAY','19:00:00','15:00:00',6),(54,_binary '','FRIDAY','19:00:00','15:00:00',6),(55,_binary '','SATURDAY','13:00:00','09:00:00',6),(56,_binary '','MONDAY','13:00:00','08:00:00',7),(57,_binary '','TUESDAY','13:00:00','08:00:00',7),(58,_binary '','WEDNESDAY','13:00:00','08:00:00',7),(59,_binary '','THURSDAY','13:00:00','08:00:00',7),(60,_binary '','FRIDAY','13:00:00','08:00:00',7),(61,_binary '','SATURDAY','13:00:00','08:00:00',7),(62,_binary '','MONDAY','18:00:00','14:00:00',7),(63,_binary '','TUESDAY','18:00:00','14:00:00',7),(64,_binary '','WEDNESDAY','18:00:00','14:00:00',7),(65,_binary '','THURSDAY','18:00:00','14:00:00',7),(66,_binary '','FRIDAY','18:00:00','14:00:00',7),(67,_binary '','SATURDAY','17:00:00','14:00:00',7),(68,_binary '','MONDAY','13:00:00','09:00:00',8),(69,_binary '','TUESDAY','13:00:00','09:00:00',8),(70,_binary '','WEDNESDAY','13:00:00','09:00:00',8),(71,_binary '','THURSDAY','13:00:00','09:00:00',8),(72,_binary '','FRIDAY','13:00:00','09:00:00',8),(73,_binary '','SATURDAY','14:00:00','09:00:00',8),(74,_binary '','MONDAY','18:00:00','14:00:00',8),(75,_binary '','TUESDAY','18:00:00','14:00:00',8),(76,_binary '','WEDNESDAY','18:00:00','14:00:00',8),(77,_binary '','THURSDAY','18:00:00','14:00:00',8),(78,_binary '','FRIDAY','18:00:00','14:00:00',8),(79,_binary '','MONDAY','14:00:00','10:00:00',9),(80,_binary '','TUESDAY','14:00:00','10:00:00',9),(81,_binary '','WEDNESDAY','14:00:00','10:00:00',9),(82,_binary '','THURSDAY','14:00:00','10:00:00',9),(83,_binary '','FRIDAY','14:00:00','10:00:00',9),(84,_binary '','SATURDAY','15:00:00','10:00:00',9),(85,_binary '','MONDAY','19:00:00','15:00:00',9),(86,_binary '','TUESDAY','19:00:00','15:00:00',9),(87,_binary '','WEDNESDAY','19:00:00','15:00:00',9),(88,_binary '','FRIDAY','19:00:00','15:00:00',9),(89,_binary '','MONDAY','13:00:00','07:00:00',10),(90,_binary '','TUESDAY','13:00:00','07:00:00',10),(91,_binary '','WEDNESDAY','13:00:00','07:00:00',10),(92,_binary '','THURSDAY','13:00:00','07:00:00',10),(93,_binary '','FRIDAY','13:00:00','07:00:00',10),(94,_binary '','MONDAY','17:00:00','14:00:00',10),(95,_binary '','WEDNESDAY','17:00:00','14:00:00',10),(96,_binary '','FRIDAY','17:00:00','14:00:00',10),(97,_binary '','SATURDAY','12:00:00','08:00:00',10),(98,_binary '','MONDAY','14:00:00','08:00:00',11),(99,_binary '','TUESDAY','14:00:00','08:00:00',11),(100,_binary '','WEDNESDAY','14:00:00','08:00:00',11),(101,_binary '','THURSDAY','14:00:00','08:00:00',11),(102,_binary '','FRIDAY','14:00:00','08:00:00',11),(103,_binary '','TUESDAY','18:00:00','15:00:00',11),(104,_binary '','THURSDAY','18:00:00','15:00:00',11),(105,_binary '','SATURDAY','13:00:00','09:00:00',11),(106,_binary '','MONDAY','13:30:00','07:30:00',12),(107,_binary '','TUESDAY','13:30:00','07:30:00',12),(108,_binary '','WEDNESDAY','13:30:00','07:30:00',12),(109,_binary '','THURSDAY','13:30:00','07:30:00',12),(110,_binary '','FRIDAY','13:30:00','07:30:00',12),(111,_binary '','MONDAY','18:00:00','15:00:00',12),(112,_binary '','WEDNESDAY','18:00:00','15:00:00',12),(113,_binary '','SATURDAY','12:00:00','08:00:00',12);
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascotas`
--

DROP TABLE IF EXISTS `mascotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascotas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `edad` varchar(40) NOT NULL,
  `especie` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `observaciones` text,
  `peso` double NOT NULL,
  `raza` varchar(100) NOT NULL,
  `sexo` varchar(100) NOT NULL,
  `cliente_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2an8whhtepxb34mq1khlgsum4` (`cliente_id`),
  CONSTRAINT `FK2an8whhtepxb34mq1khlgsum4` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `mascotas_chk_1` CHECK ((`peso` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascotas`
--

LOCK TABLES `mascotas` WRITE;
/*!40000 ALTER TABLE `mascotas` DISABLE KEYS */;
INSERT INTO `mascotas` VALUES (1,'4 años','Felina','Olenka','Sin observaciones médicas',23.5,'Naranjoso','Hembra',1),(2,'2 años','Felina','Apolo','Sin observaciones médicas',23.5,'Naranjoso','Macho',1),(3,'2 años','Canina','Peluche','Sin observaciones médicas',23.5,'Shih Tzu','Macho',2),(4,'3 años','Canina','Harry','Sin observaciones médicas',23.5,'Shih Tzu','Macho',2),(5,'5 años','Canina','Rambo','Alérgico al polen',25.4,'Boxer','Macho',3),(6,'3 años','Felina','Misi','Castrada recientemente',3.8,'Siamés','Hembra',4),(7,'2 meses','Felina','Pelusa','Cachorro sin vacunas',0.9,'Mestizo','Hembra',4),(8,'7 años','Canina','Bruno','Problemas de cadera',30.2,'Pastor Alemán','Macho',5),(9,'1 año','Canina','Chispita','Muy juguetona',5.1,'Poodle','Hembra',6),(10,'4 años','Canina','Zeus','Requiere limpieza dental',18.5,'Bulldog Inglés','Macho',7),(11,'6 años','Felina','Garfield','Sobrepeso leve',7.2,'Persa','Macho',8),(12,'2 años','Canina','Rex','Sin observaciones',15,'Schnauzer','Macho',9),(13,'8 años','Canina','Pelusa','Soplo al corazón leve',10.4,'Cocker Spaniel','Hembra',10);
/*!40000 ALTER TABLE `mascotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_categoria`
--

DROP TABLE IF EXISTS `producto_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto_categoria` (
  `producto_id` bigint NOT NULL,
  `categoria_id` bigint NOT NULL,
  KEY `FKck76h1dqwbw3rp8gkxkxytqe6` (`categoria_id`),
  KEY `FKfahqc7k27mgnlrr5q6oylure7` (`producto_id`),
  CONSTRAINT `FKck76h1dqwbw3rp8gkxkxytqe6` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  CONSTRAINT `FKfahqc7k27mgnlrr5q6oylure7` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_categoria`
--

LOCK TABLES `producto_categoria` WRITE;
/*!40000 ALTER TABLE `producto_categoria` DISABLE KEYS */;
INSERT INTO `producto_categoria` VALUES (1,1),(2,2),(3,3),(4,4),(5,3),(6,5),(7,6),(8,7),(9,1),(10,1),(11,2),(12,2),(13,3),(14,5),(15,6),(16,1),(17,6);
/*!40000 ALTER TABLE `producto_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `imagen_url` text,
  `nombre` varchar(100) NOT NULL,
  `precio` double NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `productos_chk_1` CHECK ((`precio` >= 0)),
  CONSTRAINT `productos_chk_2` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Protección completa contra pulgas y garrapatas.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636099/errdypfcylel82kxtamp.webp','Antiparasitarios',35,100),(2,'Nutrición balanceada adulto raza mediana.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636106/vsyqew5shltybqiutbhi.jpg','Alimento Premium',85,50),(3,'Tratamientos dermatológicos piel sensible.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636113/nxzbru9v96j1uv034twj.webp','Shampoo Medicado',45,30),(4,'Vitaminas y probióticos para cachorros.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636125/u4nwopgo2ppwz5wuyzum.avif','Suplementos',55,40),(5,'Kit de emergencia veterinaria.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636135/vb6s6vb3lkvfylntnjhc.jpg','Primeros Auxilios',65,20),(6,'Juguetes limpieza dental resistente.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636161/ub2yzumtuwyapnqm9lzh.jpg','Juguetes Dental',25,150),(7,'Collares para paseos nocturnos.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636169/u1ulvfdnpedwstvficzy.jpg','Collar Reflectivo',15,80),(8,'Premios nutritivos sabor pollo.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636176/fvi4bot5q79rtksalaza.jpg','Snacks Saludables',20,200),(9,'Pastilla masticable antipulgas 3 meses.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636185/fggmgujuujzpxdaktt8t.jpg','Bravecto 10-20kg',120,60),(10,'Antipulgas y desparasitante interno.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636194/i5f1lfawg2l5i0yux4y2.webp','Nexgard Spectra',65,80),(11,'Alimento prescripción riñones k/d.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636202/ocobxkpkedlfwkfikjqt.jpg','Hills Science Diet',150,25),(12,'Alimento nacional premium 15kg.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636225/dwljfbrqpu3ytihswjpp.webp','Ricocan Cordero',95,40),(13,'Aglutinante aroma lavanda 10kg.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636634/hqyyfaixdui3og84skbh.webp','Arena para Gatos',30,100),(14,'Árbol para gatos 3 niveles.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636645/c2yz9ahjdnl2hzvqpebf.jpg','Rascador Torre',180,15),(15,'Cama viscoelástica para perros mayores.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636653/xok1m9qunytcqbgw0adj.jpg','Cama Ortopédica',200,10),(16,'Antipulgas tópico gatos.','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636661/nedkd4va2et9azaajfrm.webp','Pipeta Frontline',35,90),(17,'Bozal para Perro','https://res.cloudinary.com/ddxdadxtr/image/upload/v1788636720/xtfhia2f5plikp0ookvx.jpg','Flexi Muzzle',35,10);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKldv0v52e0udsh2h1rs0r0gw1n` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_USER'),(3,'ROLE_VET');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT NULL,
  `icono` varchar(100) NOT NULL DEFAULT 'pets',
  `nombre` varchar(100) NOT NULL,
  `precio` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `servicios_chk_1` CHECK ((`precio` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'Chequeo completo de salud.','ACTIVO','stethoscope','Consulta General',50),(2,'Aplicación de vacunas anuales.','ACTIVO','vaccines','Vacunación',45),(3,'Limpieza profunda con ultrasonido.','ACTIVO','dentistry','Profilaxis Dental',120),(4,'Castración y Ovariohisterectomía.','ACTIVO','medical_services','Cirugía Esterilización',250),(5,'Corte de raza, baño medicado.','ACTIVO','content_cut','Baño y Corte',60),(6,'Imágenes de diagnóstico.','ACTIVO','radiology','Ecografía Abdominal',100),(7,'Placas radiográficas digitales.','ACTIVO','skeleton','Rayos X',80),(8,'Hemograma y Bioquímica.','ACTIVO','science','Análisis de Sangre',70),(9,'Cuidado por día incluye paseos.','ACTIVO','home','Hospedaje',40);
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trabajador_servicio`
--

DROP TABLE IF EXISTS `trabajador_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trabajador_servicio` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `servicio_id` bigint NOT NULL,
  `trabajador_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbmx71jehhivlfjrpwyv21e0im` (`servicio_id`),
  KEY `FKc6xek4vqc0h28akjb4l6l1asc` (`trabajador_id`),
  CONSTRAINT `FKbmx71jehhivlfjrpwyv21e0im` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`),
  CONSTRAINT `FKc6xek4vqc0h28akjb4l6l1asc` FOREIGN KEY (`trabajador_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabajador_servicio`
--

LOCK TABLES `trabajador_servicio` WRITE;
/*!40000 ALTER TABLE `trabajador_servicio` DISABLE KEYS */;
INSERT INTO `trabajador_servicio` VALUES (1,1,1),(2,2,1),(3,3,1),(4,6,1),(5,7,1),(6,8,1),(7,1,2),(8,2,2),(9,3,2),(10,6,2),(11,7,2),(12,8,2),(13,1,3),(14,2,3),(15,3,3),(16,6,3),(17,7,3),(18,8,3),(19,1,4),(20,2,4),(21,3,4),(22,6,4),(23,7,4),(24,8,4),(25,1,5),(26,2,5),(27,3,5),(28,6,5),(29,7,5),(30,8,5),(31,1,6),(32,2,6),(33,3,6),(34,6,6),(35,7,6),(36,8,6),(37,1,10),(38,2,10),(39,4,10),(40,6,10),(41,7,10),(42,8,10),(43,1,11),(44,2,11),(45,4,11),(46,6,11),(47,7,11),(48,8,11),(49,1,12),(50,2,12),(51,4,12),(52,6,12),(53,7,12),(54,8,12),(55,5,8),(56,5,9),(57,9,7);
/*!40000 ALTER TABLE `trabajador_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trabajadores`
--

DROP TABLE IF EXISTS `trabajadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trabajadores` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(255) NOT NULL,
  `cargo` enum('CIRUJANO','ESTILISTA','RECEPCIONISTA','VETERINARIO') DEFAULT NULL,
  `correo` varchar(255) NOT NULL,
  `dni` varchar(255) DEFAULT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT NULL,
  `nombres` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6li210jqt10hev0wj6qj482xs` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabajadores`
--

LOCK TABLES `trabajadores` WRITE;
/*!40000 ALTER TABLE `trabajadores` DISABLE KEYS */;
INSERT INTO `trabajadores` VALUES (1,'ZUMAETA GOLAC','VETERINARIO','jufer@vethuellitas.com','71374454','ACTIVO','JUNIOR FERNANDO','987654321'),(2,'RAMIREZ LOPEZ','VETERINARIO','carla@vethuellitas.com','74561234','ACTIVO','CARLA ANDREA','912345678'),(3,'TORRES VASQUEZ','VETERINARIO','luis@vethuellitas.com','75678901','ACTIVO','LUIS MIGUEL','923456789'),(4,'MENDOZA FLORES','VETERINARIO','ricardo@vethuellitas.com','79012345','ACTIVO','RICARDO DANIEL','967890123'),(5,'GARCIA CHAVEZ','VETERINARIO','paola@vethuellitas.com','70123456','ACTIVO','PAOLA ESTEFANIA','978901234'),(6,'ORTIZ CAMPOS','VETERINARIO','martin@vethuellitas.com','73456789','ACTIVO','MARTIN EDUARDO','901234567'),(7,'CASTILLO RUIZ','RECEPCIONISTA','maria@vethuellitas.com','76789012','ACTIVO','MARIA FERNANDA','934567890'),(8,'RODRIGUEZ PEREZ','ESTILISTA','elena@vethuellitas.com','78901234','ACTIVO','ELENA SOFIA','956789012'),(9,'VARGAS QUISPE','ESTILISTA','diego@vethuellitas.com','71234567','ACTIVO','DIEGO ARMANDO','989012345'),(10,'HUAMAN CRUZ','CIRUJANO','fabrizio@vethuellitas.com','73381545','ACTIVO','DENNIS FABRIZIO','920625158'),(11,'SANCHEZ DIAZ','CIRUJANO','jorge@vethuellitas.com','77890123','ACTIVO','JORGE ALBERTO','945678901'),(12,'RIVERA SALAZAR','CIRUJANO','ana@vethuellitas.com','72345678','ACTIVO','ANA LUCIA','990123456'),(13,'HUAMAN CRUZ','VETERINARIO','cristian@vethuellitas.com','73381544','ACTIVO','CRISTIAN JESUS','907608480');
/*!40000 ALTER TABLE `trabajadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `correo` varchar(255) NOT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `cliente_id` bigint DEFAULT NULL,
  `trabajador_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKcdmw5hxlfj78uf4997i3qyyw5` (`correo`),
  UNIQUE KEY `UKsuh64qcx0h83ynm45sm2r2lk7` (`cliente_id`),
  UNIQUE KEY `UK8jqdyo4t8a1gsh6jenis9nbhk` (`trabajador_id`),
  CONSTRAINT `FKdx76w4skuwj8wldmr7ebfyegq` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `FKtyc2duv3beltdp4blvsl1p8m` FOREIGN KEY (`trabajador_id`) REFERENCES `trabajadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'jufer@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,1),(2,'carla@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,2),(3,'luis@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,3),(4,'ricardo@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,4),(5,'paola@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,5),(6,'martin@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,6),(7,'maria@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,7),(8,'elena@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,8),(9,'diego@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,9),(10,'dennis@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,10),(11,'jorge@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,11),(12,'ana@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,12),(13,'cristian@vethuellitas.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',NULL,13),(14,'dennis@prueba.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',1,NULL),(15,'emmy@emmy.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',2,NULL),(16,'perez.sosa@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',3,NULL),(17,'ana.lopez@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',4,NULL),(18,'mendoza.t@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',5,NULL),(19,'c.diaz@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',6,NULL),(20,'sanchez.r@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',7,NULL),(21,'mpaz@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',8,NULL),(22,'campos.y@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',9,NULL),(23,'durand.s@email.com','ACTIVO','$2a$12$fIpHfhGambfFnIAXfn/sQuxP1LKWjttL9YKmaFO5QdETmyFg2qOCm',10,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_roles`
--

DROP TABLE IF EXISTS `usuarios_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_roles` (
  `usuario_id` bigint NOT NULL,
  `rol_id` bigint NOT NULL,
  PRIMARY KEY (`usuario_id`,`rol_id`),
  KEY `FK5338ehgluufgc8bpj08nrq970` (`rol_id`),
  CONSTRAINT `FK5338ehgluufgc8bpj08nrq970` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FKqcxu02bqipxpr7cjyj9dmhwec` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_roles`
--

LOCK TABLES `usuarios_roles` WRITE;
/*!40000 ALTER TABLE `usuarios_roles` DISABLE KEYS */;
INSERT INTO `usuarios_roles` VALUES (13,1),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3),(12,3);
/*!40000 ALTER TABLE `usuarios_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacunas`
--

DROP TABLE IF EXISTS `vacunas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vacunas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dosis` int NOT NULL,
  `edad_recomendada` int NOT NULL,
  `enfermedad_asociada` varchar(100) NOT NULL,
  `fabricante` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `vacunas_chk_1` CHECK ((`dosis` >= 0)),
  CONSTRAINT `vacunas_chk_2` CHECK ((`edad_recomendada` >= 0)),
  CONSTRAINT `vacunas_chk_3` CHECK ((`precio` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacunas`
--

LOCK TABLES `vacunas` WRITE;
/*!40000 ALTER TABLE `vacunas` DISABLE KEYS */;
INSERT INTO `vacunas` VALUES (1,1,1,'Parvovirus y Distemper','MSD Animal Health','Nobivac Puppy DP',45),(2,2,2,'Lab-Vet','Antirrábica','Parvovirus',45),(3,1,2,'Distemper, Adenovirus, Parvovirus, Parainfluenza','Zoetis','Vanguard Plus 5 (Quíntuple)',55),(4,1,3,'Quíntuple + Lepto','Boehringer Ingelheim','Recombitek C6 (Séptuple)',65),(5,1,3,'Tos de las Perreras (Bordetella)','Zoetis','Bronchi-Shield (KC)',40),(6,2,4,'Giardia Lamblia','Zoetis','GiardiaVax',50),(7,1,2,'Rinotraqueitis, Calicivirus, Panleucopenia','Zoetis','Felocell 3 (Triple Felina)',45),(8,1,3,'Leucemia Felina','Virbac','Leucogen',60),(9,1,2,'Calicivirus, Herpesvirus, Panleucopenia','MSD','Nobivac Tricat Trio',50),(10,1,4,'Rabia','Boehringer Ingelheim','Rabisin',35);
/*!40000 ALTER TABLE `vacunas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `codigo_operacion` varchar(255) DEFAULT NULL,
  `estado` enum('CANCELADA','COMPLETADA','PENDIENTE') DEFAULT NULL,
  `fecha` datetime(6) DEFAULT NULL,
  `metodo_pago` varchar(255) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `cliente_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4dgjhccl2uuo8swmxlxb4ipb5` (`cliente_id`),
  CONSTRAINT `FK4dgjhccl2uuo8swmxlxb4ipb5` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-05 15:11:10
