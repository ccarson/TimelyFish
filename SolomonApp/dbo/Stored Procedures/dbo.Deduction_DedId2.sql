 Create Proc  Deduction_DedId2 @parm1 varchar ( 4), @parm2 varchar ( 10) as
       Select * from Deduction
           where CalYr = @parm1
             and DedId like @parm2
           order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_DedId2] TO [MSDSL]
    AS [dbo];

