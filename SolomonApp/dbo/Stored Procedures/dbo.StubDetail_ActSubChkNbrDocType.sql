 Create Proc  StubDetail_ActSubChkNbrDocType @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10), @parm4 varchar ( 2) as
       Select * from StubDetail
           where Acct     LIKE  @parm1
             and Sub      LIKE  @parm2
             and ChkNbr   LIKE  @parm3
             and DocType  LIKE  @parm4
           order by Acct, Sub, ChkNbr, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StubDetail_ActSubChkNbrDocType] TO [MSDSL]
    AS [dbo];

