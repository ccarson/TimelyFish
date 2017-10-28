CREATE view [dbo].[vPM2_NaturalLitterWeanDetail] (FarmID, SowID, SowParity, SowGenetics, WeekOfDate, WeanQty, FarrowQty, NatQty, WeanAgeDays)
	AS
select we.farmid, we.SowID, we.SowParity, we.SowGenetics, we.WeekOfDate, WeanQty=we.Qty, FarrowQty=fe.QtyBornAlive, NatQty=CASE WHEN fe.QtyBornAlive-we.Qty < 0 THEN fe.QtyBornAlive ELSE we.Qty END,
	WeanAgeDays=CASE WHEN DateDiff(day,fe.EventDate,we.EventDate) < 9 THEN '<=8'
		WHEN DateDiff(day,fe.EventDate,we.EventDate) > 34 THEN '>=35'
		ELSE RTrim(convert(varchar(2),DateDiff(day,fe.EventDate,we.EventDate))) END
	FROM SowWeanEventTemp we
	LEFT JOIN SowNurseEventTemp ne -- JOIN TO FILTER OUT SOWS THAT HAD A NURSE ON EVENT (OR EVEN NURSE OFF, but we do not use this currently)
		ON we.FarmID = ne.FarmID
		AND we.SowID = ne.SowID
		AND we.SowParity = ne.SowParity
		AND ne.SowID Is Null
	JOIN SowFarrowEventTemp fe  -- JOIN FOR GETTING FARROW DATE
		ON we.FarmID = fe.FarmID
		AND we.SowID = fe.SowID
		AND we.SowParity = fe.SowParity
		AND we.EventDate >= fe.EventDate
	JOIN vPM2_FirstWeanDetail fw on we.FarmID=fw.FarmID and we.SowID=fw.SowID and we.SowParity=fw.SowParity --and we.SortCode=fw.SortCode removed because we no longer use sortcode 20130620 smr
	WHERE (we.EventType = 'WEAN' OR (we.EventType = 'PART WEAN' and we.Qty < 3))
			
			
	AND we.Qty > 0  -- NURSE OFF's are recorded as a WEAN of 0 qty

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_NaturalLitterWeanDetail] TO [se\analysts]
    AS [dbo];

