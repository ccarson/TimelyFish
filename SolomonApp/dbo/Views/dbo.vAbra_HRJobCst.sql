

CREATE      VIEW vAbra_HRJobCst (ChargeDate, CpnyID, EmpNo, OrgLevel1, OrgLevel2, OrgLevel3, Amount,
SubAcct) 
	-- View of Abra HRPersnl table
	As
	select ChargeDate, company, empno,rtrim(orglevel1), rtrim(orglevel2), left(orglevel3,4), 
	amount ,rtrim(orglevel1) + rtrim(orglevel2) + left(orglevel3,4)
	FROM OPENQUERY(ABRADATA,'Select * from prJobCst')




