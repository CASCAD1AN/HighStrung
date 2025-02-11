-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: HighStrung
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Composers`
--

DROP TABLE IF EXISTS `Composers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Composers` (
  `composerID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  PRIMARY KEY (`composerID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Composers`
--

LOCK TABLES `Composers` WRITE;
/*!40000 ALTER TABLE `Composers` DISABLE KEYS */;
INSERT INTO `Composers` VALUES (1,'Johann Sebastian','Bach'),(2,'Wolfgang Amadeus','Mozart'),(3,'Fernando','Sor'),(4,'Max','Bruch');
/*!40000 ALTER TABLE `Composers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Instruments`
--

DROP TABLE IF EXISTS `Instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Instruments` (
  `instrumentID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `comment` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`instrumentID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Instruments`
--

LOCK TABLES `Instruments` WRITE;
/*!40000 ALTER TABLE `Instruments` DISABLE KEYS */;
INSERT INTO `Instruments` VALUES (1,'Violin',NULL),(2,'Guitar',NULL),(3,'Piano',NULL);
/*!40000 ALTER TABLE `Instruments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lessons`
--

DROP TABLE IF EXISTS `Lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lessons` (
  `lessonID` int NOT NULL AUTO_INCREMENT,
  `studentID` int NOT NULL,
  `instrumentID` int NOT NULL,
  `date` date NOT NULL,
  `comment` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`lessonID`),
  KEY `fk_Lessons_Students` (`studentID`),
  KEY `fk_Lessons_Instruments` (`instrumentID`),
  CONSTRAINT `fk_Lessons_Instruments` FOREIGN KEY (`instrumentID`) REFERENCES `Instruments` (`instrumentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_Lessons_Students` FOREIGN KEY (`studentID`) REFERENCES `Students` (`studentID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lessons`
--

LOCK TABLES `Lessons` WRITE;
/*!40000 ALTER TABLE `Lessons` DISABLE KEYS */;
INSERT INTO `Lessons` VALUES (1,1,1,'2025-01-20',NULL),(2,2,1,'2025-01-27',NULL),(3,5,3,'2025-01-27','Begin learning Mozart 2nd mov.'),(4,6,2,'2025-01-29',NULL),(5,1,1,'2025-01-27',NULL),(6,2,2,'2025-01-27',NULL);
/*!40000 ALTER TABLE `Lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pieces`
--

DROP TABLE IF EXISTS `Pieces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pieces` (
  `pieceID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `instrumentID` int NOT NULL,
  `composerID` int NOT NULL,
  PRIMARY KEY (`pieceID`),
  KEY `fk_Pieces_Instruments` (`instrumentID`),
  KEY `fk_Pieces_Composers` (`composerID`),
  CONSTRAINT `fk_Pieces_Composers` FOREIGN KEY (`composerID`) REFERENCES `Composers` (`composerID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_Pieces_Instruments` FOREIGN KEY (`instrumentID`) REFERENCES `Instruments` (`instrumentID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pieces`
--

LOCK TABLES `Pieces` WRITE;
/*!40000 ALTER TABLE `Pieces` DISABLE KEYS */;
INSERT INTO `Pieces` VALUES (1,'Partita No.3 in E major, BWV 1006',1,1),(2,'Invention in C major, BWV 772',3,1),(3,'Scottish Fantasy, Op.46',1,4),(4,'Sonata No.16 in C major, K.545',3,2),(5,'Introduction and Variations on a Theme by Mozart, Op.9',2,3);
/*!40000 ALTER TABLE `Pieces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StudentInstrument`
--

DROP TABLE IF EXISTS `StudentInstrument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StudentInstrument` (
  `studentID` int NOT NULL,
  `instrumentID` int NOT NULL,
  `status` enum('Owned','Rented') NOT NULL,
  PRIMARY KEY (`studentID`,`instrumentID`),
  KEY `fk_StudentInstrument_Instruments` (`instrumentID`),
  CONSTRAINT `fk_StudentInstrument_Instruments` FOREIGN KEY (`instrumentID`) REFERENCES `Instruments` (`instrumentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_StudentInstrument_Students` FOREIGN KEY (`studentID`) REFERENCES `Students` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StudentInstrument`
--

LOCK TABLES `StudentInstrument` WRITE;
/*!40000 ALTER TABLE `StudentInstrument` DISABLE KEYS */;
INSERT INTO `StudentInstrument` VALUES (1,1,'Owned'),(2,1,'Rented'),(2,2,'Rented'),(5,3,'Owned'),(6,2,'Owned');
/*!40000 ALTER TABLE `StudentInstrument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StudentPiece`
--

DROP TABLE IF EXISTS `StudentPiece`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StudentPiece` (
  `studentID` int NOT NULL,
  `pieceID` int NOT NULL,
  `dateAssigned` date NOT NULL,
  `dateCompleted` date DEFAULT NULL,
  PRIMARY KEY (`studentID`,`pieceID`),
  KEY `fk_StudentPiece_Pieces` (`pieceID`),
  CONSTRAINT `fk_StudentPiece_Pieces` FOREIGN KEY (`pieceID`) REFERENCES `Pieces` (`pieceID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_StudentPiece_Students` FOREIGN KEY (`studentID`) REFERENCES `Students` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StudentPiece`
--

LOCK TABLES `StudentPiece` WRITE;
/*!40000 ALTER TABLE `StudentPiece` DISABLE KEYS */;
INSERT INTO `StudentPiece` VALUES (1,1,'2024-12-09',NULL),(1,3,'2024-11-11',NULL),(2,1,'2024-10-28','2025-01-27'),(2,5,'2024-11-04',NULL),(5,2,'2024-11-04',NULL),(5,4,'2024-11-11',NULL),(6,5,'2024-06-11','2024-09-23');
/*!40000 ALTER TABLE `StudentPiece` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Students` (
  `studentID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `streetAddress` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zipCode` varchar(15) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `parentFirstName` varchar(50) DEFAULT NULL,
  `parentLastName` varchar(50) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`studentID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
INSERT INTO `Students` VALUES (1,'Jonathan','McCoy','7556 Elgin St','Irving','Iowa','47125','(594) 273-5475','jonathan.mccoy@example.com','Roberta','Elliot',1),(2,'Gary','Collins','8748 Adams St','Los Lunas','New Jersey','29784','(972) 960-8131','gary.collins@example.com','Marcia','Collins',1),(3,'Johnny','Fleming','4623 E Sandy Lake Rd','Princeton','Maine','78296','(577) 536-0700','johnny.fleming@example.com','Gloria','Fleming',0),(4,'James','Jones','6546 Spring Hill Rd','Fort Collins','North Carolina','21782','(847) 304-0243','james.jones@example.com','Grace','Jones',0),(5,'Kristin','Bryant','8251 Sunset St','Topeka','Nevada','16396','(655) 547-8159','kristin.bryant@example.com','Andy','Bryant',1),(6,'Bessie','Douglas','4449 Cackson St','El Monte','Nevada','46077','(947) 330-4671','bessie.douglas@example.com',NULL,NULL,1);
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-03 19:24:48
