/*
mysql> SELECT HEX(INET6_ATON('fdfe::5a55:caff:fefa:9089'));
        -> 'FDFE0000000000005A55CAFFFEFA9089'
mysql> SELECT HEX(INET6_ATON('10.0.5.9'));
        -> '0A000509'
  function has the VARBINARY data type: VARBINARY(16) for IPv6 addresses and
  VARBINARY(4) for IPv4 addresses. If the argument is not a valid address, INET6_ATON() returns NULL.


  */

CREATE DATABASE IF NOT EXISTS `exim_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `exim_db`;

DROP TABLE IF EXISTS `cache_rbl`;
CREATE TABLE `cache_rbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varbinary(16) NOT NULL,
  `kill` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `domain`;
CREATE TABLE `domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

