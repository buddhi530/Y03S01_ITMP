-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.11-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;



CREATE DATABASE IF NOT EXISTS `timetablemanagementsystem` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `timetablemanagementsystem`;

-- Dumping structure for table timetablemanagementsystem.academicyearandsemester
CREATE TABLE IF NOT EXISTS `academicyearandsemester` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `yearName` varchar(100) NOT NULL,
  `semesterName` varchar(100) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.building
CREATE TABLE IF NOT EXISTS `building` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `center` varchar(100) NOT NULL,
  `building` varchar(100) NOT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.consectivesession
CREATE TABLE IF NOT EXISTS `consectivesession` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` int(11) DEFAULT NULL,
  `consectiveId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_keyConsectiveSessionId` (`sessionId`),
  KEY `fk_keyconsectiveId` (`consectiveId`),
  CONSTRAINT `fk_keyConsectiveSessionId` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`) ON DELETE CASCADE,
  CONSTRAINT `fk_keyconsectiveId` FOREIGN KEY (`consectiveId`) REFERENCES `session` (`sessionId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.department
CREATE TABLE IF NOT EXISTS `department` (
  `dId` int(11) NOT NULL AUTO_INCREMENT,
  `departmentName` varchar(30) NOT NULL,
  PRIMARY KEY (`dId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.lecturer
CREATE TABLE IF NOT EXISTS `lecturer` (
  `employeeId` int(6) unsigned NOT NULL,
  `employeeName` varchar(30) NOT NULL,
  `faculty` varchar(30) DEFAULT NULL,
  `departmentId` int(11) DEFAULT NULL,
  `designation` varchar(100) NOT NULL,
  `center` varchar(50) DEFAULT NULL,
  `buildingId` int(11) DEFAULT NULL,
  `level` int(1) NOT NULL,
  `ranks` varchar(8) NOT NULL,
  PRIMARY KEY (`employeeId`),
  KEY `buildingId` (`buildingId`),
  KEY `departmentId` (`departmentId`),
  CONSTRAINT `lecturer_ibfk_1` FOREIGN KEY (`buildingId`) REFERENCES `building` (`bid`) ON DELETE CASCADE,
  CONSTRAINT `lecturer_ibfk_2` FOREIGN KEY (`departmentId`) REFERENCES `department` (`dId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.maingroup
CREATE TABLE IF NOT EXISTS `maingroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mgroupName` varchar(100) NOT NULL,
  `groupNumber` int(11) DEFAULT NULL,
  `groupid` varchar(100) NOT NULL,
  `programmeid` int(11) DEFAULT NULL,
  `semid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `programmeid` (`programmeid`),
  KEY `semid` (`semid`),
  CONSTRAINT `maingroup_ibfk_1` FOREIGN KEY (`programmeid`) REFERENCES `programme` (`programmeid`) ON DELETE CASCADE,
  CONSTRAINT `maingroup_ibfk_2` FOREIGN KEY (`semid`) REFERENCES `academicyearandsemester` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.notavailablegroup
CREATE TABLE IF NOT EXISTS `notavailablegroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` varchar(20) DEFAULT NULL,
  `toTime` time DEFAULT NULL,
  `fromTime` time DEFAULT NULL,
  `groupId` varchar(100) DEFAULT NULL,
  `subgroupId` int(11) DEFAULT NULL,
  `mainGroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subgroupId` (`subgroupId`),
  KEY `mainGroupId` (`mainGroupId`),
  CONSTRAINT `notavailablegroup_ibfk_1` FOREIGN KEY (`subgroupId`) REFERENCES `subgroup` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notavailablegroup_ibfk_2` FOREIGN KEY (`mainGroupId`) REFERENCES `maingroup` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.notavailablelecture
CREATE TABLE IF NOT EXISTS `notavailablelecture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` varchar(20) DEFAULT NULL,
  `toTime` time DEFAULT NULL,
  `fromTime` time DEFAULT NULL,
  `lectureId` int(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lectureId` (`lectureId`),
  CONSTRAINT `notavailablelecture_ibfk_1` FOREIGN KEY (`lectureId`) REFERENCES `lecturer` (`employeeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.notavailablesession
CREATE TABLE IF NOT EXISTS `notavailablesession` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` int(11) DEFAULT NULL,
  `day` varchar(10) DEFAULT NULL,
  `toTime` time DEFAULT NULL,
  `fromTime` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sessionId` (`sessionId`),
  CONSTRAINT `notavailablesession_ibfk_1` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.parrellsessions
CREATE TABLE IF NOT EXISTS `parrellsessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` int(11) DEFAULT NULL,
  `orderId` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Prallel_sessionId_time_table` (`sessionId`),
  CONSTRAINT `fk_Prallel_sessionId_time_table` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.prefroomgroup
CREATE TABLE IF NOT EXISTS `prefroomgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `subGroupId` int(11) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_groupId` (`groupId`),
  KEY `fk_subGroupId` (`subGroupId`),
  KEY `fk_roomId_group` (`roomId`),
  CONSTRAINT `fk_groupId` FOREIGN KEY (`groupId`) REFERENCES `maingroup` (`id`),
  CONSTRAINT `fk_roomId_group` FOREIGN KEY (`roomId`) REFERENCES `room` (`rid`),
  CONSTRAINT `fk_subGroupId` FOREIGN KEY (`subGroupId`) REFERENCES `subgroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.prefroomlecturer
CREATE TABLE IF NOT EXISTS `prefroomlecturer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employeeId` int(6) unsigned DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employeeId` (`employeeId`),
  KEY `fk_roomId_lecturer` (`roomId`),
  CONSTRAINT `fk_employeeId` FOREIGN KEY (`employeeId`) REFERENCES `lecturer` (`employeeId`),
  CONSTRAINT `fk_roomId_lecturer` FOREIGN KEY (`roomId`) REFERENCES `room` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.prefroomreserved
CREATE TABLE IF NOT EXISTS `prefroomreserved` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roomId` int(11) DEFAULT NULL,
  `day` varchar(10) DEFAULT NULL,
  `toTime` time DEFAULT NULL,
  `fromTime` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_roomId_reserved` (`roomId`),
  CONSTRAINT `fk_roomId_reserved` FOREIGN KEY (`roomId`) REFERENCES `room` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.prefroomsession
CREATE TABLE IF NOT EXISTS `prefroomsession` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` int(11) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sessionId` (`sessionId`),
  KEY `fk_roomId_session` (`roomId`),
  CONSTRAINT `fk_roomId_session` FOREIGN KEY (`roomId`) REFERENCES `room` (`rid`),
  CONSTRAINT `fk_sessionId` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.prefroomsubject
CREATE TABLE IF NOT EXISTS `prefroomsubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tagId` int(11) DEFAULT NULL,
  `subjectId` varchar(10) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subjectId_pref` (`subjectId`),
  KEY `fk_tagId_pref` (`tagId`),
  KEY `fk_roomId_subject` (`roomId`),
  CONSTRAINT `fk_roomId_subject` FOREIGN KEY (`roomId`) REFERENCES `room` (`rid`),
  CONSTRAINT `fk_subjectId_pref` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`subId`),
  CONSTRAINT `fk_tagId_pref` FOREIGN KEY (`tagId`) REFERENCES `tag` (`tagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.prefroomtag
CREATE TABLE IF NOT EXISTS `prefroomtag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tagId` int(11) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tagId` (`tagId`),
  KEY `fk_roomId_tag` (`roomId`),
  CONSTRAINT `fk_roomId_tag` FOREIGN KEY (`roomId`) REFERENCES `room` (`rid`),
  CONSTRAINT `fk_tagId` FOREIGN KEY (`tagId`) REFERENCES `tag` (`tagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.programme
CREATE TABLE IF NOT EXISTS `programme` (
  `programmeid` int(11) NOT NULL AUTO_INCREMENT,
  `programmeName` varchar(100) NOT NULL,
  PRIMARY KEY (`programmeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.room
CREATE TABLE IF NOT EXISTS `room` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `buildingid` int(11) NOT NULL,
  `room` varchar(100) NOT NULL,
  `capacity` int(11) NOT NULL,
  `roomType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `buildingid` (`buildingid`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`buildingid`) REFERENCES `building` (`bid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.savegrouptimetable
CREATE TABLE IF NOT EXISTS `savegrouptimetable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` varchar(30) DEFAULT NULL,
  `file` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.session
CREATE TABLE IF NOT EXISTS `session` (
  `sessionId` int(11) NOT NULL AUTO_INCREMENT,
  `subjectId` varchar(10) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `subGroupId` int(11) DEFAULT NULL,
  `studentCount` int(11) DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `isConsecutive` varchar(5) DEFAULT NULL,
  `consectiveAdded` varchar(5) DEFAULT NULL,
  `isParallel` varchar(20) DEFAULT NULL,
  `category` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`sessionId`),
  KEY `fk_key2` (`subjectId`),
  KEY `fk_key3` (`tagId`),
  KEY `fk_key4` (`groupId`),
  KEY `fk_key5` (`subGroupId`),
  CONSTRAINT `fk_key2` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`subId`) ON DELETE CASCADE,
  CONSTRAINT `fk_key3` FOREIGN KEY (`tagId`) REFERENCES `tag` (`tagid`) ON DELETE CASCADE,
  CONSTRAINT `fk_key4` FOREIGN KEY (`groupId`) REFERENCES `maingroup` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_key5` FOREIGN KEY (`subGroupId`) REFERENCES `subgroup` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.sessionlecture
CREATE TABLE IF NOT EXISTS `sessionlecture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecturerId` int(6) unsigned DEFAULT NULL,
  `sessionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_keySessionLectureLectId` (`lecturerId`),
  KEY `fk_keySessionLecturesessionId` (`sessionId`),
  CONSTRAINT `fk_keySessionLectureLectId` FOREIGN KEY (`lecturerId`) REFERENCES `lecturer` (`employeeId`) ON DELETE CASCADE,
  CONSTRAINT `fk_keySessionLecturesessionId` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.subgroup
CREATE TABLE IF NOT EXISTS `subgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subgroupid` varchar(100) NOT NULL,
  `subgroupnumber` int(11) DEFAULT NULL,
  `maingroupid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maingroupid` (`maingroupid`),
  CONSTRAINT `subgroup_ibfk_1` FOREIGN KEY (`maingroupid`) REFERENCES `maingroup` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.subject
CREATE TABLE IF NOT EXISTS `subject` (
  `subId` varchar(10) NOT NULL,
  `subName` varchar(30) NOT NULL,
  `offeredYearSemId` int(11) NOT NULL,
  `noLecHrs` int(11) NOT NULL,
  `noTutHrs` int(11) NOT NULL,
  `noEvalHrs` int(11) NOT NULL,
  `subjectType` varchar(20) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `noLabHrs` int(11) DEFAULT NULL,
  PRIMARY KEY (`subId`),
  KEY `offeredYearSemId` (`offeredYearSemId`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`offeredYearSemId`) REFERENCES `academicyearandsemester` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.tag
CREATE TABLE IF NOT EXISTS `tag` (
  `tagid` int(11) NOT NULL AUTO_INCREMENT,
  `tagName` varchar(100) NOT NULL,
  PRIMARY KEY (`tagid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.timetable
CREATE TABLE IF NOT EXISTS `timetable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` int(11) DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  `toTime` time DEFAULT NULL,
  `fromTime` time DEFAULT NULL,
  `timeString` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sessionId_time_table` (`sessionId`),
  KEY `fk_roomId_time_table` (`roomId`),
  CONSTRAINT `fk_roomId_time_table` FOREIGN KEY (`roomId`) REFERENCES `room` (`rid`),
  CONSTRAINT `fk_sessionId_time_table` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.workingdaysmain
CREATE TABLE IF NOT EXISTS `workingdaysmain` (
  `workingId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  `noOfDays` int(11) NOT NULL,
  PRIMARY KEY (`workingId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table timetablemanagementsystem.workingdayssub
CREATE TABLE IF NOT EXISTS `workingdayssub` (
  `subId` int(11) NOT NULL AUTO_INCREMENT,
  `workingId` int(11) NOT NULL,
  `workingday` varchar(30) NOT NULL,
  `timeslot` varchar(50) DEFAULT NULL,
  `timeslottype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`subId`),
  KEY `workingId` (`workingId`),
  CONSTRAINT `workingdayssub_ibfk_1` FOREIGN KEY (`workingId`) REFERENCES `workingdaysmain` (`workingId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
