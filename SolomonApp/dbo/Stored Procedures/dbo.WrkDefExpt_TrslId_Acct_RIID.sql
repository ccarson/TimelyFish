 Create Procedure WrkDefExpt_TrslId_Acct_RIID @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 smallint as
Select * from WrkDefExpt
Where TrslId = @parm1
and   Acct   = @parm2
and   RI_ID  = @parm3
Order by TrslId, Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkDefExpt_TrslId_Acct_RIID] TO [MSDSL]
    AS [dbo];

