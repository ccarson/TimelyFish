 /****** Object:  Stored Procedure dbo.Item_CustomFtr_FeatureNbr    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Item_CustomFtr_FeatureNbr    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Item_CustomFtr_FeatureNbr @parm1 varchar ( 30), @parm2 varchar ( 4) as
        Select * from CustomFtr where InvtID = @parm1 and
                FeatureNbr like @parm2
                order by InvtID, FeatureNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Item_CustomFtr_FeatureNbr] TO [MSDSL]
    AS [dbo];

