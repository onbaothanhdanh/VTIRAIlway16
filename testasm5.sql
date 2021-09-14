use `testingsystem`;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale

CREATE VIEW nvsale AS
SELECT AccountID, Username,DepartmentName
from `Account`, Department
WHERE DepartmentName = 'Sale';
SELECT * from nvsale;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

DROP VIEW moreaccount;
CREATE VIEW moreaccount as
SELECT  GroupID, AccountID, COUNT(AccountID)
FROM GroupAccount 
GROUP BY  AccountID
HAVING COUNT(AccountID) = (SELECT COUNT(AccountID)
FROM GroupAccount
GROUP BY AccountID
ORDER BY COUNT(AccountID) DESC
LIMIT 1) ;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài: sua lai con 10 ky tu cho phu hop du lieu )
-- và xóa nó đi

DROP VIEW contentquadai;
CREATE VIEW contentquadai as
select QuestionID,Content
from question
HAVING length(Content) > 10;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

DROP VIEW phongbannhieu;
CREATE VIEW phongbannhieu as
SELECT a.DepartmentID, DepartmentName
FROM department AS a
 JOIN `Account` as d ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID
ORDER BY a.DepartmentID DESC
LImit 3;


-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
select * from question ;
select * from `account` ;
CREATE VIEW honguyen as
SELECT QuestionID, Content, CreatorID
FROM question AS q
 JOIN   `account` as a ON q.CreatorID = a.AccountID
WHERE FullName LIKE  "Nguyen%"; 





