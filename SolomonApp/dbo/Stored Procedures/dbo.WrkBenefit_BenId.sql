 Create Proc  WrkBenefit_BenId @parm1 varchar ( 10) as
       Select * from WrkBenefit
           where BenId  =  @parm1
           order by BenId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkBenefit_BenId] TO [MSDSL]
    AS [dbo];

