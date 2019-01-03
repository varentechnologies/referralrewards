USE varendatabase;

CREATE TABLE IF NOT EXISTS `varendatabase`.`employeeleaderboard`(
`pointsThisMonth` INT NOT NULL DEFAULT 0,
`pointsThisYear` INT NOT NULL DEFAULT 0,
`employeeId` INT NOT NULL,
`alltimepoints` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (pointsThisYear),
  FOREIGN KEY (employeeId) REFERENCES employeestats(id)
);