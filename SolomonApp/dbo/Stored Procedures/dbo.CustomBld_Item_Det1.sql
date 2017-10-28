 /****** Object:  Stored Procedure dbo.CustomBld_Item_Det1    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.CustomBld_Item_Det1    Script Date: 4/16/98 7:41:51 PM ******/
Create proc CustomBld_Item_Det1 @parm1 varchar (2), @parm2 varchar (10), @parm3 varchar ( 4), @parm4 varchar(30) as
        Select * from CustomBld where Source = @parm1 and
                OrderNbr = @parm2 and ParFtrNbr = @parm3 and
                ParOptInvtID = @parm4
            order by Source, OrderNbr, ParFtrNbr, ParOptInvtID


