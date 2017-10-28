 Create Proc  Update_Ledger_BaseCuryid @parm1 varchar ( 4) as
Update ledger Set BaseCuryID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Ledger_BaseCuryid] TO [MSDSL]
    AS [dbo];

