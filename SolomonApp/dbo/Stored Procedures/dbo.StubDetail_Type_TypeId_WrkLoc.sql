 Create Proc  StubDetail_Type_TypeId_WrkLoc @parm1 varchar ( 1), @parm2 varchar ( 10), @parm3 varchar ( 6) as
       Select * from StubDetail
           where StubType      LIKE  @parm1
             and TypeId    LIKE  @parm2
             and WrkLocId  LIKE  @parm3
           order by Acct, Sub, ChkNbr, DocType, StubType DESC, TypeId, WrkLocId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StubDetail_Type_TypeId_WrkLoc] TO [MSDSL]
    AS [dbo];

