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