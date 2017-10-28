 Create Proc  Deduction_Union @parm1 varchar ( 4), @parm2 varchar ( 10), @parm3 varchar ( 10) as
    select * from Deduction where
                  CalYr       = @parm1 and
                  Union_cd like @parm2 and
                  DedId    like @parm3
             order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_Union] TO [MSDSL]
    AS [dbo];

