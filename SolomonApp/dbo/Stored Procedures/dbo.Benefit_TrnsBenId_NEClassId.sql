 Create Proc  Benefit_TrnsBenId_NEClassId @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select * from Benefit
           where TrnsBenId  =   @parm1
             and ClassId    <>  @parm2
           order by BenId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Benefit_TrnsBenId_NEClassId] TO [MSDSL]
    AS [dbo];

