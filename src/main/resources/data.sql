CREATE DATABASE IF NOT EXISTS varendatabase;

USE varendatabase;


SELECT varendatabase.createroles.roleId , varendatabase.employeestats.id
FROM varendatabase.createroles
  INNER JOIN varendatabase.employeestats
    ON varendatabase.employeestats.id = varendatabase.createroles.roleId;

SELECT varendatabase.employeestats.id, varendatabase.referralcandidates.employeeId
FROM varendatabase.referralcandidates
  LEFT JOIN varendatabase.employeestats
    ON varendatabase.referralcandidates.employeeId = varendatabase.employeestats.id;
SELECT varendatabase.statustable.statusNumber, varendatabase.referralcandidates.status
FROM varendatabase.referralcandidates
  RIGHT JOIN varendatabase.statustable
    ON varendatabase.referralcandidates.status=varendatabase.statustable.statusNumber;





INSERT IGNORE INTO createroles(roleName) VALUES ('superadmin');
INSERT IGNORE INTO createroles(roleName) VALUES ('admin');
INSERT IGNORE INTO createroles(roleName) VALUES ('recruiter');
INSERT IGNORE INTO createroles(roleName) VALUES ('leader');


INSERT IGNORE INTO statustable(statusNumber,statusName) VALUES (1,'nonparticipatory');



START TRANSACTION;
    SELECT @S:= SUM(status) FROM varendatabase.referralcandidates;

      UPDATE varendatabase.referralcandidates SET status =
      (CASE @S
      WHEN 4 THEN (CASE
                   WHEN (varendatabase.referralcandidates.hired IS NULL) THEN (varendatabase.referralcandidates.status -1)
                   ELSE varendatabase.referralcandidates.status
                   END)
      WHEN 3 THEN (CASE
                   WHEN (varendatabase.referralcandidates.hired IS NULL) THEN varendatabase.referralcandidates.status
                   ELSE (varendatabase.referralcandidates.status +1)
                   END)
      WHEN 2 THEN (CASE
                   WHEN (varendatabase.referralcandidates.offer IS NULL) THEN varendatabase.referralcandidates.status
                   ELSE (varendatabase.referralcandidates.status +1)
                   END)
      WHEN 1 THEN (CASE
                   WHEN (varendatabase.referralcandidates.interviewed IS NULL) THEN varendatabase.referralcandidates.status
                   ELSE (varendatabase.referralcandidates.status +1)
                   END)
      ELSE 5
      END);
COMMIT WORK ;

/*
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(1, 'Sibyl', 'Myrtle', 'Carolyn.Westgate.69@sky.com', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(2, 'Marissa', 'Linda', 'Shayne.Crawford.04@tin.it', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(3, 'Colton', 'Astrid', 'Sebastian.Strefling.58@rocketmail.com', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(4, 'Osric', 'Heidi', 'Jeb.Windeatt.25@bluewin.ch', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(5, 'Cliff', 'Wendy', 'Tracy.Mattingly.27@comcast.net', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(6, 'Otto', 'Gwenda', 'Ken.Patrick.44@hotmail.fr', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(7, 'Timothy', 'Bertram', 'Davina.Botterill.56@tiscali.it', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(8, 'Colette', 'Kirstin', 'Giselle.Yount.33@centurytel.net', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(9, 'Annie', 'Jaime', 'Frederick.Spencer.92@comcast.net', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(10, 'Gia', 'Eva', 'Yvette.Graeme.60@optonline.net', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(11, 'Dede', 'Cliff', 'Charity.Hembree.93@frontiernet.net', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(12, 'Dickon', 'Jenna', 'Helena.Welchman.67@qq.com', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(13, 'Sylvester', 'Betsy', 'Nora.Camden.96@ig.com.br', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(14, 'Aviva', 'Claire', 'Brenda.Bubb.80@free.fr', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(15, 'Angela', 'Rodger', 'Edna.Afford.68@aim.com', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(16, 'Philippa', 'Frederick', 'Dawn.Tanner.43@hotmail.de', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(17, 'Josie', 'Alicia', 'Reginald.Mackenzie.06@orange.fr', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(18, 'Abigail', 'Matthew', 'Kim.Carnell.69@skynet.be', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(19, 'Winston', 'John', 'Booth.Bottrill.84@yahoo.com.mx', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
INSERT INTO varendatabase.employeestats
(id, firstName, lastName, varenEmail, password)
VALUES(20, 'Lewis', 'Adele5', 'Kirstin.Runcie.87@planet.nl', '$2a$10$ejAB9rWVJnlo32BYiAE47uu.58lznQc5JFpKGVo45kqqOH1/FZbKW');
*/
/*INSERT INTO varendatabase.employeestats (id, firstName, lastName, varenEmail, password) VALUES (21, 'John', 'Shi', 'ShiJ@varentech.com', '$2a$10$gk6VvhiMFhIp3FZp4P2FWeIHjjX04RLYG3SwiXiSTD3z.cWxpH7Ra');*/
DELETE FROM referralcandidates where employeeId = '22';
DELETE FROM employee_role WHERE id = '22';
DELETE FROM employeestats WHERE id = '22';
INSERT IGNORE INTO varendatabase.employeestats (id, firstName, lastName, varenEmail, password) VALUES (22, 'Johnny', 'Depp', 'DeppJ@varentech.com', '$2a$10$i5UdJJmTYJgn5aFwnv7JXueGHdkIat3h5lWSGNBwPXcUX4e5NoKvq');

