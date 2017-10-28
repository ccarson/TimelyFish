
/****** Object:  View dbo.cfvServDispatch    Script Date: 5/27/2005 4:39:41 PM ******/


CREATE  VIEW dbo.cfvInventoryCheck
AS

--*************************************************************
--	Purpose: 
--	Author: Eric Lind
--	Date: 
--	Usage:  Report ServDispatch
--	
--*************************************************************

SELECT QTYWO.*, QTYOH.QtyOnHand
FROM
	(SELECT
	   SC.Lupd_User,
	--   SC.InvoiceHandling,
	   SC.cmbCODInvoice,
	   SD.SiteID,
	   SD.InvtId,
	-- SC.InvoiceStatus,
	   Sum(SD.Quantity) AS QtyOnWorkOrders
	
	FROM  smServCall SC 
	JOIN smServDetail SD on SD.ServiceCallID = SC.ServiceCallID
	JOIN Inventory I on I.InvtID = SD.InvtID
	WHERE sc.InvoiceHandling = 'A'
	AND sc.cmbCODInvoice IN ('I', 'P')
	AND i.ClassID <> 'EX'
	GROUP BY SC.Lupd_User, SD.SiteID, SD.InvtID, SC.cmbCODInvoice) QTYWO

LEFT JOIN ItemSite QTYOH ON (QTYWO.InvtId = QTYOH.InvtID) AND (QTYWO.SiteID = QTYOH.SiteID)



