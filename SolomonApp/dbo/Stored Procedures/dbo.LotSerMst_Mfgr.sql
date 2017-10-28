 /****** Object:  Stored Procedure dbo.LotSerMst_Mfgr    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerMst_Mfgr    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerMst_Mfgr @parm1 varchar ( 30), @parm2 varchar (25) as
    Select * from LotSerMst where InvtId like @parm1
                  and MfgrLotSerNbr like @parm2
                  order by MfgrLotSerNbr


