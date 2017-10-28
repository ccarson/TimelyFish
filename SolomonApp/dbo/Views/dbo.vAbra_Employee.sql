CREATE   VIEW vAbra_Employee (CpnyID, EmpNo, FirstName, LastName, OrgLevel1, OrgLevel2, OrgLevel3, SSNLast4,JobCode, JobTitle, Status, EmpType, LastHireDate, LastChangeDate) 
	-- View of Abra HRPersnl table
	As
	SELECT Convert(char(10),p_company), 
	right(rtrim(p_empno),4), p_fname, p_lname, p_level1, p_level2, p_level3, Right(p_ssn,4), p_jobCode,p_JobTitle, p_active, p_employ, p_sendate, p_chadate
	FROM OPENQUERY(ABRADATA,'Select * from HRPersnl')
