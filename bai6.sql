-- tao 1 ham thu tuc lay ra danh sach phong ban
USE testingsystem;
DELIMITER $$
CREATE PROCEDURE get_all_department()
	BEGIN
		SELECT *  FROM department;
	END $$
DELIMITER $$;
DROP PROCEDURE IF EXISTS get_all_department()
DELIMITER $$
CREATE PROCEDURE get_all_account_of_department(IN tenPhongBan Nvarchar(50))
	BEGIN
		SELECT *  FROM account
        JOIN department USING (DepartmentID)
        WHERE DepartmentName = 'Sale' ;
	END $$
DELIMITER $$;

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
SELECT * From `group`;
DELIMITER $$
CREATE PROCEDURE get_all_account_soluong(IN GroupID TINYINT)
	BEGIN
		SELECT *, COUNT(AccountID)
		FROM GroupAccount AS a
		JOIN `Group` as d
		WHERE d.CreatorID = a.GroupID
		HAVING COUNT(AccountID);
	END $$
DELIMITER $$;
call get_all_account_soluong('2');

DELIMITER $$
CREATE PROCEDURE get_all_account_soluong1(IN GroupID TINYINT)
	BEGIN
		SELECT *, COUNT(AccountID)
		FROM GroupAccount AS a
		JOIN `Group` as d
		WHERE d.CreatorID = a.GroupID
		HAVING COUNT(AccountID);
	END $$
DELIMITER $$;

get_all_account_soluongwget_all_account_soluongwDELIMITER $$
CREATE PROCEDURE get_all_account_soluongw()
	BEGIN
		SELECT *, COUNT(AccountID)
		FROM GroupAccount AS a
		JOIN `Group` as d
		WHERE d.CreatorID = a.GroupID
		HAVING COUNT(AccountID);
	END $$
DELIMITER $$;

DELIMITER $$
CREATE PROCEDURE get_all_account_soluongAw()
	BEGIN
		SELECT *, COUNT(ga.AccountID)
		FROM `group` AS a
		JOIN groupaccount as ga
		On ga.GroupID = a.GroupID
		GROUP BY GroupID ;
	END $$
DELIMITER $$;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS TYPEQS();
DELIMITER $$
CREATE PROCEDURE TYPEQS()
	BEGIN
		SELECT *
		FROM question
		Inner JOIN typequestion
		Using (TypeID)
		GROUP BY TypeID 
        Having month(CreateDate) = month (now()) and year(CreateDate) = year(now())
        ;
	END $$
DELIMITER $$;

select * from question;

DELIMITER $$
CREATE PROCEDURE TYPEQSssa()
	BEGIN
		SELECT *
		FROM question
		Inner JOIN typequestion
		Using (TypeID)
		Where month(CreateDate) = month (now()) and year(CreateDate) = year(now())
		GROUP BY TypeID 
        ;
	END $$
DELIMITER $$;