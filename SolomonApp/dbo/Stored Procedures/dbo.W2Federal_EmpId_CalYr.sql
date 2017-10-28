 Create Proc  W2Federal_EmpId_CalYr @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Select * from W2Federal
           where EmpId  LIKE  @parm1
             and CalYr  LIKE  @parm2
           order by EmpId,
                    CalYr


