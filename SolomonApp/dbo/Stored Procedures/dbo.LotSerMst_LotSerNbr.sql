 /****** Object:  Stored Procedure dbo.LotSerMst_LotSerNbr    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerMst_LotSerNbr @parm1 varchar ( 30), @parm2 varchar (10) , @parm3 varchar (10) as
    Select * from LotSerMst where InvtId = @parm1
                  and SiteId = @parm2
                  and WhseLoc = @parm3
                  and Status = 'A'
	          and QtyAlloc < QtyOnHand
                  order by InvtId, LotSerNbr


