 Create Proc  W2StateLocal_EmpId_CalYr_ @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Select * from W2StateLocal
           where EmpId  LIKE  @parm1
             and CalYr  LIKE  @parm2
           order by EmpId        ,
                    CalYr        ,
                    State        ,
                    SLType     DESC,
                    EntityId


