CREATE VIEW vPM2_TransferDaysQty (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	Select FarmID, WeekOfDate, SowGenetics,SowParity,Sum(Qty)
	FROM
	(SELECT v.FarmID, dd.WeekOfDate, v.SowGenetics, v.SowParity,
		Qty = Count(*)
	FROM vSowTransferInfo v WITH (NOLOCK)
	JOIN DayDefinitionTemp dd WITH (NOLOCK) ON dd.DayDate >= v.MateDate AND dd.DayDate < v.TransferInDate
	GROUP BY v.FarmID, dd.WeekOfDate, v.SowGenetics, v.SowParity
	UNION
	SELECT v.FarmID, dd.WeekOfDate, v.SowGenetics, v.SowParity, 
		Qty = Count(*)*-1
	FROM vSowTransferInfoPartial v WITH (NOLOCK)
	JOIN DayDefinitionTemp dd WITH (NOLOCK) ON dd.DayDate >= v.TransferINDate AND dd.DayDate < v.MateDate
	GROUP BY v.FarmID, dd.WeekOfDate, v.SowGenetics, v.SowParity) as temp
	GROUP BY FarmID, WeekOfDate,SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_TransferDaysQty] TO [se\analysts]
    AS [dbo];

