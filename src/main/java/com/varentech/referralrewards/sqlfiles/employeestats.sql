USE varendatabase;

CREATE TABLE IF NOT EXISTS `varendatabase`.`employeestats` (
  `id`              INT UNSIGNED     NOT NULL AUTO_INCREMENT,
  `firstName`       VARCHAR(45)      NOT NULL,
  `lastName`        VARCHAR(45)      NOT NULL,
  `varenEmail`      VARCHAR(45)      NOT NULL,
  `password` varchar(60),

  PRIMARY KEY (`id`)

)
;
