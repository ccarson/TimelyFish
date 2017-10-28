 Create Proc  StubDetail_ActSubCNbrDTypeType @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10), @parm4 varchar ( 2), @parm5 varchar ( 1) as
       Select * from StubDetail
           where Acct     LIKE  @parm1
             and Sub      LIKE  @parm2
             and ChkNbr   LIKE  @parm3
             and DocType  LIKE  @parm4
             and StubType     LIKE  @parm5
           order by Acct, Sub, ChkNbr, DocType, StubType DESC, TypeId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StubDetail_ActSubCNbrDTypeType] TO [MSDSL]
    AS [dbo];

