 CREATE PROCEDURE WOMatlReq_Inventory_ItemSite_WONbr_Task_LineRef
   @WONbr         	varchar( 16 ),
   @Task          	varchar( 32 ),
   @LineRef		varchar( 5 )
AS
   SELECT      		W.WONbr, W.Invtid, W.SiteID, W.WhseLoc, W.Sequence, W.SpecificCostID, W.QtyWOReqd, W.QtyRemaining, W.DateReqd, W.StockUsage, W.QtyStd, W.UnitCost,
			W.LineRef, W.LUpd_DateTime, W.LUpd_Prog, W.LUpd_Time, W.LUpd_User,
			I.ValMthd, I.InvtType, I.Source, I.TranStatusCode,
			S.LeadTime, S.MfgLeadTime
   FROM        		WOMatlReq W (NoLock) LEFT JOIN Inventory I (NoLock)
               		ON W.InvtID = I.InvtID
			LEFT JOIN ItemSite S (NoLock)
			ON W.InvtID = S.InvtID
			and W.SiteID = S.SiteID
   WHERE       		W.WONbr = @WONbr and
               		W.Task = @Task and
               		W.LineRef LIKE @LineRef

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


