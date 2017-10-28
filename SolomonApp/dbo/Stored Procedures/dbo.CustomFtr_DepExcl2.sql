 /****** Object:  Stored Procedure dbo.CustomFtr_DepExcl2    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.CustomFtr_DepExcl2    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc CustomFtr_DepExcl2 @parm1 varchar ( 30), @parm2 varchar ( 4), @parm3 varchar ( 1), @parm4 smallint as
        Select * from FtrDepExcl where InvtID = @parm1 and
                FeatureNbr = @parm2 and DEType = @parm3 and DepExclFtr = @parm4
                order by InvtID, FeatureNbr, DEType, DepExclFtr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustomFtr_DepExcl2] TO [MSDSL]
    AS [dbo];

