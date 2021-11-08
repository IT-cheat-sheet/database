-- Drop Zone --

drop user 'admin'@'%';
DROP SCHEMA IF EXISTS `itcheatsheet` ;

-- ----------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `itcheatsheet` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `itcheatsheet` ;

-- -----------------------------------------------------
-- Table `itcheatsheet`.`topics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`topics` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`topics` (
  `topicId` INT(2) ZEROFILL NOT NULL AUTO_INCREMENT,
  `topicName` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `categoryName_UNIQUE` (`topicName` ASC) VISIBLE,
  PRIMARY KEY (`topicId`),
  UNIQUE INDEX `topicId_UNIQUE` (`topicId` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `itcheatsheet`.`reviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`reviews` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`reviews` (
  `reviewId` INT(7) ZEROFILL NOT NULL AUTO_INCREMENT,
  `reviewTitle` VARCHAR(45) NOT NULL,
  `reviewContent` VARCHAR(5000) NOT NULL,
  `reviewLink` VARCHAR(500) NULL DEFAULT NULL,
  `reviewImage` LONGBLOB NULL DEFAULT NULL,
  `reviewer` VARCHAR(100) NOT NULL,
  `topicId` INT(2) ZEROFILL NOT NULL,
  PRIMARY KEY (`reviewId`, `topicId`),
  INDEX `fk_reviews_topics1_idx` (`topicId` ASC) VISIBLE,
  CONSTRAINT `fk_reviews_topics1`
    FOREIGN KEY (`topicId`)
    REFERENCES `itcheatsheet`.`topics` (`topicId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `itcheatsheet`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`subjects` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`subjects` (
  `subjectNumber` INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `subjectId` VARCHAR(6) NOT NULL,
  `subjectName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`subjectNumber`))
