--  CAU 1 : Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
use testingSystem;
SELECT * FROM `account` AS ac
JOIN Department on ac.DepartmentID = department.DepartmentID;
;
SELECT *
from `Account` as a1
JOIN department as d1 on a1.DepartmentID = d1.DepartmentID;
-- cach 2 su dung co the su dung using khi cung khoa ngoai 
SELECT *
from `Account` as a1
JOIN department as d1 using (DepartmentID);
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT * 
FROM `Account`
HAVING CreateDate > '2010-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT *
from `Account` as a1
JOIN position using (PositionID)
WHERE PositionName = 'Dev' ;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên (hoi lai)
SELECT *
FROM department AS a
 JOIN `Account` as d ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID) >= 2 ; -- chinh lai >=2 cho phu hop du lieu

SELECT * FROM `department`;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
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

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT *, COUNT(CategoryID),CategoryName
FROM question
JOIN categoryquestion using (CategoryID)
GROUP BY CategoryID;


-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT *, COUNT(QuestionID)
FROM examquestion
JOIN exam using (ExamID)
GROUP BY QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất

SELECT *, COUNT(QuestionID)
FROM answer
GROUP BY QuestionID
HAVING COUNT(QuestionID) = (SELECT COUNT(QuestionID) FROM answer 
							GROUP BY QuestionID
							ORDER BY COUNT(QuestionID) DESC
							LIMIT 1) ;

-- Thống kê số lượng account trong mỗi group
SELECT *, COUNT(ga.AccountID)
		FROM `group` AS a
		JOIN groupaccount as ga
		USING(groupID)
		GROUP BY GroupID ;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT COUNT(DepartmentID) ,DepartmentName
FROM  `Account`
JOIN department using (DepartmentID)
GROUP BY DepartmentID
ORDER  BY COUNT(DepartmentID) ASC 
LIMIT 1;


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, 
-- loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...

SELECT *
FROM question as ch
JOIN examquestion as tl USING (QuestionID)
JOIN typequestion AS kieuch USING (TypeID)
JOIN `account` as ac ON ch.CreatorID = ac.AccountID;


-- Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT  TypeName , COUNT(TypeID)
 FROM question 
 JOIN typequestion USING (TypeID)
 GROUP BY TypeID
 HAVING COUNT(TypeID) = (SELECT COUNT(TypeID) FROM question WHERE TypeID = 1) or 
COUNT(TypeID)=  (SELECT COUNT(TypeID) FROM question WHERE TypeID = 2);

select * from examquestion;
 SELECT * FROM typequestion;
 SELECT * FROM question;
SELECT * FROM  categoryquestion;
-- Question 14:Lấy ra group không có account nào 
select * FROM `group`;

SELECT * FROM groupaccount; 


SELECT *, COUNT(AccountID)
FROM `account`as ac
JOIN `groupaccount`as ga USING (AccountID)
RIGHT JOIN `group` as gr  ON   ga.GroupID = gr.GroupID 
GROUP BY AccountID
HAVING COUNT(AccountID) = 0  ;

-- Question 16: Lấy ra question không có answer nào
SELECT * from answer;
SELECT QuestionID  FROM answer  
JOIN  question USING (QuestionID)
GROUP BY QuestionID
HAVING QuestionID = 0;
(SELECT QuestionID from answer GROUP BY QuestionID HAVING COUNT(QuestionID) = '1' );

-- -- Question 17: a) Lấy các account thuộc nhóm thứ 1

SELECT * FROM `account`;
SELECT * FROM `group`;
SELECT * FROM groupaccount;

SELECT * FROM `account`
JOIN groupaccount USING (AccountID)
WHERE GroupID = 1;

-- Lấy các account thuộc nhóm thứ 3


SELECT * FROM `account`
JOIN groupaccount USING (AccountID)
WHERE GroupID = 3;



-- Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau 
SELECT * FROM `account`
JOIN groupaccount USING (AccountID)
WHERE GroupID = 1
UNION
SELECT * FROM `account`
JOIN groupaccount USING (AccountID)
WHERE GroupID = 3;
-- Lấy các group có lớn hơn 5 thành viên

SELECT *, COUNT(AccountID)
FROM `GroupAccount` AS ga
JOIN `group`as g using (GroupID)
GROUP BY AccountID
HAVING COUNT(AccountID) > '5';
SELECT * FROM `group`;
SELECT * FROM `GroupAccount`;
-- Lấy các group có nhỏ hơn 7 thành viên
SELECT *, COUNT(AccountID)
FROM `GroupAccount` AS ga
JOIN `group`as g using (GroupID)
GROUP BY AccountID
HAVING COUNT(AccountID) < '7';

SELECT *, COUNT(AccountID)
FROM `GroupAccount` AS ga
JOIN `group`as g using (GroupID)
GROUP BY AccountID
HAVING COUNT(AccountID) > '5'
Union
SELECT *, COUNT(AccountID)
FROM `GroupAccount` AS ga
JOIN `group`as g using (GroupID)
GROUP BY AccountID
HAVING COUNT(AccountID) < '7';
