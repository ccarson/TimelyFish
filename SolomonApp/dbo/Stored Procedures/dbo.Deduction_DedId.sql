 Create Proc  Deduction_DedId @parm1 varchar ( 10) as
       Select * from Deduction
           where DedId like @parm1
           order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_DedId] TO [MSDSL]
    AS [dbo];

