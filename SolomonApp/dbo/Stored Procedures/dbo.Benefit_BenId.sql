 Create Proc  Benefit_BenId @parm1 varchar ( 10) as
       Select * from Benefit
           where BenId LIKE @parm1
           order by BenId


