 /****** Object:  Stored Procedure dbo.ItemBMIHist_Delete    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.ItemBMIHist_Delete    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemBMIHist_Delete @parm1 varchar ( 30), @parm2 varchar ( 10) , @parm3 varchar ( 4) As
        Delete itemBMIhist from ItemBMIhist
                where  invtid = @parm1
                and siteid = @parm2
                and Fiscyr > @parm3


