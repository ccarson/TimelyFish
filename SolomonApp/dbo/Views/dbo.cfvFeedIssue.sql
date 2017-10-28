
CREATE  VIEW cfvFeedIssue
	AS
---------------------------------------------------------------------------------------
-- PURPOSE:Used for submitting Feed Ration data to Agrimetrics
-- CREATED BY: TJONES
-- CREATED ON: 9/1/05
-- USED BY: FIN ANALYSTS
---------------------------------------------------------------------------------------
	select ft.Description, c.contactname, i.cpnyid, i.invtid, i.siteid, Qty = 
	CASE i.UnitDesc when 'LB' THEN
		CASE TranType when 'RI' then
			i.qty * -1
		ELSE
			i.qty
		END
	ELSE
		CASE TranType when 'RI' THEN
			i.qty * -1 * 2000
		ELSE
			i.qty * 2000
		END
	END,
	TranAmt = CASE TranType WHEN 'RI' THEN i.tranamt * -1 ELSE i.tranamt END, 
	i.trandate, i.perpost, i.trantype, i.projectid, i.taskid
		from intran i
		JOIN Inventory inv ON i.InvtID = inv.InvtID
		LEFT JOIN cftFeedOrder fo ON fo.OrdNbr = i.RefNbr
		LEFT JOIN cftSite s ON fo.ContactID = s.ContactID
		LEFT JOIN cftContact c ON fo.ContactID = c.ContactID
		LEFT JOIN cftFacilityType ft ON s.FacilityTypeID = ft.FacilityTypeID
		where inv.ClassID = 'RATION' AND TranType <> 'CT'



 