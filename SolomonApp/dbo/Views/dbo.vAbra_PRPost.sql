CREATE VIEW vAbra_PRPost (CpnyID, EmpNo, OrgLevel1, OrgLevel2, OrgLevel3, ChargeDate)
	-- View of Abra prpost table
	As
	select company, empno, orglevel1, orglevel2, orglevel3, chargedate
	FROM OPENQUERY(ABRADATA,'Select * from prpost')
	WHERE allocind <> 'Y'
