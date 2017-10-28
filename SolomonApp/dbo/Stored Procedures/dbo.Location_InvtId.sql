 /****** Object:  Stored Procedure dbo.Location_InvtId    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Location_InvtId    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Location_InvtId @parm1 varchar ( 30) as
        Select * from Location where InvtId = @parm1
                    order by InvtId, SiteId, WhseLoc


