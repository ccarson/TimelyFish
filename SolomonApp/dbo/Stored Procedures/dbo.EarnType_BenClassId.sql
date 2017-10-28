 Create Proc  EarnType_BenClassId @parm1 varchar ( 10) as
       Select * from EarnType
           where BenClassId  =  @parm1
           order by BenClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnType_BenClassId] TO [MSDSL]
    AS [dbo];

