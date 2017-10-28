 /****** Object:  Stored Procedure dbo.CustomFtr_All    Script Date: 7/13/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.CustomFtr_All    Script Date: 7/13/98 7:41:51 PM ******/
Create Proc CustomFtr_All @parm1 varchar ( 30), @parm2 varchar ( 4) as
        Select * from CustomFtr where InvtID = @parm1 and
                FeatureNbr like @parm2
                order by  FeatureNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustomFtr_All] TO [MSDSL]
    AS [dbo];

