create view dbo.cfv_FIRST75M_ROOM
AS
SELECT dbo_cftPigGroup.PigGroupID, dbo_cftPigGroupRoom.RoomNbr, dbo_cftPigGroup.Description, Min(dbo_cftFeedOrder.DateSched) AS MinOfDateSched
FROM cftPigGroupRoom dbo_cftPigGroupRoom 
INNER JOIN (((cftFeedOrder dbo_cftFeedOrder 
INNER JOIN cftContact dbo_cftContact ON dbo_cftFeedOrder.ContactId = dbo_cftContact.ContactID) 
INNER JOIN cftPigGroup dbo_cftPigGroup ON dbo_cftFeedOrder.PigGroupId = dbo_cftPigGroup.PigGroupID) 
INNER JOIN (cftBinType dbo_cftBinType 
INNER JOIN cftBin dbo_cftBin ON dbo_cftBinType.BinTypeID = dbo_cftBin.BinTypeID) ON dbo_cftFeedOrder.ContactId = dbo_cftBin.ContactID) ON dbo_cftPigGroupRoom.PigGroupID = dbo_cftPigGroup.PigGroupID
GROUP BY dbo_cftPigGroup.PigGroupID, dbo_cftPigGroupRoom.RoomNbr, dbo_cftPigGroup.Description, dbo_cftPigGroup.PGStatusID, dbo_cftFeedOrder.InvtIdOrd
HAVING (((dbo_cftPigGroup.PGStatusID)='a') AND ((dbo_cftFeedOrder.InvtIdOrd)='075M'))