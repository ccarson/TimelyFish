 Create Proc  Deduction_DedType_DedId @parm1 varchar ( 4), @parm2 varchar ( 1), @parm3 varchar ( 10) as
       Select * from Deduction
           where CalYr = @parm1
             and DedType  LIKE  @parm2
             and DedId    LIKE  @parm3
           order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_DedType_DedId] TO [MSDSL]
    AS [dbo];

