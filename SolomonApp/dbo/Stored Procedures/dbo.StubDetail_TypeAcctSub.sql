 Create Proc  StubDetail_TypeAcctSub @parm1 varchar ( 1), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10), @parm5 varchar ( 2) as
       Select * from StubDetail
           where StubType =  @parm1
          and Acct     = @parm2
            and Sub      = @parm3
             and ChkNbr   = @parm4
             and DocType  LIKE @parm5
           order by StubType, Acct, Sub, ChkNbr, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StubDetail_TypeAcctSub] TO [MSDSL]
    AS [dbo];

