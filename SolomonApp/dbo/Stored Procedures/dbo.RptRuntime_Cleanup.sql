 Create Proc RptRuntime_Cleanup @parm1 varchar ( 47), @parm2 varchar ( 21) as
       Delete rptruntime from RptRuntime where rptruntime.UserId = @parm1 And
                                    rptruntime.ComputerName like @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RptRuntime_Cleanup] TO [MSDSL]
    AS [dbo];

