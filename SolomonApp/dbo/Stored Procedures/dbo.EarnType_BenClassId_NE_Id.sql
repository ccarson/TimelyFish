 Create Proc  EarnType_BenClassId_NE_Id @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select * from EarnType
           where BenClassId  LIKE  @parm1
             and Id          <>    @parm2
           order by BenClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnType_BenClassId_NE_Id] TO [MSDSL]
    AS [dbo];

