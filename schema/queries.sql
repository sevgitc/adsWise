-- 1. Number of advertisements per post date

SELECT Post_Date, COUNT(*) AS NumberOfAnnouncements
FROM Advertisement 
GROUP BY Post_Date;

-- 2. Number of advertisements posted by month

SELECT MONTHNAME(Post_Date) AS PostMonth, COUNT(MONTHNAME(Post_Date)) AS QtyOfAdvertisements
FROM Advertisement
GROUP BY MONTHNAME(Post_Date);

-- 3. Information about people who posted advertisements, including name, phone number, and post date

SELECT Person.FirstName, Person.LastName, Advertisement.Post_Date, Advertisement.MemberPhone
FROM Advertisement INNER JOIN Person ON  Advertisement.MemberPhone = Person.MemberPhone
ORDER BY Person.FirstName;

-- 4. People who posted in a specific month (e.g., October)

SELECT Person.FirstName, Person.LastName,Advertisement.Post_Date, Advertisement.MemberPhone 
FROM Advertisement LEFT JOIN Person ON  Advertisement.MemberPhone = Person.MemberPhone
WHERE monthname (Advertisement.Post_Date) = 'October'
ORDER BY Person.FirstName;

-- 5. Advertisements posted in a specific month and year (e.g., September 2022)

SELECT * FROM Advertisement
WHERE monthname (Advertisement.Post_Date) = 'September' AND YEAR(Advertisement.Post_Date) = '2022';

-- 6. Number of advertisements per person

SELECT Person.Email, COUNT(Advertisement.MemberPhone) AS NumOfPost
FROM Advertisement 
INNER JOIN Person  ON Person.MemberPhone=Advertisement.MemberPhone
GROUP BY Person.Email
ORDER BY NumOfPost DESC;

-- 7. Number of days each advertisement was posted

SELECT AdID, Post_Date, Post_End_Date, DATEDIFF(Post_End_Date, Post_Date) AS DaysPost
FROM Advertisement
ORDER BY DATEDIFF(Post_End_Date, Post_Date);

-- 8. Average number of days advertisements were posted

SELECT AVG(DATEDIFF(Post_End_Date, Post_Date)) AS AvgDays
FROM Advertisement;

-- 9. Advertisement dimensions with corresponding building and floor location

SELECT Advertisement.AdID, Advertisement.SizeDim_Length, Advertisement.SizeDim_Width, BoardLocation.Building, BoardLocation.FloorNumber
FROM Advertisement
INNER JOIN Advertisement_LocatedOn_BoardLocation ON Advertisement_LocatedOn_BoardLocation.AdID= Advertisement.AdID
INNER JOIN BoardLocation ON BoardLocation.BoardID = Advertisement_LocatedOn_BoardLocation.BoardID;

-- 10. Advertisements posted in a specific building (e.g., NWM building)

SELECT Advertisement.AdID, Advertisement.SizeDim_Length, Advertisement.SizeDim_Width, BoardLocation.Building, BoardLocation.FloorNumber
FROM Advertisement
INNER JOIN Advertisement_LocatedOn_BoardLocation ON Advertisement_LocatedOn_BoardLocation.AdID= Advertisement.AdID
INNER JOIN BoardLocation ON BoardLocation.BoardID = Advertisement_LocatedOn_BoardLocation.BoardID 
WHERE BoardLocation.Building = 'NWM';

-- 11. Contact information (phone, full name, email) of students

SELECT * FROM Person
WHERE MemberPhone IN (SELECT StudentPhone FROM Student_CollegeMember);

-- 12. List of college members showing their member type (staff, student, professor)

SELECT StaffPhone AS Phone, Aff_Dep, College_ID, 'Staff College Member' AS MemberTYPE FROM StaffCollegeMember
UNION 
SELECT StudentPhone, Aff_Dep, College_ID, 'Student College Member' AS MemberTYPE FROM StudentCollegeMember
UNION
SELECT ProfessorPhone, Aff_Dep, College_ID, 'Professor College Member' AS MemberTYPE FROM ProfessorCollegeMember
ORDER BY MemberTYPE;

-- 13. Information about sender, receiver, advertisement ID, and message content

SELECT StaffPhone AS Phone, Aff_Dep, CollegeID, 'Staff_CollegeMember' AS MemberTYPE FROM Staff_CollegeMember
UNION 
SELECT StudentPhone, Aff_Dep, CollegeID, 'Student_CollegeMember' AS MemberTYPE FROM Student_CollegeMember
UNION
SELECT ProfessorPhone, Aff_Dep, CollegeID, 'Professor_CollegeMember' AS MemberTYPE FROM Professor_CollegeMember
ORDER BY MemberTYPE;

-- 14. Number of posts (by student/professor/staff) with associated messages

SELECT CONCAT(Person.LastName, ',', Person.FirstName ) AS FullName, Person.MemberPhone, Professor_CollegeMember.Aff_Dep ,Professor_CollegeMember.CollegeID, Advertisement_Message.AdID, Advertisement_Message.Content
FROM Person
INNER JOIN Professor_CollegeMember ON  Person.MemberPhone = Professor_CollegeMember.ProfessorPhone
INNER JOIN Advertisement ON Advertisement.MemberPhone = Person.MemberPhone
INNER JOIN Advertisement_Message ON Advertisement_Message.AdID = Advertisement.AdID;

