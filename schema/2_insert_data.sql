USE AdswiseDB;

INSERT INTO Person
VALUES ('6047101234', 'Sevgi', NULL, 'Toprak Cetin', 's.toprak@test.com'),
	 ('6047151234', 'Gokhan', NULL, 'Cetin', 'g.cetin@test.com'),
	 ('6046183489', 'Jim', NULL, 'Halpert', 'j.halpert@test.com'),
       ('5303219048', 'Fazli', NULL, 'Toprak', 'f.toprak@test.com'),
       ('5325613423', 'Melek', NULL, 'Toprak', 'm.toprak@test.com'),
       ('5516758901', 'Ginny', 'Led', 'Wesley', 'g.l.wesley@test.com'),
       ('6047120690', 'Michael', 'Kimt', 'Scott', 'm.k.scott@test.com'),
       ('6047149847', 'Dwight', 'Done', 'Schrute', 'd.schrute@test.com');

INSERT INTO NonCollegeMember 
VALUES ('5303219048', 103285, '2021/05/08'),
	 ('5325613423', 103524, '2021/06/21');

INSERT INTO Student_CollegeMember 
VALUES ('6046183489', 'BUSN', 'Accounting', 3035214),
	 ('6047101234', 'CSIS', 'Computer and Information Systems', 3035247),
       ('5516758901', 'FINC', 'Finance', 3035234);

INSERT INTO Staff_CollegeMember 
VALUES ('6047151234', 'Coordinator', 'Finance', 2046584, 'S3024', '2019/08/26'),
	 ('6047120690', 'Adm. Assistant', 'Computer and Information Systems', 2041385, 'N4216', '2016/02/10');
       
INSERT INTO Professor_CollegeMember 
VALUES ('6047149847', 'MA', 'Business', 4028465, 'N3258', '2020/11/22');

INSERT INTO Advertisement
VALUES (1000, 'Roommate', '2022/10/06', '2022/10/12', 10.25, 15.80, 'Looking for non-smoker roommate', '5516758901'),
	 (1001, 'Event', '2022/09/22', '2022/09/30', 15.3, 20.5, 'Welcome Party for International Students!', '6047120690'),
       (1002, 'Tutorship', '2022/09/10', '2022/09/20', 14, 18, 'Private Tutorship for Math', '6046183489'),
       (1003, 'Selling', '2022/10/02', '2022/10/08', 8.5, 12, 'Texas BA+ Calculator, $15', '6046183489');

INSERT INTO BoardLocation 
VALUES (111, 'NWM', 01, 'S1030'),
	 (112, 'NWM', 03, 'S3260'),
       (113, 'NWM', 02, 'N2240'),
       (211, 'COQ', 02, 'N2354'),
       (212, 'COQ', 04, 'S4016'),
       (311, 'ANV', 13, 'S1325');
       
INSERT INTO Person_Advertisement_Message 
VALUES ('6047101234', '6046183489', 1003, 1524, 'Availability', '13:25:08', '2022/10/06'),
	 ('6047101234', '5516758901', 1000, 1580, 'Apartment tour', '11:18:24', '2022/10/09'),
       ('5303219048', '6046183489', 1002, 1462, 'Hourly price', '15:05:32', '2022/09/15'),
       ('5325613423', '6046183489', 1002, 1473, 'Hours per week', '14:21:44', '2022/09/17');
       
INSERT INTO Advertisement_Message 
VALUES (1003, 1524, 'Availability', '13:25:08', '2022/10/06'),
	 (1000, 1580, 'Apartment tour', '11:18:24', '2022/10/09'),
 	 (1002, 1462, 'Hourly price', '15:05:32', '2022/09/15'),
 	 (1002, 1473, 'Hours per week', '14:21:44', '2022/09/17');

INSERT INTO Person_Sends_Message 
VALUES (6047101234, 1003, 1524),
	 (6047101234, 1000, 1580),
	 (5303219048, 1002, 1462),
	 (5325613423, 1002, 1473);

INSERT INTO Person_Receives_Message 
VALUES (6046183489, 1003, 1524),
	 (5516758901, 1000, 1580),
	 (6046183489, 1002, 1462),
	 (6046183489, 1002, 1473);

INSERT INTO Staff_Approves_Advertisement
VALUES (1000, '6047151234', '2022/10/06'),
	 (1001, '6047120690', '2022/09/21'),
       (1002, '6047120690', '2022/09/09'),
       (1003, '6047151234', '2022/10/02');
       
INSERT INTO Advertisement_LocatedOn_BoardLocation
VALUES (1000, 112),
	 (1000, 311),
       (1001, 212),
       (1002, 311),
       (1002, 111),
       (1003, 113);
