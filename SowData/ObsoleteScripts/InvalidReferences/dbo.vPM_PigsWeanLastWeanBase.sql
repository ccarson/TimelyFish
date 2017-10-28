CREATE VIEW dbo.vPM_PigsWeanLastWeanBase
	AS
	select FarmID, SowID, EventDate= Max(EventDate), WeekOfDate = Max(WeekOfDate), SowGenetics, SowParity, Qty = Sum(Qty)
		FROM dbo.vPM_SowLastWeanDatesDetail
		GROUP by FarmID, SowId, SowGenetics, SowParity


