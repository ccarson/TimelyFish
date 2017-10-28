CREATE  VIEW cfvFeedOrderWithStatusCalcs
	AS
---------------------------------------------------------------------------------------
-- PURPOSE: Simplify logic for order lookup when dealing with delivered vs. undelivered
-- CREATED BY: TJONES
-- CREATED ON: 9/1/05
-- USED BY: XF120
---------------------------------------------------------------------------------------
SELECT ContactID,
	InvtID = CASE Status WHEN 'C' THEN InvtIDDel ELSE InvtIDOrd END,
	MillID,
	OrdOrDelvDate = CASE Status WHEN 'C' THEN DateDel ELSE DateReq END,
	OrdNbr,PGQty,PigGroupID,
	Qty = (CASE Status WHEN 'C' THEN QtyDel ELSE QtyOrd * (CASE UOMOrd WHEN 'TON' THEN 2000 ELSE 1 END) END) * (CASE Reversal WHEN 1 THEN -1 ELSE 1 END),
	RoomNbr,StageOrd 
	FROM cftFeedOrder fo
	WHERE Status <> 'X'
