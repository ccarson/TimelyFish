 /****** Object:  Stored Procedure dbo.RptExtra_Cleanup    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.RptExtra_Cleanup    Script Date: 4/7/98 12:56:04 PM ******/
Create Proc RptExtra_Cleanup @parm1 varchar ( 47), @parm2 varchar ( 21) as
       Delete rptextra from RptExtra where UserId = @parm1 And
                                  ComputerName = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RptExtra_Cleanup] TO [MSDSL]
    AS [dbo];

