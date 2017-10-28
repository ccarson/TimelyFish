 /****** Object:  Stored Procedure dbo.CustomFtr_FeatureNbr    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.CustomFtr_FeatureNbr    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc CustomFtr_FeatureNbr @parm1 varchar ( 30), @parm2 varchar ( 4) as
        Select * from CustomFtr where InvtID = @parm1 and
                FeatureNbr = @parm2
                order by InvtID, FeatureNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustomFtr_FeatureNbr] TO [MSDSL]
    AS [dbo];