SELECT CONCAT(Person.LastName, ',', Person.FirstName ) AS FullName, Person.MemberPhone, Student_CollegeMember.Aff_Dep, Student_CollegeMember.CollegeID, Advertisement_Message.AdID, Advertisement_Message.Content
FROM Person
INNER JOIN Student_CollegeMember ON  Person.MemberPhone = Student_CollegeMember.StudentPhone
INNER JOIN Advertisement ON Advertisement.MemberPhone = Person.MemberPhone
INNER JOIN Advertisement_Message ON Advertisement_Message.AdID = Advertisement.AdID;

SELECT CONCAT(Person.LastName, ',', Person.FirstName ) AS FullName, Person.MemberPhone, Staff_CollegeMember.Aff_Dep, Staff_CollegeMember.CollegeID, Advertisement_Message.AdID, Advertisement_Message.Content
FROM Person
INNER JOIN Staff_CollegeMember ON  Person.MemberPhone = Staff_CollegeMember.StaffPhone
INNER JOIN Advertisement ON Advertisement.MemberPhone = Person.MemberPhone
INNER JOIN Advertisement_Message ON Advertisement_Message.AdID = Advertisement.AdID;

-- 15. ID of the most recently approved advertisement

SELECT MAX (AdID) AS [Last Advertisment approved] 
FROM Advertisement_Message ;

SELECT AdID AS LastAdvertisementApproved, MAX(ApprovalDate)
FROM Staff_Approves_Advertisement;

-- 16. List of advertisements with number of associated messages

SELECT AdID, COUNT(AdID) AS QtyMessage 
FROM Advertisement_Message 
GROUP BY AdID 
ORDER BY QtyMessage DESC;

-- 17. Information about board location and advertisement IDs for floors between 1 and 2 in a specific building

SELECT BoardLocation.FloorNumber, BoardLocation.Building, BoardLocation.BoardID, Advertisement_LocatedOn_BoardLocation.AdID 
FROM  BoardLocation
INNER JOIN Advertisement_LocatedOn_BoardLocation ON Advertisement_LocatedOn_BoardLocation.BoardID = BoardLocation.BoardID
WHERE FloorNumber BETWEEN 1 AND 2 AND BUILDING = 'NWM';

-- 18. Search for members by the first letter of their first name (e.g., starting with "G")

SELECT FirstName, LastName, MemberPhone FROM Person
WHERE FirstName LIKE 'G%';

-- 19. Information about boards located in buildings other than ANV and COQ

SELECT * FROM BoardLocation
WHERE Building NOT IN ('COQ', 'ANV');

-- 20. Visibility percentage of each advertisement based on the floor it's posted on
--     Rule:
--     Floor 1 = 50% visibility
--     Floor 2 = 35% visibility
--     Floor ≥ 3 = 15% visibility

SELECT Advertisement_LocatedOn_BoardLocation.AdID, BoardLocation.FloorNumber, BoardLocation.Building, BoardLocation.BoardID,
CASE 
WHEN FloorNumber = 1 THEN 'THIS POST HAS 50% OF VISIBILITY'
WHEN FloorNumber = 2 THEN 'THIS POST HAS 35% OF VISIBILITY'
WHEN FloorNumber >= 3 THEN 'THIS POST HAS 15% OF VISIBILITY'
ELSE 'undefined'
END AS Visibility
FROM  BoardLocation
INNER JOIN Advertisement_LocatedOn_BoardLocation ON Advertisement_LocatedOn_BoardLocation.BoardID = BoardLocation.BoardID;


-- 21. Rename a building (e.g., changing 'ANV' to 'VAN')

--     Note: The second method requires:
--     1. Disabling safe update mode in SQL Editor preferences
--     2. Reconnecting to the server afterward

UPDATE BoardLocation 
SET Building = 'ANV' 
Where Building = 'VAN' AND BoardID = 311;

/*OR*/

UPDATE BoardLocation 
SET Building = 'VAN' 
Where Building = 'ANV'; 

-- 22. Delete advertisements with outdated post dates

DELETE FROM Advertisement
WHERE Post_Date < '2022-09-01';

-- 23. Create a view of advertisements with the largest dimensions

CREATE VIEW AnnouncementsWithBiggestSizes AS
SELECT AdID, Adv_Type, Post_Title
FROM Advertisement 
WHERE SizeDim_Length > 10 AND SizeDim_Width > 10;

SELECT * FROM AnnouncementsWithBiggestSizes

-- 24. Advertisements located above the second floor, including their building, floor, and owner's contact info

SELECT Advertisement_LocatedOn_BoardLocation.AdID, BoardLocation.FloorNumber, Advertisement.MemberPhone, Person.Email,BoardLocation.Building
FROM Advertisement_LocatedOn_BoardLocation
INNER JOIN BoardLocation ON BoardLocation.BoardID = Advertisement_LocatedOn_BoardLocation.BoardID
INNER JOIN Advertisement ON Advertisement.AdID =Advertisement_LocatedOn_BoardLocation.AdID
INNER JOIN Person ON Person.MemberPhone = Advertisement.MemberPhone
WHERE Advertisement_LocatedOn_BoardLocation.BoardID IN (
SELECT BoardLocation.BoardID FROM BoardLocation
WHERE BoardLocation.FloorNumber > 2);
