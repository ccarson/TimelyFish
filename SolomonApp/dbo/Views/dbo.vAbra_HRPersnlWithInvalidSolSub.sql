CREATE  VIEW dbo.vAbra_HRPersnlWithInvalidSolSub
	AS
	SELECT h.*, Sub = RTrim(o1.code) + RTrim(o2.code) + RTrim(o3.code)
	FROM vAbra_HRPersnl h
	LEFT JOIN vAbra_OrgLevel1 o1 ON h.OrgLevel1 = o1.code
	LEFT JOIN vAbra_OrgLevel2 o2 ON h.OrgLevel2 = o2.code
	LEFT JOIN vAbra_OrgLevel3 o3 ON h.OrgLevel3 = o3.code
	WHERE RTrim(o1.code) + RTrim(o2.code) + RTrim(o3.code)
		NOT IN (Select Sub From SubAcct WHERE Active = 1)

