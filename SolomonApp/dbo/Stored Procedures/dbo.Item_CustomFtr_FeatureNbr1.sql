 /****** Object:  Stored Procedure dbo.Item_CustomFtr_FeatureNbr1    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Item_CustomFtr_FeatureNbr1    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Item_CustomFtr_FeatureNbr1 @parm1 varchar ( 30)as
        Select * from CustomFtr where InvtID Like @parm1
                order by InvtID, FeatureNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Item_CustomFtr_FeatureNbr1] TO [MSDSL]
    AS [dbo];

