CREATE VIEW vPM2_NaturalLitterSowQty (FarmID,WeekOfDate,SowGenetics,SowParity,Acct,Qty)
	AS
select FarmID,WeekOfDate,SowGenetics,SowParity, 
	Acct='WeanAge' + RTrim(weanagedays)+'SowQty',
	Qty = Count(SowID)
	FROM vPM2_NaturalLitterWeanDetail
	--WHERE weekofdate = '2/27/05'
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics, WeanAgeDays

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_NaturalLitterSowQty] TO [se\analysts]
    AS [dbo];

