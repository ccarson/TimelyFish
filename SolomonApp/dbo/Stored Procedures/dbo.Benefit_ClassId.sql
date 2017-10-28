 Create Proc  Benefit_ClassId @parm1 varchar ( 10) as
       Select * from Benefit
           where ClassId  LIKE  @parm1
           order by BenId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Benefit_ClassId] TO [MSDSL]
    AS [dbo];

