 /****** Object:  Stored Procedure dbo.InTran_LotSert_Balance    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.InTran_LotSert_Balance    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc InTran_LotSert_Balance @parm1 varchar ( 10) as
-- @parm1 = Batch Number
    select InTran.KitID,
           InTran.InvtId,
           LotSerT_Qty = Case
             When sum(LotSerT.Qty) Is Null Then 0
             Else Sum(LotSerT.Qty)
           End,
           InTran.Qty
         From InTran
              Left Outer Join LotSerT
                on  InTran.Batnbr = LotSert.BatNbr
                and InTran.KitID = lotSert.KitID
                and InTran.LineId = LotSerT.INTranLineId
              Join Inventory
                on  InTran.InvtId = Inventory.InvtId
         Where InTran.BatNbr = @parm1
           and SubString(Inventory.LotSerTrack,1,1) IN ('S', 'L')
         Group by InTran.BatNbr, InTran.KitID, InTran.InvtId, InTran.Qty
         Having InTran.Qty <> Sum(LotSerT.Qty)
           Or  Sum(LotSerT.Qty) = Null



GO
GRANT CONTROL
    ON OBJECT::[dbo].[InTran_LotSert_Balance] TO [MSDSL]
    AS [dbo];

