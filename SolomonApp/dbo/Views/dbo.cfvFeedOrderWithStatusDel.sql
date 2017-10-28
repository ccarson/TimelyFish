
/****** Object:  View dbo.cfvFeedOrderWithStatusDel    Script Date: 11/3/2005 8:25:57 AM ******/




CREATE         VIEW cfvFeedOrderWithStatusDel
	AS
---------------------------------------------------------------------------------------
-- PURPOSE: logic for order lookup prior
-- CREATED BY: SMATTER
-- CREATED ON: 10/25/05
-- USED BY: XF120
---------------------------------------------------------------------------------------
--SELECT  fo.PigGroupID, fo.RoomNbr, Qty = Sum(QtyDel/PGQty * CASE Reversal WHEN 1 THEN -1 ELSE 1 END)+  (CASE fo.RoomNbr WHEN '' THEN pg.PriorFeedQty ELSE rm.PriorFeedQty END)
SELECT  fo.PigGroupID, fo.RoomNbr, 
	Qty = Sum(QtyDel/PGQty * CASE Reversal WHEN 1 THEN -1 ELSE 1 END)
	--PriorF=(CASE fo.RoomNbr WHEN '' THEN pg.PriorFeedQty ELSE rm.PriorFeedQty END)
	FROM cftFeedOrder fo
	JOIN cftPigGroup pg ON fo.PigGroupID=pg.PiggroupID
	LEFT JOIN cftPigGroupRoom rm ON fo.PiggroupID=rm.PigGroupID AND fo.RoomNbr=rm.RoomNbr
	WHERE fo.Status = 'C' 
	Group by fo.PigGroupID, fo.RoomNbr









