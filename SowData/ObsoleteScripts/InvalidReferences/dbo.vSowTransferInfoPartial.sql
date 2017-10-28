--------------------------------------------------------------------------------------------------------------------
-- Detail of Sows that are transferred from a breeding farm to another sow farm without the history
--	this is used in calculating sow transferred gestation days 
--	so they can be added to the gestation days at the destination farm
-- 	Ron is using this in calculating gestation feed consumption by sow
-- This detail is used in vPM2_TransferDays view that is loaded into the sow cube
-- CREATED BY: CANDERSON
-- CREATED ON: 2/17/2005 
--------------------------------------------------------------------------------------------------------------------
CREATE VIEW vSowTransferInfoPartial (FarmID, SowID, SowGenetics, SowParity, TransferInDate, MateDate, SourceFarmID, 
	XferGestDays)
	AS	
	
	Select s.FarmID, s.SowID, s.Genetics, IsNull(sg.SowParity,0), ss.RemovalDate, sg.EventDate As MateDate, 
	ss.FarmID, DateDiff(day,sg.EventDate,ss.RemovalDate)
	FROM SowTemp s WITH (NOLOCK)
	JOIN Sow ss WITH (NOLOCK) ON s.FarmID = ss.PrimaryReason AND s.SowID = ss.SowID AND ss.RemovalType = 'TRANSFER' and ss.FarmID<>'B01'
	LEFT JOIN SowGroupEvent sg WITH (NOLOCK) ON s.FarmID = sg.FarmID AND s.SowID = sg.SowID
		AND sg.EventID = (Select TOP 1 EventID FROM SowGroupEvent WITH (NOLOCK) WHERE FarmID = s.FarmID AND SowID = s.SowID ORDER BY EventDate DESC)
	WHERE ss.EntryDate<>s.EntryDate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowTransferInfoPartial] TO [se\analysts]
    AS [dbo];

