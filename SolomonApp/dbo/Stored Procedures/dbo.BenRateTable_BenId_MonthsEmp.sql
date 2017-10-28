 Create Proc  BenRateTable_BenId_MonthsEmp @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
       Select * from BenRateTable
           where BenId      =        @parm1
             and MonthsEmp  BETWEEN  @parm2beg and @parm2end
           order by BenId,
                    MonthsEmp



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenRateTable_BenId_MonthsEmp] TO [MSDSL]
    AS [dbo];

