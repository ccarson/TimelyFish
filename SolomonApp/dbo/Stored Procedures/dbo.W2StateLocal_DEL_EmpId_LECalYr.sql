 Create Proc  W2StateLocal_DEL_EmpId_LECalYr @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Delete w2statelocal from W2StateLocal
           where EmpId  LIKE  @parm1
             and CalYr  <=    @parm2


