 Create Proc  BenRateTable_BenId @parm1 varchar ( 10) as
       Select * from BenRateTable
           where BenId      LIKE  @parm1
           order by BenId         ,
                    MonthsEmp DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenRateTable_BenId] TO [MSDSL]
    AS [dbo];

