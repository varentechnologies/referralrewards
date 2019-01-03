USE varendatabase;

CREATE TABLE IF NOT EXISTS `varendatabase`.`referralcandidates` (
  `id` INT AUTO_INCREMENT,
  `submitDate` DATE DEFAULT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `clearanceLevel` VARCHAR(45) DEFAULT NULL,
  `candidateEmail` VARCHAR(45),
  `candidatePhone` VARCHAR(12),
  `possiblePosition` VARCHAR(45) DEFAULT NULL,
  `knownBy` varchar(256) DEFAULT NULL,
  `qualifications` varchar(256) DEFAULT NULL,
  `varenEmployeeEmail` VARCHAR(1000) default NULL,
  `employeeId` INT NOT NULL,
  `anon` BOOLEAN DEFAULT 0,
  `resume` TINYINT DEFAULT 0,

  `referralWasMadeOn` DATE DEFAULT NULL,
  `interviewed` DATE DEFAULT NULL,
  `offer` DATE DEFAULT NULL,
  `hired` DATE DEFAULT NULL,
  `notes` LONGTEXT DEFAULT NULL,
  `status` INTEGER NOT NULL DEFAULT 0,


  PRIMARY KEY (`id`),
  FOREIGN KEY (`employeeId`) REFERENCES employeestats(id),
  FOREIGN Key(`status`)REFERENCES statustable(statusNumber)
)
;