/*
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (20, 1, 4);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (12, 1, 8);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (6, 1, 15);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (10, 1, 16);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (15, 1, 20);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (16, 2, 1);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (11, 2, 2);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (7, 2, 4);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (5, 2, 9);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (19, 2, 12);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (9, 2, 14);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (2, 3, 2);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (13, 3, 3);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (8, 3, 5);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (1, 3, 7);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (17, 3, 8);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (18, 3, 10);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (4, 3, 12);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (14, 3, 13);
INSERT INTO varendatabase.employee_role
(id, role_id, employee_id)
VALUES (3, 3, 15);*/
INSERT IGNORE INTO varendatabase.employee_role (id, role_id, employee_id) VALUES (22, 1, 22);




/*
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (1, '2018-05-02', 'Mclaughlin', 'Teagan', 'fullycleared', null, null, null, null, null, null, 7, 0, '0', '2018-07-04', '2018-07-04', '2018-07-04', '2018-07-04', '', 1, 'yes', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (2, '2018-12-03', 'Hahn', 'MacKensie', null, null, null, null, null, null, null, 2, 0, '0', '2018-01-01', null, null, null, '', 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (3, '2017-07-30', 'Carver', 'Audrey', null, null, null, null, null, null, null, 3, 0, '0', '2018-07-05', '2018-07-05', null, null, '', 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (4, '2018-11-29', 'Andrews', 'Evan', null, null, null, null, null, null, null, 5, 0, '0', '2018-07-05', '2018-07-05', '2018-07-05', null, '', 1, 'yes', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (5, '2019-05-27', 'Holder', 'Ashton', null, null, null, null, null, null, null, 8, 0, '0', '2018-07-05', null, null, null, '', 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (6, '2017-12-08', 'Randolph', 'Lillith', null, null, null, null, null, null, null, 2, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (7, '2019-03-20', 'Cummings', 'Vielka', null, null, null, null, null, null, null, 2, 0, null, null, null, null, null, null, 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (8, '2019-03-04', 'Emerson', 'Lacy', null, null, null, null, null, null, null, 10, 0, '0', '2017-07-04', null, null, null, '', 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (9, '2017-10-15', 'Kramer', 'Tanya', 'fullycleared', null, null, null, null, null, null, 9, 0, '0', '2018-07-05', null, null, null, '', 1, 'yes', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (10, '2017-11-15', 'Suarez', 'Gareth', null, null, null, null, null, null, null, 1, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (11, '2018-05-10', 'Abbott', 'Adam', null, null, null, null, null, null, null, 5, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (12, '2018-04-28', 'Maynard', 'Althea', null, null, null, null, null, null, null, 10, 0, null, null, null, null, null, null, 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (13, '2019-03-25', 'Robinson', 'Len', null, null, null, null, null, null, null, 1, 0, '0', '2018-07-05', '2018-07-05', null, null, '', 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (14, '2019-04-02', 'Dickson', 'Coby', null, null, null, null, null, null, null, 9, 0, null, null, null, null, null, null, 1, 'yes', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (15, '2018-12-21', 'Moore', 'Deacon', null, null, null, null, null, null, null, 7, 0, null, null, null, null, null, null, 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (16, '2018-04-10', 'Wolfe', 'Breanna', null, null, null, null, null, null, null, 6, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (17, '2018-04-04', 'Haley', 'Ali', null, null, null, null, null, null, null, 2, 0, null, null, null, null, null, null, 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (18, '2018-06-25', 'Welch', 'Donna', null, null, null, null, null, null, null, 9, 0, null, null, null, null, null, null, 1, 'yes', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (19, '2019-06-03', 'Jefferson', 'Indigo', null, null, null, null, null, null, null, 2, 0, null, null, null, null, null, null, 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (20, '2017-10-13', 'Dominguez', 'Jonas', null, null, null, null, null, null, null, 10, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (21, '2017-09-06', 'Whitaker', 'Delilah', null, null, null, null, null, null, null, 6, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (22, '2017-10-10', 'Figuero', 'Maia', null, null, null, null, null, null, null, 8, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (23, '2018-12-28', 'Vaughan', 'Janna', null, null, null, null, null, null, null, 9, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (24, '2019-04-05', 'Field', 'Natalie', null, null, null, null, null, null, null, 4, 0, null, null, null, null, null, null, 1, 'yes', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (25, '2018-12-07', 'Horton', 'Marah', null, null, null, null, null, null, null, 9, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (26, '2017-12-20', 'Holland', 'Aubrey', null, null, null, null, null, null, null, 5, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (27, '2018-02-16', 'Gross', 'Kathleen', 'notcleared', null, null, null, null, null, null, 1, 0, '0', '2018-07-05', '2018-07-05', null, null, '', 2, 'yes', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (28, '2018-09-11', 'Wiggins', 'Rudyard', null, null, null, null, null, null, null, 4, 0, null, null, null, null, null, null, 1, '',  0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (29, '2019-05-21', 'Wooten', 'Dylan', null, null, null, null, null, null, null, 5, 0, null, null, null, null, null, null, 1, '', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (30, '2018-01-01', 'Whitaker', 'Lenore', null, null, null, null, null, null, null, 6, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (31, '2018-10-22', 'Horton', 'Rina', null, null, null, null, null, null, null, 4, 0, null, null, null, null, null, null, 1, 'yes', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (32, '2019-06-05', 'Hudson', 'Jemima', null, null, null, null, null, null, null, 8, 0, null, null, null, null, null, null, 1, '', 0, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (33, '2018-07-23', 'Rick', 'Morty', 'fullycleared', null, null, null, null, null, null, 21, 0, null, '2018-07-23', '2018-07-23', '2018-07-23', '2018-07-23', null, 1, '0', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (34, '2018-07-23', 'Obi', 'Wan', 'fullycleared', null, null, null, null, null, null, 21, 0, null, '2018-07-23', '2018-07-23', '2018-07-23', '2018-07-23', null, 1, '0', 1, 0);
INSERT INTO varendatabase.referralcandidates (id, submitDate, lastName, firstName, clearanceLevel, candidateEmail, candidatePhone, possiblePosition, knownBy, qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon, inPersonReferral, isDeleted) VALUES (35, '2018-07-23', 'Barnes', 'Zoe', 'fullycleared', null, null, null, null, null, null, 21, 0, null, '2018-07-23', '2018-07-23', '2018-07-23', '2018-07-23', null, 1, '0', 1, 0);


INSERT INTO varendatabase.prizesreceived (dateRedeemed, employeeId, levelRedeemed, prizeName) VALUES ('2018-07-19', 7, '1', 'test1');
INSERT INTO varendatabase.prizesreceived (dateRedeemed, employeeId, levelRedeemed, prizeName) VALUES ('2015-07-08', 7, '2', 'test2');


INSERT INTO varendatabase.employeepoints (pointsThisMonth, pointsThisYear, employeeId ) VALUES (12, 14, 1);
INSERT INTO varendatabase.employeepoints (pointsThisMonth, pointsThisYear, employeeId ) VALUES (10, 20, 20);
INSERT INTO varendatabase.employeepoints (pointsThisMonth, pointsThisYear, employeeId ) VALUES (14, 30, 3);
INSERT INTO varendatabase.employeepoints (pointsThisMonth, pointsThisYear, employeeId ) VALUES (6, 15, 4);

*/