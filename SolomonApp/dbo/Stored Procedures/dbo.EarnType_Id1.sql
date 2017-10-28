 Create Proc  EarnType_Id1 @parm1 varchar ( 10) as
       Select * from EarnType
           where Id  LIKE  @parm1
             and ETType <> 'G'
           order by Id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnType_Id1] TO [MSDSL]
    AS [dbo];

