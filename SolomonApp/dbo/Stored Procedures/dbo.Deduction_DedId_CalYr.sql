 Create Proc Deduction_DedId_CalYr @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Select * from Deduction
           where DedId like @parm1
             and CalYr like @parm2
           order by DedId, CalYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Deduction_DedId_CalYr] TO [MSDSL]
    AS [dbo];

