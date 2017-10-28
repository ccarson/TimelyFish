 Create Proc  EarnType_Id2 @parm1 varchar ( 10) as
       Select * from EarnType
           where Id  LIKE  @parm1

           order by Id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnType_Id2] TO [MSDSL]
    AS [dbo];

