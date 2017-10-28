 Create Proc Deduction_DedSeq @parm1 varchar ( 10), @parm2 smallint as
        Select * from Deduction
           where DedType = 'X'
             and DedId <> @parm1
             and DedSequence = @parm2
           order by DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_DedSeq] TO [MSDSL]
    AS [dbo];

