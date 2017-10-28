 /****** Object:  Stored Procedure dbo.ReasonCode_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.ReasonCode_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc ReasonCode_All @parm1 varchar ( 6) as
        Select * from ReasonCode where ReasonCd like @parm1
                order by ReasonCd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ReasonCode_All] TO [MSDSL]
    AS [dbo];

