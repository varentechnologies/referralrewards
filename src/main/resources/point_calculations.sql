SELECT e.*, COALESCE(points_this_year,0) AS pointsThisYear, COALESCE(points_this_month,0) AS pointThisMonth FROM
employeestats e LEFT JOIN
(
SELECT pv.employeeId, SUM(pv.total_points) AS points_this_year FROM
(
SELECT pt.*, (ref_points + interview_points + offer_points + hire_points) AS total_points FROM
(
SELECT rc.*,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel IS NOT NULL THEN 2
WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel IS NULL THEN 1
ELSE 0
END) AS ref_points,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND clearanceLevel IS NOT NULL THEN 4
WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL and clearanceLevel IS NULL THEN 2
ELSE 0
END) AS interview_points,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL and clearanceLevel IS NOT NULL THEN 4
WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL and clearanceLevel IS NULL THEN 2
ELSE 0
END) AS offer_points,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel IS NOT NULL THEN 8
WHEN referralWasMadeOn IS NOT NULL and hired IS NOT NULL and hired < NOW() AND clearanceLevel IS NULL THEN 4
ELSE 0
END) AS hire_points
FROM referralcandidates rc WHERE rc.referralWasMadeOn >= DATE_FORMAT(NOW(), '%Y-01-01')
) pt
)
pv
GROUP BY pv.employeeId
) q1 ON e.id = q1.employeeId LEFT JOIN
(
SELECT pv.employeeId, SUM(pv.total_points) AS points_this_month FROM
(
SELECT pt.*, (ref_points + interview_points + offer_points + hire_points) AS total_points FROM
(
SELECT rc.*,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel IS NOT NULL THEN 2
WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel IS NULL THEN 1
ELSE 0
END) AS ref_points,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND clearanceLevel IS NOT NULL THEN 4
WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL and clearanceLevel IS NULL THEN 2
ELSE 0
END) AS interview_points,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL and clearanceLevel IS NOT NULL THEN 4
WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL and clearanceLevel IS NULL THEN 2
ELSE 0
END) AS offer_points,
(CASE
WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel IS NOT NULL THEN 8
WHEN referralWasMadeOn IS NOT NULL and hired IS NOT NULL and hired < NOW() AND clearanceLevel IS NULL THEN 4
ELSE 0
END) AS hire_points
FROM referralcandidates rc WHERE rc.referralWasMadeOn >= DATE_FORMAT(NOW(), '%Y-%m-01')
) pt
)
pv
GROUP BY pv.employeeId
) q2 ON q1.employeeId = q2.employeeId
;


SELECT VERSION();


