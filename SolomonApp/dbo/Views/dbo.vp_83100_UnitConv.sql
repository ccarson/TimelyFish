 

CREATE VIEW dbo.vp_83100_UnitConv
AS
	SELECT	
		InvtID = i.InvtID, 
		MultDiv = MAX(COALESCE( iu.MultDiv, cu.MultDiv, gu.MultDiv, 'M' )),
		CnvFact = MAX(COALESCE( iu.CnvFact, cu.CnvFact, gu.CnvFact, 1.0 ))
	FROM 	Inventory i
	LEFT OUTER JOIN INUnit AS gu -- Global 
		ON gu.UnitType  = 1
		AND gu.FromUnit = i.StkUnit
		AND gu.ToUnit   = i.DfltSOUnit
	LEFT OUTER JOIN INUnit AS cu -- Item Class
		ON cu.UnitType  = 2
		AND cu.ClassID  = i.ClassID
		AND cu.FromUnit = i.StkUnit
		AND cu.ToUnit   = i.DfltSOUnit
	LEFT OUTER JOIN INUnit AS iu -- Inventory Item
		ON iu.UnitType  = 3
		AND iu.InvtID   = i.InvtID
		AND iu.FromUnit = i.StkUnit
		AND iu.ToUnit   = i.DfltSOUnit
	GROUP BY 
		i.InvtID


 
