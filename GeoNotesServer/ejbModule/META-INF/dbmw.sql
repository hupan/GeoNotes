/*
Navicat MySQL Data Transfer

Source Server         : dbmwCon
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : dbmw

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2013-02-28 22:45:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `PATH`
-- ----------------------------
DROP TABLE IF EXISTS `PATH`;
CREATE TABLE `PATH` (
  `PATH_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PATH_STARTPOINT` int(11) NOT NULL,
  `PATH_ENDPOINT` int(11) NOT NULL,
  `PATH_ORDER` int(11) DEFAULT NULL,
  `ROUTE_ROUTE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PATH_ID`),
  KEY `PATH_STARTPOINT` (`PATH_STARTPOINT`),
  KEY `PATH_ENDPOINT` (`PATH_ENDPOINT`),
  KEY `FK_PATH_ROUTE_ROUTE_ID` (`ROUTE_ROUTE_ID`),
  CONSTRAINT `FK_PATH_ROUTE_ROUTE_ID` FOREIGN KEY (`ROUTE_ROUTE_ID`) REFERENCES `ROUTE` (`ROUTE_ID`),
  CONSTRAINT `PATH_IBFK_1` FOREIGN KEY (`PATH_STARTPOINT`) REFERENCES `PLACE` (`PLACE_ID`),
  CONSTRAINT `PATH_IBFK_2` FOREIGN KEY (`PATH_ENDPOINT`) REFERENCES `PLACE` (`PLACE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of PATH
-- ----------------------------
INSERT INTO `PATH` VALUES ('141', '32', '43', '0', '53');
INSERT INTO `PATH` VALUES ('160', '35', '37', '0', '55');
INSERT INTO `PATH` VALUES ('161', '35', '38', '1', '52');
INSERT INTO `PATH` VALUES ('162', '37', '35', '0', '52');
INSERT INTO `PATH` VALUES ('163', '32', '35', '1', '54');
INSERT INTO `PATH` VALUES ('164', '43', '32', '0', '54');
INSERT INTO `PATH` VALUES ('165', '29', '32', '1', '50');
INSERT INTO `PATH` VALUES ('166', '31', '29', '0', '50');
INSERT INTO `PATH` VALUES ('167', '32', '35', '2', '50');
INSERT INTO `PATH` VALUES ('168', '37', '44', '1', '56');
INSERT INTO `PATH` VALUES ('169', '35', '37', '0', '56');
INSERT INTO `PATH` VALUES ('173', '47', '32', '1', '58');
INSERT INTO `PATH` VALUES ('174', '43', '47', '0', '58');
INSERT INTO `PATH` VALUES ('175', '32', '35', '2', '57');
INSERT INTO `PATH` VALUES ('176', '31', '32', '1', '57');
INSERT INTO `PATH` VALUES ('177', '43', '31', '0', '57');
INSERT INTO `PATH` VALUES ('178', '31', '35', '0', '51');

-- ----------------------------
-- Table structure for `PLACE`
-- ----------------------------
DROP TABLE IF EXISTS `PLACE`;
CREATE TABLE `PLACE` (
  `PLACE_NAME` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `PLACE_LONGITUDE` double DEFAULT NULL,
  `PLACE_LATITUDE` double DEFAULT NULL,
  `PLACE_HEIGHT` double DEFAULT NULL,
  `PLACE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PLACE_DESCRIPTION` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PLACE_ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`PLACE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of PLACE
-- ----------------------------
INSERT INTO `PLACE` VALUES ('wawawa', '4.387243', '45.4283791', '0', '2013-02-08 21:35:30', 'se', '29');
INSERT INTO `PLACE` VALUES ('se', '4.387308', '45.428401199999996', '0', '2013-02-10 16:57:14', 'se', '31');
INSERT INTO `PLACE` VALUES ('Name', '4.3872585', '45.4283523', '0', '2013-02-10 17:52:44', 'Description', '32');
INSERT INTO `PLACE` VALUES ('hupan', '4.3872215', '45.428323899999995', '0', '2013-02-10 18:41:34', 'se', '35');
INSERT INTO `PLACE` VALUES ('myhome', '4.3872934', '45.4283356', '0', '2013-02-14 20:05:51', 'my home', '36');
INSERT INTO `PLACE` VALUES ('Name', '4.3873462', '45.4283836', '0', '2013-02-24 23:32:00', 'se', '37');
INSERT INTO `PLACE` VALUES ('PLACE_A', '4.3873131999999995', '45.4284116', '0', '2013-02-28 19:02:07', 'This is the first PLACE', '38');
INSERT INTO `PLACE` VALUES ('Name', '4.3873779', '45.428423099999996', '0', '2013-02-28 19:09:01', 'Description', '43');
INSERT INTO `PLACE` VALUES ('ThisNote', '4.3873271', '45.4284204', '0', '2013-02-28 19:45:19', 'this is a note', '44');
INSERT INTO `PLACE` VALUES ('foo', '4.3873083', '45.428388399999996', '0', '2013-02-28 21:55:17', 'bar', '47');

-- ----------------------------
-- Table structure for `ROUTE`
-- ----------------------------
DROP TABLE IF EXISTS `ROUTE`;
CREATE TABLE `ROUTE` (
  `ROUTE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROUTE_NAME` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ROUTE_COMMENT` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ROUTE_DISTANCE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ROUTE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ROUTE
-- ----------------------------
INSERT INTO `ROUTE` VALUES ('50', 'se', 'ses', '10');
INSERT INTO `ROUTE` VALUES ('51', 'ROUTEs', 'another ROUTE leading to hupan', '11');
INSERT INTO `ROUTE` VALUES ('52', 'nameNew', 'this is a new ROUTE', '22');
INSERT INTO `ROUTE` VALUES ('53', 'ROUTE_a', 'This is ROUTE A.', '11');
INSERT INTO `ROUTE` VALUES ('54', 'PATH2', 'this is PATH2', '15');
INSERT INTO `ROUTE` VALUES ('55', 'ROUTEA', 'this is ROUTE A', '10');
INSERT INTO `ROUTE` VALUES ('56', 'Apple', 'apple', '13');
INSERT INTO `ROUTE` VALUES ('57', 'mylittleROUTE', 'this is a little ROUTE of mine', '16');
INSERT INTO `ROUTE` VALUES ('58', 'mylittleROUTE', 'this is my ROUTE', '11');

-- ----------------------------
-- Table structure for `stat`
-- ----------------------------
DROP TABLE IF EXISTS `STAT`;
CREATE TABLE `STAT` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date DEFAULT NULL,
  `TIMEUSED` bigint(20) DEFAULT NULL,
  `STATROUTE_ROUTE_ID` int(11) DEFAULT NULL,
  `STATUSER_USER_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_STAT_STATROUTE_ROUTE_ID` (`STATROUTE_ROUTE_ID`),
  KEY `FK_STAT_STATUSER_USER_NAME` (`STATUSER_USER_NAME`),
  CONSTRAINT `FK_STAT_STATROUTE_ROUTE_ID` FOREIGN KEY (`STATROUTE_ROUTE_ID`) REFERENCES `ROUTE` (`ROUTE_ID`),
  CONSTRAINT `FK_STAT_STATUSER_USER_NAME` FOREIGN KEY (`STATUSER_USER_NAME`) REFERENCES `USER` (`USER_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of stat
-- ----------------------------
INSERT INTO `STAT` VALUES ('5', '2013-02-23', '8115', '50', 'again');
INSERT INTO `STAT` VALUES ('6', '2013-02-24', '8664', '51', 'again');
INSERT INTO `STAT` VALUES ('7', '2013-02-28', '5943', '51', 'again');
INSERT INTO `STAT` VALUES ('8', '2013-02-28', '24960', '55', 'again');
INSERT INTO `STAT` VALUES ('9', '2013-02-28', '7753', '55', 'again');
INSERT INTO `STAT` VALUES ('10', '2013-02-28', '9024', '55', 'again');
INSERT INTO `STAT` VALUES ('11', '2013-02-28', '24916', '51', 'again');
INSERT INTO `STAT` VALUES ('12', '2013-02-28', '9295', '56', 'again');
INSERT INTO `STAT` VALUES ('13', '2013-02-28', '64226', '51', 'again');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `USER`;
CREATE TABLE `USER` (
  `USER_NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `USER_PRIORITY` int(11) DEFAULT NULL,
  `USER_PWD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`USER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `USER` VALUES ('again', '0', 'again');
INSERT INTO `USER` VALUES ('apple', '0', 'apple');
INSERT INTO `USER` VALUES ('pear', '0', 'pear');
INSERT INTO `USER` VALUES ('se', '0', 'se');
INSERT INTO `USER` VALUES ('sha', '1', 'sanguo');
