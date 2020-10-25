/* SQL Manager for MySQL                              5.7.2.52112 */
/* -------------------------------------------------------------- */
/* Host     : localhost                                           */
/* Port     : 3306                                                */
/* Database : wk_teste                                            */


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES 'utf8' */;

SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `wk_teste`;

CREATE DATABASE `wk_teste`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `wk_teste`;

/* Dropping database objects */

DROP TABLE IF EXISTS `produto`;
DROP TABLE IF EXISTS `pedido_item`;
DROP TABLE IF EXISTS `pedido`;
DROP TABLE IF EXISTS `cliente`;

/* Structure for the `cliente` table : */

CREATE TABLE `cliente` (
  `CODIGO_CLIENTE` INTEGER(11) NOT NULL,
  `NOME` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `CIDADE` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `UF` VARCHAR(2) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`CODIGO_CLIENTE`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `pedido` table : */

CREATE TABLE `pedido` (
  `NUMERO_PEDIDO` INTEGER(11) NOT NULL,
  `DATA_EMISSAO` DATE DEFAULT NULL,
  `CODIGO_CLIENTE` INTEGER(11) DEFAULT NULL,
  `VALOR_TOTAL` DECIMAL(15,2) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`NUMERO_PEDIDO`),
  KEY `FK_PEDIDO_1` USING BTREE (`CODIGO_CLIENTE`),
  CONSTRAINT `FK_PEDIDO_1` FOREIGN KEY (`CODIGO_CLIENTE`) REFERENCES `cliente` (`CODIGO_CLIENTE`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `pedido_item` table : */

CREATE TABLE `pedido_item` (
  `id_item` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `NUMERO_PEDIDO` INTEGER(11) NOT NULL,
  `CODIGO_PRODUTO` INTEGER(11) NOT NULL,
  `QUANTIDADE` INTEGER(11) DEFAULT NULL,
  `VLR_UNITARIO` DECIMAL(10,0) DEFAULT NULL,
  `VLR_TOTAL` DECIMAL(10,0) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`id_item`)
) ENGINE=InnoDB
AUTO_INCREMENT=21 ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `produto` table : */

CREATE TABLE `produto` (
  `CODIGO_PRODUTO` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `PRECO_VENDA` DECIMAL(15,2) NOT NULL,
  PRIMARY KEY USING BTREE (`CODIGO_PRODUTO`)
) ENGINE=InnoDB
AUTO_INCREMENT=21 ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Data for the `cliente` table  (LIMIT 0,500) */

INSERT INTO `cliente` (`CODIGO_CLIENTE`, `NOME`, `CIDADE`, `UF`) VALUES
  (1,'Cliente 01','Belo Horizonte','MG'),
  (2,'Cliente 02','Belo Horizonte','MG'),
  (3,'Cliente 03','Belo Horizonte','MG'),
  (4,'Cliente 04','Belo Horizonte','MG'),
  (5,'Cliente 05','Belo Horizonte','MG'),
  (6,'Cliente 06','Belo Horizonte','MG'),
  (7,'Cliente 07','Belo Horizonte','MG'),
  (8,'Cliente 08','Belo Horizonte','MG'),
  (9,'Cliente 09','Belo Horizonte','MG'),
  (10,'Cliente 10','Belo Horizonte','MG'),
  (11,'Cliente 11','Belo Horizonte','MG'),
  (12,'Cliente 12','Belo Horizonte','MG'),
  (13,'Cliente 13','Belo Horizonte','MG'),
  (14,'Cliente 14','Belo Horizonte','MG'),
  (15,'Cliente 15','Belo Horizonte','MG'),
  (16,'Cliente 16','Belo Horizonte','MG'),
  (17,'Cliente 17','Belo Horizonte','MG'),
  (18,'Cliente 18','Belo Horizonte','MG'),
  (19,'Cliente 19','Belo Horizonte','MG'),
  (20,'Cliente 20','Belo Horizonte','MG');
COMMIT;

/* Data for the `pedido` table  (LIMIT 0,500) */

INSERT INTO `pedido` (`NUMERO_PEDIDO`, `DATA_EMISSAO`, `CODIGO_CLIENTE`, `VALOR_TOTAL`) VALUES
  (13,'2020-10-25',15,33.00),
  (14,'2020-10-25',5,30.00);
COMMIT;

/* Data for the `pedido_item` table  (LIMIT 0,500) */

INSERT INTO `pedido_item` (`id_item`, `NUMERO_PEDIDO`, `CODIGO_PRODUTO`, `QUANTIDADE`, `VLR_UNITARIO`, `VLR_TOTAL`) VALUES
  (7,14,6,20,1,20),
  (8,14,5,10,1,10),
  (12,13,15,10,1,13),
  (13,13,15,10,1,13),
  (14,13,20,20,1,20);
COMMIT;

/* Data for the `produto` table  (LIMIT 0,500) */

INSERT INTO `produto` (`CODIGO_PRODUTO`, `DESCRICAO`, `PRECO_VENDA`) VALUES
  (1,'ABACAXI',1.00),
  (2,'MANGA',1.00),
  (3,'GOIBA',1.00),
  (4,'ACAI',1.00),
  (5,'ACEROLA',1.00),
  (6,'AMORA',1.00),
  (7,'BANANA',1.00),
  (8,'ARATICUM',1.00),
  (9,'CACAU',1.00),
  (10,'CAJA',1.00),
  (11,'CAQUI',1.50),
  (12,'CARAMBOLA',2.00),
  (13,'CEREJA',3.50),
  (14,'CIDRA',1.75),
  (15,'LARANJA',1.30),
  (16,'UVA',1.45),
  (17,'COCO',1.00),
  (18,'CUPUAÇU',1.00),
  (19,'FIGO',1.00),
  (20,'FRAMBOESA',1.00);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;