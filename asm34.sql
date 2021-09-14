-- lấy ra thông tin account có full name dài nhất--
SELECT *, length(Fullname) 
From `Account`
WHERE length(Fullname) = (Select max(length(Fullname)) From `Account`);
-- cach 2
SELECT MAX(length(Fullname)) FROM `Account`;
SELECT length(Fullname)
FROM `Account`
ORDER BY length(Fullname) DESC
LIMIT 1;

-- Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3

SELECT *, length(Fullname) 
From `Account`
WHERE length(Fullname) = (Select max(length(Fullname)) From `Account` WHERE DepartmentID = 3) && DepartmentID = 3;

-- Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT * 
FROM `GroupAccount`
HAVING JoinDate < '2019-12-20';

-- Lấy ra ID của question có >= 4 câu trả lời
SELECT * ,`QuestionID`, count(QuestionID)
FROM answer
GROUP BY (QuestionID)
HAVING count(QuestionID) >=4;

-- 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019

-- 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * 
FROM  `Group`
ORDER BY CreateDate
LIMIT 5;
SELECT * FROM `Account`;
--  nhan vien co nhan vien deparmant =2 

SELECT *, COUNT(DepartmentID)
from `Account`
WHERE DepartmentID = 3
GROUP BY  DepartmentID;

-- Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o" hoi lai 
SELECT *, substring_index(FullName,' ', -1) as ten
from `Account`
WHERE  substring_index(FullName,' ', -1) like 'D%o';


-- ASM4

-- Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT *
from `Account` as a1
JOIN department as d1 on a1.DepartmentID = d1.DepartmentID;
-- cach 2 su dung co the su dung using khi cung khoa ngoai 
SELECT *
from `Account` as a1
JOIN department as d1 using (DepartmentID);

-- Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT * 
FROM `Account`
HAVING CreateDate > '2010-12-20';

-- Viết lệnh để lấy ra tất cả các developer
SELECT *
from `Account` as a1
JOIN position using (PositionID)
WHERE PositionName = 'Dev' ;

-- Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT *
FROM department d
JOIN `Account` a ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID) >3;

-- Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

SELECT QuestionID, COUNT(QuestionID)
FROM examquestion
GROUP BY QuestionID
HAVING COUNT(QuestionID) = (SELECT COUNT(QuestionID) FROM examquestion 
GROUP BY QuestionID
ORDER BY COUNT(QuestionID) DESC
LIMIT 1) ;

-- cau lenh con
SELECT COUNT(QuestionID) FROM examquestion 
GROUP BY QuestionID
ORDER BY COUNT(QuestionID) DESC
LIMIT 1;

-- Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT *, COUNT(CategoryID),CategoryName
FROM question
JOIN categoryquestion using (CategoryID)
GROUP BY CategoryID;

-- 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT *, COUNT(QuestionID)
FROM examquestion
JOIN exam using (ExamID)
GROUP BY QuestionID;

-- Lấy ra Question có nhiều câu trả lời nhất

SELECT *, COUNT(QuestionID)
FROM answer
GROUP BY QuestionID
HAVING COUNT(QuestionID) = (SELECT COUNT(QuestionID) FROM answer 
							GROUP BY QuestionID
							ORDER BY COUNT(QuestionID) DESC
							LIMIT 1) ;

-- Thống kê số lượng account trong mỗi group
SELECT *, COUNT(AccountID)
FROM GroupAccount AS a
JOIN `Group` as d
WHERE d.CreatorID = a.GroupID
HAVING COUNT(AccountID);

-- Tìm chức vụ có ít người nhất
 
 
SELECT COUNT(DepartmentID) ,DepartmentName
FROM  `Account`
JOIN department using (DepartmentID)
GROUP BY DepartmentID
ORDER  BY COUNT(DepartmentID) ASC 
LIMIT 1;
-- khong hieu
SELECT COUNT(AccountID) ,GroupID
FROM  GroupAccount
JOIN `Account` using (AccountID)
WHERE AccountID = NULL;