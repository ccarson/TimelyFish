CREATE VIEW dbo.vPM_NetFosterDetail
	As

	SELECT v.FarmID, v.SowID, EventDate = Max(v.EventDate), WeekOfDate = Max(v.WeekOfDate), SowGenetics, SowParity, WeanQty = Sum(Qty),
		FosterQty = (Select Sum(Qty) from SowFosterEvent Where FarmID = v.FarmID AND
				SowID = v.SowID AND SowParity = v.SowParity),
		NurseOnQty = IsNull((Select Sum(Qty) from SowNurseEvent Where FarmID = v.FarmID AND
				SowID = v.SowID AND SowParity = v.SowParity AND EventType = 'NURSE ON'),0),
		NurseOffQty = IsNull((Select Sum(Qty) from SowNurseEvent Where FarmID = v.FarmID AND
				SowID = v.SowID AND SowParity = v.SowParity AND EventType = 'NURSE OFF'),0)
	FROM dbo.vPM_LastWeaningsDetail v
	GROUP BY FarmID, SowID, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_NetFosterDetail] TO [se\analysts]
    AS [dbo];

