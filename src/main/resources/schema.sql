
SET FOREIGN_KEY_CHECKS = 0;
CREATE DATABASE IF NOT EXISTS varendatabase;
USE varendatabase;

/*
DROP TABLE IF EXISTS varendatabase.createroles;
DROP TABLE IF EXISTS varendatabase.employee_role;
DROP TABLE IF EXISTS varendatabase.employeestats;
DROP TABLE IF EXISTS varendatabase.referralcandidates;
DROP TABLE IF EXISTS varendatabase.employeepoints;
DROP TABLE IF EXISTS varendatabase.statustable;
DROP TABLE IF EXISTS varendatabase.prizesreceived;
DROP TABLE IF EXISTS varendatabase.statustable;*/

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE IF NOT EXISTS varendatabase.createroles (
  roleName VARCHAR(20) NOT NULL UNIQUE,
  roleId   INT UNSIGNED AUTO_INCREMENT,
  PRIMARY KEY (roleId)

);
CREATE TABLE IF NOT EXISTS varendatabase.employeepoints(
  `pointsThisMonth` INT NOT NULL DEFAULT 0,
  `pointsThisYear` INT NOT NULL DEFAULT 0,
  `employeeId` INT NOT NULL

);

CREATE TABLE IF NOT EXISTS varendatabase.statustable(
  `statusNumber` INTEGER NOT NULL AUTO_INCREMENT,
  `statusName` VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY(`statusNumber`)
);



CREATE TABLE IF NOT EXISTS varendatabase.employeestats (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  firstName  VARCHAR(45)  NOT NULL,
  lastName   VARCHAR(45)  NOT NULL,
  varenEmail VARCHAR(45)  NOT NULL,
  password   VARCHAR(60)  NOT NULL,

  PRIMARY KEY (id)

);


CREATE TABLE IF NOT EXISTS varendatabase.employee_role (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  role_id     INT UNSIGNED NOT NULL,
  employee_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (role_id) REFERENCES createroles (roleId),
  FOREIGN KEY (employee_id) REFERENCES employeestats (id),
  UNIQUE KEY (role_id, employee_id)
);


CREATE TABLE IF NOT EXISTS varendatabase.referralcandidates
(
  id                 INT auto_increment PRIMARY KEY,
  submitDate         DATE                NULL,
  lastName           VARCHAR(45)         NOT NULL,
  firstName          VARCHAR(45)         NOT NULL,
  clearanceLevel     VARCHAR(45)         NULL,
  candidateEmail     VARCHAR(45)         NULL,
  candidatePhone     VARCHAR(12)         NULL,
  possiblePosition   VARCHAR(45)         NULL,
  knownBy            VARCHAR(256)        NULL,
  qualifications     VARCHAR(256)        NULL,
  varenEmployeeEmail VARCHAR(1000)       NULL,
  employeeId         INT unsigned        NOT NULL,
  anon               tinyint DEFAULT '0' NOT NULL,
  resume             VARCHAR(45)         NULL,
  referralWasMadeOn  DATE                NULL,
  interviewed        DATE                NULL,
  offer              DATE                NULL,
  hired              DATE                NULL,
  notes              longtext            NULL,
  status             INT DEFAULT '0'     NOT NULL,
  futureCon          VARCHAR(45)         NOT NULL DEFAULT 0,
  inPersonReferral  tinyint(1)          NOT NULL DEFAULT 0,
  isDeleted          tinyint(1)          NOT NULL DEFAULT 0,


  FOREIGN KEY (employeeId) REFERENCES employeestats (id)
);

/*create index employeeId
  on referralcandidates (employeeId);
*/

CREATE TABLE IF NOT EXISTS varendatabase.prizesreceived(
  dateRedeemed      DATE          NOT NULL,
  employeeId        INT UNSIGNED           NOT NULL,
  levelRedeemed     VARCHAR(12)           NOT NULL,
  prizeName     VARCHAR(50)  NOT NULL,

FOREIGN KEY (employeeId) REFERENCES employeestats(id)
);
