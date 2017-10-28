
/********************* REVISIONS **********************
Date       User        Ref     Description
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
12/14/06   dkillion    Bug71   Split the receipts column into two columns - usage and receipts. Usage contains all negative 
values, receipts contains all of the positive values. Also renamed the depricated view from cfvInventoryReconDate to 
cfvInventoryReconDateOld.
 
****************** END REVISIONS *********************/

CREATE   VIEW dbo.cfvInventoryReconDate

 AS

	SELECT     
	tr.InvtId, 
	tr.SiteID, 
	tr.TranDate,
	Usage = SUM(CASE tr.trantype WHEN 'AJ' THEN 0 ELSE (CASE WHEN (tr.CnvFact * tr.Qty * tr.InvtMult) < 0 THEN 
(tr.CnvFact * tr.Qty * tr.InvtMult) ELSE 0 END) END), 
	Receipts = SUM(CASE tr.trantype WHEN 'AJ' THEN 0 ELSE (CASE WHEN (tr.CnvFact * tr.Qty * tr.InvtMult) > 0 THEN 
(tr.CnvFact * tr.Qty * tr.InvtMult) ELSE 0 END) END), 
	Adjustments = SUM(CASE tr.TranType WHEN 'AJ' THEN (tr.Qty * tr.CnvFact * tr.InvtMult) ELSE 0 END)
FROM
	dbo.InTran tr JOIN
	dbo.Inventory invt ON tr.InvtId = invt.INvtId
WHERE
	invt.ClassID IN ('RATION', 'CORN', 'ING', 'FGM') AND tr.Rlsed = '1'
	Group by tr.InvtId, tr.Trandate, tr.SiteID
	




