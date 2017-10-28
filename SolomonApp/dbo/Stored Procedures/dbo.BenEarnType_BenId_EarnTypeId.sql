 Create Proc  BenEarnType_BenId_EarnTypeId @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select * from BenEarnType
           where BenId       LIKE  @parm1
             and EarnTypeId  LIKE  @parm2
           order by BenId,
                    EarnTypeId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenEarnType_BenId_EarnTypeId] TO [MSDSL]
    AS [dbo];

