 Create Proc  BenEmp_EmpId_BenId_ @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select *, case when Benefit.AccrLiab <> 0
                     then (BenEmp.BYBegBal+BenEmp.BYTDAccr-BenEmp.BYTDUsed)
                     else 0
                end,
                (BenEmp.BYBegBal+BenEmp.BYTDAvail-BenEmp.BYTDUsed)
         from BenEmp
			left outer join Benefit
				on BenEmp.BenId = Benefit.BenId
           where BenEmp.EmpId  =     @parm1
             and BenEmp.BenId  LIKE  @parm2
           order by BenEmp.EmpId,
                    BenEmp.BenId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenEmp_EmpId_BenId_] TO [MSDSL]
    AS [dbo];

