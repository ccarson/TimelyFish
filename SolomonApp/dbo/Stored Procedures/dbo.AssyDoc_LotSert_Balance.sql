 /****** Object:  Stored Procedure dbo.AssyDoc_LotSert_Balance    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.AssyDoc_LotSert_Balance    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc AssyDoc_LotSert_Balance @parm1 varchar ( 10) as
-- @parm1 = Batch Number
    select AssyDoc.KitId,
           LotSerT_Qty = Case
             When Sum(LotSerT.Qty) Is Null Then 0
             Else Sum(LotSerT.Qty)
           End,
           AssyDoc.KitCntr
         From AssyDoc
              Left Outer Join LotSerT
                on  AssyDoc.Batnbr = LotSert.BatNbr
                and '' = LotSert.KitID
                and AssyDoc.KitId = LotSerT.InvtId
                and 0 = LotSerT.INTranLineId
              Join Inventory
                on  AssyDoc.KitId = Inventory.InvtId
         Where AssyDoc.BatNbr = @parm1
           and SubString(Inventory.LotSerTrack,1,1) IN ('S', 'L')
         Group by AssyDoc.BatNbr, AssyDoc.KitId, AssyDoc.KitCntr
         Having AssyDoc.KitCntr <> Sum(LotSerT.Qty)
           Or  Sum(LotSerT.Qty) = Null


