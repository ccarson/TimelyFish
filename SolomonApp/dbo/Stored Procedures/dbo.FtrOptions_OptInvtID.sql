 /****** Object:  Stored Procedure dbo.FtrOptions_OptInvtID    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.FtrOptions_OptInvtID    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc FtrOptions_OptInvtID @parm1 varchar  (  30), @parm2 varchar ( 4), @parm3 varchar ( 30) as
        Select * from FtrOptions where InvtID = @parm1 and
                FeatureNbr = @parm2 and OptInvtID LIKE @parm3
                order by InvtID, FeatureNbr, OptInvtID


