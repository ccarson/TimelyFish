 Create Proc  StubDetail_DEL_ActSubChkDocTyp @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10), @parm4 varchar ( 2) as
       Delete stubdetail from StubDetail
           where Acct     =  @parm1
             and Sub      =  @parm2
             and ChkNbr   =  @parm3
             and DocType  =  @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StubDetail_DEL_ActSubChkDocTyp] TO [MSDSL]
    AS [dbo];

