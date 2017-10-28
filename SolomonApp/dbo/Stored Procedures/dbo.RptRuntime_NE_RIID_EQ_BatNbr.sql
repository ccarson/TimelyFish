 Create Proc  RptRuntime_NE_RIID_EQ_BatNbr @parm1 smallint, @parm2 varchar ( 10) as
       Select * from RptRuntime
           where RptRuntime.RI_ID   <>  @parm1
             and RptRuntime.BatNbr  =   @parm2
           order by RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RptRuntime_NE_RIID_EQ_BatNbr] TO [MSDSL]
    AS [dbo];