ENGINE = InnoDB
AUTO_INCREMENT = 231
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `itcheatsheet`.`semesters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`semesters` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`semesters` (
  `semesterNumber` INT(2) ZEROFILL NOT NULL AUTO_INCREMENT,
  `semester` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`semesterNumber`),
  UNIQUE INDEX `semester_UNIQUE` (`semester` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itcheatsheet`.`summarypost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`summarypost` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`summarypost` (
  `summaryPostId` INT(7) ZEROFILL NOT NULL AUTO_INCREMENT,
  `summaryTitle` VARCHAR(100) NOT NULL,
  `summaryContent` VARCHAR(5000) NULL DEFAULT NULL,
  `posterName` VARCHAR(45) NOT NULL,
  `blobFile` LONGBLOB NULL DEFAULT NULL,
  `linkAttachment` VARCHAR(500) NULL DEFAULT NULL,
  `subjectNumber` INT(3) ZEROFILL NOT NULL,
  `semesterNumber` INT(2) ZEROFILL NOT NULL,
  PRIMARY KEY (`summaryPostId`, `subjectNumber`, `semesterNumber`),
  INDEX `fk_SummaryPost_subjects_idx` (`subjectNumber` ASC) VISIBLE,
  INDEX `fk_summarypost_semesters1_idx` (`semesterNumber` ASC) VISIBLE,
  CONSTRAINT `fk_SummaryPost_subjects`
    FOREIGN KEY (`subjectNumber`)
    REFERENCES `itcheatsheet`.`subjects` (`subjectNumber`),
  CONSTRAINT `fk_summarypost_semesters1`
    FOREIGN KEY (`semesterNumber`)
    REFERENCES `itcheatsheet`.`semesters` (`semesterNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `itcheatsheet`.`admins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`admins` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`admins` (
  `adminId` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(50) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`adminId`),
  UNIQUE INDEX `userName_UNIQUE` (`userName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itcheatsheet`.`tokensAdmin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`tokensAdmin` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`tokensAdmin` (
  `tokenId` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(200) NOT NULL,
  `adminId` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`tokenId`),
  INDEX `fk_tokensAdmin_admins1_idx` (`adminId` ASC) VISIBLE,
  CONSTRAINT `fk_tokensAdmin_admins1`
    FOREIGN KEY (`adminId`)
    REFERENCES `itcheatsheet`.`admins` (`adminId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itcheatsheet`.`reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `itcheatsheet`.`reports` ;

CREATE TABLE IF NOT EXISTS `itcheatsheet`.`reports` (
  `reportNumber` INT(7) ZEROFILL NOT NULL AUTO_INCREMENT,
  `summaryPostId` INT(7) ZEROFILL NULL,
  `reviewId` INT(7) ZEROFILL NULL,
  `reportAction` ENUM('Edit', 'Delete') NOT NULL,
  `reportDescription` VARCHAR(5000) NOT NULL,
  `readStatus` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`reportNumber`),
  INDEX `fk_Reports_summarypost1_idx` (`summaryPostId` ASC) VISIBLE,
  INDEX `fk_Reports_reviews1_idx` (`reviewId` ASC) VISIBLE,
  CONSTRAINT `fk_Reports_summarypost1`
    FOREIGN KEY (`summaryPostId`)
    REFERENCES `itcheatsheet`.`summarypost` (`summaryPostId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reports_reviews1`
    FOREIGN KEY (`reviewId`)
    REFERENCES `itcheatsheet`.`reviews` (`reviewId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `itcheatsheet`.`tokensAdmin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itcheatsheet`.`tokensAdmin` (
  `tokenId` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(200) NOT NULL,
  `adminId` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`tokenId`),
  INDEX `fk_tokensAdmin_admins1_idx` (`adminId` ASC) VISIBLE,
  CONSTRAINT `fk_tokensAdmin_admins1`
    FOREIGN KEY (`adminId`)
    REFERENCES `itcheatsheet`.`admins` (`adminId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- INT
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT100','INFORMATION TECHNOLOGY FUNDAMENTALS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT101','PROGRAMMING FUNDAMENTALS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT102','WEB TECHNOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT114','DISCRETE MATHEMATICS FOR INFORMATION TECHNOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT201','CLIENT-SIDE WEB PROGRAMMING I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT202','SERVER-SIDE WEB PROGRAMMING I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT205','DATABASE MANAGEMENT SYSTEM');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT207','NETWORK I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT214','STATISTICS FOR INFORMATION TECHNOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT222','INFORMATION TECHNOLOGY INTEGRATED PROJECT II');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT305','SEMI-STRUCTURED AND UNSTRUCTURED DATA MANAGEMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT307','SECURITY I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT314','APPLIED MATHEMATIC FOR DATA SCIENCE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT491','SELECTED TOPIC IN INFORMATION TECHNOLOGY I : INTERNET OF THINGS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT491','SPECIAL TOPICS I : DECISION SUPPORT SYSTEM');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT491','SPECIAL TOPICS I : STUDY OF HUMAN RESOURCE MANAGEMENT INFORMATION SYSTEM');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT491','SPECIAL TOPICS I : MULTIMEDIA TECHNOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT492','SPECIAL TOPICS II : FULL STACK WEB DEVELOPMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT492','SPECIAL TOPICS II : BUSINESS FINANCE AND DATA ANALYTICS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT492','SPECIAL TOPICS II : DEVSECOPS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT103','ADVANCED PROGRAMMING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT104','USER EXPERIENCE DESIGN');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT105','BASIC SQL');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT107','COMPUTING PLATFROMS TECHNOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT200','DATA STRUCTURES AND ALGORITHMS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT203','CLIENT-SIDE WEB PROGRAMMING II');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT204','SERVER-SIDE WEB PROGRAMMING II');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT206','ADVANCED DATABASE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT208','NETWORK II');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT209','DEVELOPMENT AND OPERATIONS (DEVOPS)');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT210','ARCHITECTURE, INTEGRATION AND DEPLOYMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT221','INTEGRATED INFORMATION TECHNOLOGY PROJECT I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT308','SECURITY II');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT319','INFORMATION TECHNOLOGY PROFESSIONAL PRACTICE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT321','INFORMATION TECHNOLOGY SEMINAR I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT322','INFORMATION TECHNOLOGY SEMINAR II');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT339','PREPARATION FOR CAREER TRAINING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT340','CAREER TRAINING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT350','COOPERATIVE STUDY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT365','CAPSTONE INFORMATION TECHNOLOGY PROJECT I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT366','CAPSTONE INFORMATION TECHNOLOGY PROJECT II');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT370','WORK INTEGRATED LEARNING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT371','EXPERIENTIAL LEARNING PROJECT I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('INT372','EXPERIENTIAL LEARNING PROJECT II');						
-- LNG						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG120','GENERAL ENGLISH');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG221','ACADEMIC ENGLISH IN INTERNATIONAL CONTEXTS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG223','ENGLISH FOR WORKPLACE COMMUNICATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG224','ORAL COMMUNICATION I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG250','THAI FOR COMMUNICATION AND CAREERS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG251','SPEAKING SKILLS IN THAI');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG252','WRITING SKILLS IN THAI');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG270','GERMAN I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG272','JAPANESE I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG275','CHINESE I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG281','BASIC KOREAN');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG320','CONTENT-BASED ENGLISH LEARNING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG322','ACADEMIC WRITING I');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG328','BASIC TRANSLATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG331','ENGLISH FOR EMPLOYMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG332','BUSINESS ENGLISH');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG422','READING APPRECIATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG425','INTERCULTURAL COMMUNICATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG550','REMEDIAL ENGLISH COURSE FOR POST GRADUATE STUDENTS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG600','IN-SESSIONAL ENGLISH COURSE FOR POST GRADUATE STUDENTS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG601','FOUNDATION ENGLISH FOR INTERNATIONAL PROGRAMS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG602','THESIS WRITING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG691','SPECIAL STUDY IN APPLIED LINGUISTICS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG711','RESEARCH IN DISCOURSE ANALYSIS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG712','SOCIOLINGUISTICS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG731','DISSERTATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG732','DISSERTATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG202','BASIC READING FOR SCIENCE AND TECHNOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG220','ACADEMIC ENGLISH');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG304','MEETINGS AND DISCUSSIONS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('LNG308','TECHNICAL REPORT WRITING');						
-- GEN						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN111','MAN AND ETHICS OF LIVING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN121','LEARNING AND PROBLEM SOLVING SKILLS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN201','ART AND SCIENCE OF COOKING AND EATING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN211','THE PHILOSOPHY OF SUFFICIENCY ECONOMY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN223','DISASTER PREPAREDNESS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN224','LIVEABLE CITY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN226','SMALL THINGS WE CALL POLYMERS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN231','MIRACLE OF THINKING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN232','COMMUNITY BASED RESEARCH AND INNOVATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN241','BEAUTY OF LIFE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN242','CHINESE PHILOSOPHY AND WAYS OF LIFE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN301','HOLISTIC HEALTH DEVELOPMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN311','ETHICS IN SCIENCE-BASED SOCIETY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN321','THE HISTORY OF CIVILIZATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN331','MAN AND REASONING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN341','THAI INDIGENOUS KNOWLEDGE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN351','MODERN MANAGEMENT AND LEADERSHIP');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN352','TECHNOLOGY AND INNOVATION FOR SUSTAINABLE DEVELOPMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN353','MANAGERIAL PSYCHOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN411','PERSONALITY DEVELOPMENT AND PUBLIC SPEAKING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN412','SCIENCE AND ART OF LIVING AND WORKING');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN421','INTEGRATIVE SOCIAL SCIENCES');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN441','CULTURE AND EXCURSION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('GEN101','PHYSICAL EDUCATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC162','SOCIETY AND CULTURE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC210','MAN AND ETHICS FOR QUALITY OF LIFE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC211','GENERAL PHILOSOPHY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC232','BEHAVIOR MODIFICATION');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC233','FAMILY RELATIONS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC251','INTRODUCTION TO JURISPRUDENCE');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC262','LEARNING DEVELOPMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC281','INTRODUCTION TO ECONOMICS');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC290','ENVIRONMENT AND DEVELOPMENT');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC333','INDUSTRIAL AND ORGANIZATION PSYCHOLOGY');						
INSERT INTO subjects(subjectId,subjectName) VALUES ('SSC337','TEAM WORKING');

INSERT INTO topics(topicName) VALUES ('Studying');
INSERT INTO topics(topicName) VALUES ('Life Style');
INSERT INTO topics(topicName) VALUES ('Eating');
INSERT INTO topics(topicName) VALUES ('Activities');
INSERT INTO topics(topicName) VALUES ('ECT.');

INSERT INTO semesters(semester) VALUES ('1/2562');
INSERT INTO semesters(semester) VALUES ('2/2562');
INSERT INTO semesters(semester) VALUES ('1/2563');
INSERT INTO semesters(semester) VALUES ('2/2563');
INSERT INTO semesters(semester) VALUES ('1/2564');
INSERT INTO semesters(semester) VALUES ('2/2564');

INSERT INTO admins(userName,password) VALUES ('admin','itcheatsheet');

create user IF NOT EXISTS 'admin'@'%'  IDENTIFIED BY 'itcheatsheet';
GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%';