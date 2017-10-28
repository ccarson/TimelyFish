 Create Proc DDBank_All @parm1 varchar ( 6) as
    Select * from DDBank where BankID like @parm1 ORDER by BankID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDBank_All] TO [MSDSL]
    AS [dbo];

