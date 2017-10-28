CREATE VIEW vAbra_OrgLevel3 (Code, Company, Description, GLComp)
	-- View of Abra HRTABLES table
	As
	select code, company, [desc], glcomp from OPENQUERY(ABRADATA,'Select * from HRTables')
	WHERE [table] = 'L3' AND code <> '_ENT_'

