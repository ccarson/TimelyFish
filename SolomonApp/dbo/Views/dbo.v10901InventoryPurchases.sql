CREATE  view [dbo].[v10901InventoryPurchases]
AS
--------------------------------------------------------------------------------------------------------
-- PURPOSE:		This view is utilized in the Inventory Purchases Report
-- CREATED BY:	??
-- CREATED ON: ??
-- MODIFIED ON: 4/4/2012 - Boyer & Associates (TJones) - as part of the SL 2011 upgrade testing
--------------------------------------------------------------------------------------------------------
SELECT po.PODate,po.VendID, po.VendName, pd.*, i.descr, pj.project_desc 
	FROM purchord PO (NOLOCK)
	INNER JOIN PurOrdDet PD (NOLOCK) ON po.PONbr = pd.ponbr
	INNER JOIN Inventory I (NOLOCK) ON pd.invtid = I.invtid
	LEFT OUTER JOIN pjproj PJ (NOLOCK) ON po.projectid = pj.project
