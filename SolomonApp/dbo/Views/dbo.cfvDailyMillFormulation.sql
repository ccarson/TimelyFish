CREATE VIEW cfvDailyMillFormulation
-------------------------------------------------------------------------
-- CREATED BY: TJones
-- CREATED ON: 8/22/05
-- Description: Used to provide a daily snapshot of ingredient qty
-- 		usage by created ration id. 
-- USED BY:
-- NOTE: This view is dependent upon INTran data, so archival/deletion
--	  of INTran delete will effectively remove the corresponding
--	  configuration history.
-------------------------------------------------------------------------
AS
select SiteID, ProductionDate = trandate, InvtIDRation = user1, InvtIDIng = invtid, IngQty = Sum(qty * -1 ), 
	IngQtyPerLbOfRation = Round(Sum(qty * -1 )/(Select Sum(qty) 
			FROM INTran 
			WHERE SiteID = i.SiteID AND TranDate = i.TranDate AND 
			InvtID = i.User1 AND ReasonCd = 'RA'),4),
	RationQty = (Select Sum(qty) 
			FROM INTran 
			WHERE SiteID = i.SiteID AND TranDate = i.TranDate AND 
			InvtID = i.User1 AND ReasonCd = 'RA')
	from intran i
	where 
	crtd_prog = 'XF130'
	AND User1 <> ''
	AND User1 <> InvtID
	AND ReasonCd = 'RA'
	GROUP BY SiteID, trandate, user1, invtid
