 Create Proc  Deduction_Union2 @parm1 varchar ( 10) as
    select * from Deduction where
                  Union_cd like @parm1
             order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_Union2] TO [MSDSL]
    AS [dbo];

