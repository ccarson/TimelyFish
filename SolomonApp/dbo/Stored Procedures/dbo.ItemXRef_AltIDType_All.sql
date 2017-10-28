 /****** Object:  Stored Procedure dbo.ItemXRef_AltIDType_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.ItemXRef_AltIDType_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc ItemXRef_AltIDType_All @parm1 varchar ( 1) as
            Select * from ItemXRef where AltIDType like @parm1
                order by InvtID


