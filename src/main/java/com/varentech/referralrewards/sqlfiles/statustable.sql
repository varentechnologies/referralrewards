USE varendatabase;

CREATE TABLE IF NOT EXISTS `varendatabase`.`statustable`(
`statusNumber` INTEGER NOT NULL AUTO_INCREMENT,
`statusName` varchar(45) NOT NULL,
PRIMARY KEY(`statusNumber`)
);
