 Create Proc  ValWorkLocDed_DedId_Delete @parm1 varchar ( 10) as
           Delete ValWorkLocDed from ValWorkLocDed Where DedId = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ValWorkLocDed_DedId_Delete] TO [MSDSL]
    AS [dbo];

