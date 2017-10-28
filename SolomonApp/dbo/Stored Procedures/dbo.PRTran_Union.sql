 Create Proc  PRTran_Union @parm1 varchar ( 10) as
    select * from PRTran where
                  Union_cd like @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_Union] TO [MSDSL]
    AS [dbo];

