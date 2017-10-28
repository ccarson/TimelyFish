
/****** Object:  View dbo.cfvFeedOrderGroupPrior    Script Date: 11/10/2005 1:49:54 PM ******/




CREATE  VIEW cfvFeedOrderGroupPrior
AS
---------------------------------------------------------------------------------------
-- PURPOSE: logic for order lookup prior
-- CREATED BY: SMATTER
-- CREATED ON: 10/25/05
-- USED BY: XF120
---------------------------------------------------------------------------------------
--SELECT  fo.PigGroupID, fo.RoomNbr, Qty = Sum(QtyDel/PGQty * CASE Reversal WHEN 1 THEN -1 ELSE 1 END)+  (CASE fo.RoomNbr WHEN '' THEN pg.PriorFeedQty ELSE rm.PriorFeedQty END)
SELECT  pg.PigGroupID, 
	rm.RoomNbr,
	PriorF=(CASE ISNULL(rm.RoomNbr,'') WHEN '' THEN pg.PriorFeedQty ELSE rm.PriorFeedQty END)
	FROM cftPigGroup pg 
	LEFT JOIN cftPigGroupRoom rm ON pg.PiggroupID=rm.PigGroupID 
	Group by pg.PigGroupID, rm.RoomNbr, pg.PriorFeedQty, rm.PriorFeedQty











