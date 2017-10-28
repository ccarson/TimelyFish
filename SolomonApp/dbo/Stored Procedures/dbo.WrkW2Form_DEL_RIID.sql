 Create Proc  WrkW2Form_DEL_RIID @parm1 smallint as
       Delete wrkw2form from WrkW2Form
           where RI_ID  =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkW2Form_DEL_RIID] TO [MSDSL]
    AS [dbo];

