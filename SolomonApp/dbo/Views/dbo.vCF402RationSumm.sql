
CREATE VIEW vCF402RationSumm 

	AS

--*************************************************************
--	Purpose:Ration Summary Report
--	Author: Boyer & Associates--LRF
--	Date: 8/31/04
--	Usage:Report CF402RationSummary 
--	Parms:
--*************************************************************

Select 
Status,
Type = prodlineid,
InvtID = invtidOrd,
MillID,
DateSched,
Qty = sum(qtyord)

from cftFeedOrder, inventoryadg

where inventoryadg.invtid = cftFeedOrder.invtidOrd
and prodlineid in ('MASH','PELL')

group by status, prodlineid, invtidord, millid, datesched





 