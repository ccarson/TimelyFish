 Create Proc  UnionDeduct_DedId_Delete @parm1 varchar (10) as
           Delete UnionDeduct from UnionDeduct Where DedId = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UnionDeduct_DedId_Delete] TO [MSDSL]
    AS [dbo];

