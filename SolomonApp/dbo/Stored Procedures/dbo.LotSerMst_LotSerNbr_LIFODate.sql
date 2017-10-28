 /****** Object:  Stored Procedure dbo.LotSerMst_LotSerNbr_LIFODate    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerMst_LotSerNbr_LIFODate    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerMst_LotSerNbr_LIFODate @parm1 varchar ( 30), @parm2 varchar (10), @parm3 varchar (10) as
    Select * from LotSerMst where InvtId = @parm1
                  and SiteId = @parm2
                  and WhseLoc = @parm3
                  and Status = 'A'
                  order by InvtId, LIFOdate desc, LotSerNbr desc


