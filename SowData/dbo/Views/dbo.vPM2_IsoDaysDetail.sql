CREATE VIEW vPM2_IsoDaysDetail (FarmID, GroupId, EffectiveDate, QtyOnHand, StartDate, CloseDate)
	-- 9/19/05 - By Tim Jones
	-- View is used to show effective inventory for a group from start date to close, if not
	-- close date exists, the view uses the current system date
	As
	SELECT pcg.FarmID, pcg.GroupId, dd.DayDate, 
	QtyOnHand = IsNull((Select sum(ie.qty * ie.inventoryeffect) 
			FROM PCGroupInventoryEvent ie
			WHERE ie.FarmID = pcg.FarmID 
			AND ie.GroupID = pcg.GroupID 
--CHANGED BY CHARITY 5/16/2006
			--AND ie.EventDate <= dd.DayDate
			AND ie.EventDate < dd.DayDate
			AND ie.EventSubType NOT LIKE '%BOAR%'),0)  -- FILTER OUT BOAR PURCHASES AND SALES -- boars are mingled
				--NEED TO ADD FILTER FOR BOAR DEATH - REASON '16'
	,pcg.StartDate, pcg.CloseDate
	FROM PCGroup pcg
	JOIN DayDefinition dd ON DayDate BETWEEN pcg.StartDate AND IsNull(pcg.CloseDate, GetDate())
	WHERE 
	-- need to filter out weaned pig groups - don't use in PigCHAMP anymore, but used to use before
	-- Solomon was implemented
	pcg.GroupID Not In(Select Distinct GroupID From PCGroupInventoryEvent 
				WHERE FarmID = pcg.FarmID
				AND EventType In('PURCHASE','SALES') AND EventSubType LIKE '%WEAN%')
	GROUP BY pcg.FarmID, pcg.GroupId, dd.DayDate, pcg.StartDate, pcg.CloseDate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_IsoDaysDetail] TO [se\analysts]
    AS [dbo];

