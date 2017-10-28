 Create Proc  BenRateTable_ExactBenId @parm1 varchar ( 10) as
       Select * from BenRateTable
           where BenId      =  @parm1
           order by BenId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenRateTable_ExactBenId] TO [MSDSL]
    AS [dbo];

