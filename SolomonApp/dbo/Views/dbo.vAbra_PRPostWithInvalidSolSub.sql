CREATE VIEW vAbra_PRPostWithInvalidSolSub
	AS
	SELECT p.CpnyID, p.ChargeDate, p.EmpNo, hr.FirstName, hr.LastName, 
	p.OrgLevel1, p.OrgLevel2, p.OrgLevel3,
	Sub = RTrim(o1.code) + RTrim(o2.code) + RTrim(o3.code)
	FROM vAbra_PRPost p
	LEFT JOIN vAbra_OrgLevel1 o1 ON p.OrgLevel1 = o1.code
	LEFT JOIN vAbra_OrgLevel2 o2 ON p.OrgLevel2 = o2.code
	LEFT JOIN vAbra_OrgLevel3 o3 ON p.OrgLevel3 = o3.code
	JOIN vAbra_HRPersnl hr ON p.CpnyID = hr.CpnyID and p.EmpNo = hr.EmpNo
	WHERE RTrim(o1.code) + RTrim(o2.code) + RTrim(o3.code)
		NOT IN (Select Sub From SubAcct WHERE Active = 1)
