 Create Proc  W2Federal_DEL_EmpId_LE_CalYr @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Delete w2federal from W2Federal
           where EmpId  LIKE  @parm1
             and CalYr  <=    @parm2


