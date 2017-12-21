-- -----------------------------------------------------
-- Display the names of all of the students in alphabetical order along with his/her major, netid and mobile phone number.
-- -----------------------------------------------------
SELECT student_name,student_major,student_netID,student_mobileNumber
FROM students
ORDER BY student_name;

-- -----------------------------------------------------
-- Display all of the clubs that are mentored by the Computer Science Department. 
-- List the club name, URL and regular meeting location.
-- -----------------------------------------------------
SELECT club_name,club_url,club_meetingSpace
FROM clubs
WHERE club_department = "computer science";

-- -----------------------------------------------------
-- Display the five clubs with the most members; 
-- List the largest club first and then in descending order by the number of members.
-- -----------------------------------------------------
SELECT club_name,club_numMembers
FROM clubs
ORDER BY club_numMembers DESC
LIMIT 5;

-- -----------------------------------------------------
-- Which club earned the most from dues to date?
-- -----------------------------------------------------
SELECT club_name,(club_dues * club_numMembers) AS total_dues
FROM clubs
ORDER BY total_dues DESC
LIMIT 1;

-- -----------------------------------------------------
-- What is the average cost of dues for each department (in alphabetical order by department)?
-- -----------------------------------------------------
SELECT club_department,AVG(club_dues)
FROM clubs
GROUP BY club_department
ORDER BY club_department;

-- -----------------------------------------------------
-- Calculate the number of club memberships for each student on file and display the results with the student's name.
-- -----------------------------------------------------
SELECT CONCAT(s.student_name, ' - ',COUNT(m.member_netID),' club(s)') 
FROM students s 
INNER JOIN members m ON s.student_netID = m.member_netID 
GROUP BY s.student_netID;

-- -----------------------------------------------------
-- Alphabetically list all students who do not have a membership in any club.
-- -----------------------------------------------------
SELECT s.student_name
FROM students s
LEFT JOIN members m ON s.student_netID = m.member_netID
WHERE m.member_netID IS NULL
ORDER BY s.student_name;

-- -----------------------------------------------------
-- Display the netIDs of the president, secretary, and treasurer of each club 
-- by joining the clubs, president, secretary, and treasurer tables.
-- -----------------------------------------------------
SELECT c.club_name,p.president_netID,s.secretary_netID,t.treasurer_netID
FROM clubs c
INNER JOIN president p ON c.club_ID = p.president_clubID
INNER JOIN secretary s ON c.club_ID = s.secretary_clubID
INNER JOIN treasurer t ON c.club_ID = t.treasurer_clubID;


-- -----------------------------------------------------
-- Show how many students from each major are in a club.
-- -----------------------------------------------------
SELECT s.student_major,SUM(c.club_numMembers)
FROM clubs c
INNER JOIN students s ON s.student_major = c.club_department
GROUP BY s.student_major;

-- -----------------------------------------------------
-- Display the netID of the users who have resigned from a club 
-- and which club they resigned from.
-- -----------------------------------------------------
SELECT m.member_netID,c.club_name,m.member_dateResigned 
FROM members m 
INNER JOIN clubs c ON m.member_clubID = c.club_ID 
WHERE m.member_dateResigned IS NOT NULL;




