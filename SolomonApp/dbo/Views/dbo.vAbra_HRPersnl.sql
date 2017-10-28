CREATE VIEW vAbra_HRPersnl (CpnyID, EmpNo, FirstName, LastName, OrgLevel1, OrgLevel2, OrgLevel3) 
	-- View of Abra HRPersnl table
	As
	select p_company, p_empno, p_fname, p_lname, p_level1, p_level2, 
	p_level3 
	FROM OPENQUERY(ABRADATA,'Select * from HRPersnl')
	WHERE p_active In('A','L')
