
CREATE VIEW cfvFeedOrderPriorFeed
	AS
---------------------------------------------------------------------------------------
-- PURPOSE: Calculate average Prior Feed
-- CREATED BY: SMATTER
-- CREATED ON: 12/6/05
-- USED BY: Brent
---------------------------------------------------------------------------------------
SELECT PigGroupID, RoomNbr,
        NumberofOrders = Count(OrdNbr),
	PriorFeed = Sum(AvgWgt)
	FROM cftFeedOrder fo
	WHERE Status <> 'X' AND ISNULL(PigGroupID,'')<>'' AND AvgWgt<>0
	Group by PigGroupID, RoomNbr

