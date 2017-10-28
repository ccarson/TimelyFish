
/****** Object:  View dbo.cfvFeedOrderWithStatusOpen    Script Date: 11/17/2005 11:40:09 AM ******/



CREATE       VIEW cfvFeedOrderWithStatusOpen
	AS
---------------------------------------------------------------------------------------
-- PURPOSE: logic for order lookup open
-- CREATED BY: SMATTER
-- CREATED ON: 10/25/05
-- USED BY: XF120
---------------------------------------------------------------------------------------
SELECT  PigGroupID, RoomNbr, Qty = Sum(QtyOrd/PGQty * (CASE UOMOrd WHEN 'TON' THEN 2000 ELSE 1 END) * (CASE Reversal WHEN 1 THEN -1 ELSE 1 END))
	FROM cftFeedOrder fo
	WHERE Status <> 'C' AND Status <>'X'
	Group by PigGroupID, RoomNbr





